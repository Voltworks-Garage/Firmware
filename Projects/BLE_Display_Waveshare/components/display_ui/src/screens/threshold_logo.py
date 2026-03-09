"""
Threshold logo.h RGB565 pixel data to true black and white,
with optional width padding and height cropping.

Replaces all pixel values in the Voltworks_Garage array with either
LOGO_FG or LOGO_BG defines, so the colors can be changed easily.

Usage: python threshold_logo.py [--pad-width N] [--crop-height N] [threshold_hex]
  threshold_hex:   RGB565 threshold value (default: 0x8000)
                   Pixels below this become LOGO_FG, at or above become LOGO_BG.
  --pad-width N:   Pad image symmetrically to N pixels wide with LOGO_BG.
  --crop-height N: Crop image symmetrically to N pixels tall (removes from top/bottom).
"""

import re
import sys
import os

INPUT_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "logo.h")
OUTPUT_FILE = INPUT_FILE  # overwrite in place

VALS_PER_LINE = 25  # number of values per line in output array

FG_NAME = "LOGO_FG"
BG_NAME = "LOGO_BG"
FG_DEFAULT = "0x0000"
BG_DEFAULT = "0xFFFF"


def parse_args():
    threshold = 0x8000
    pad_width = None
    crop_height = None
    args = sys.argv[1:]
    i = 0
    while i < len(args):
        if args[i] == "--pad-width":
            pad_width = int(args[i + 1])
            i += 2
        elif args[i] == "--crop-height":
            crop_height = int(args[i + 1])
            i += 2
        else:
            threshold = int(args[i], 16)
            i += 1
    return threshold, pad_width, crop_height


def threshold_value(val_str, threshold):
    val = int(val_str, 16)
    return FG_NAME if val < threshold else BG_NAME


def main():
    threshold, pad_width, crop_height = parse_args()

    with open(INPUT_FILE, "r") as f:
        content = f.read()

    # Find the LAST array match to skip commented-out arrays
    matches = list(re.finditer(
        r"(static\s+const\s+uint16_t\s+Voltworks_Garage\s*\[\s*\]\s*=\s*\{)",
        content,
    ))
    if not matches:
        print("ERROR: Could not find active Voltworks_Garage array")
        sys.exit(1)
    array_match = matches[-1]
    array_start = array_match.start()

    # Find the closing brace
    brace_depth = 0
    array_end = None
    for i in range(array_match.end() - 1, len(content)):
        if content[i] == "{":
            brace_depth += 1
        elif content[i] == "}":
            brace_depth -= 1
            if brace_depth == 0:
                array_end = i + 1
                break

    if array_end is None:
        print("ERROR: Could not find end of array")
        sys.exit(1)

    semi_pos = content.index(";", array_end)
    array_section = content[array_start : semi_pos + 1]

    # Parse array values - handle both hex values and LOGO_FG/LOGO_BG tokens
    hex_values = re.findall(r"0x[0-9a-fA-F]{4}", array_section)
    token_values = re.findall(r"LOGO_(?:FG|BG)", array_section)

    if hex_values and not token_values:
        # Raw hex data - threshold it
        print(f"Found {len(hex_values)} hex pixel values")
        unique_before = len(set(hex_values))
        print(f"Unique values before threshold: {unique_before}")
        pixels = [threshold_value(v, threshold) for v in hex_values]
        fg_count = pixels.count(FG_NAME)
        bg_count = pixels.count(BG_NAME)
        print(f"After threshold (0x{threshold:04X}): {fg_count} FG, {bg_count} BG")
    elif token_values:
        # Already thresholded - use tokens directly
        pixels = token_values
        print(f"Found {len(pixels)} already-thresholded pixel values")
    else:
        print("ERROR: No pixel data found in array")
        sys.exit(1)

    # Read current dimensions (use LAST match to skip commented-out old defines)
    width_matches = list(re.finditer(r"#define\s+VOLTWORKS_GARAGE_WIDTH\s+(\d+)", content))
    height_matches = list(re.finditer(r"#define\s+VOLTWORKS_GARAGE_HEIGHT\s+(\d+)", content))
    width_match = width_matches[-1] if width_matches else None
    height_match = height_matches[-1] if height_matches else None
    if not width_match or not height_match:
        print("ERROR: Could not find WIDTH/HEIGHT defines")
        sys.exit(1)

    cur_width = int(width_match.group(1))
    cur_height = int(height_match.group(1))
    print(f"Current dimensions: {cur_width}x{cur_height}")

    if len(pixels) != cur_width * cur_height:
        print(f"WARNING: pixel count {len(pixels)} != {cur_width}x{cur_height}={cur_width*cur_height}")

    # Pad width if requested
    new_width = cur_width
    if pad_width and pad_width > cur_width:
        total_pad = pad_width - cur_width
        pad_left = total_pad // 2
        pad_right = total_pad - pad_left
        print(f"Padding: {pad_left}px left + {pad_right}px right -> {pad_width}px wide")

        padded = []
        for row in range(cur_height):
            row_start = row * cur_width
            row_data = pixels[row_start : row_start + cur_width]
            padded.extend([BG_NAME] * pad_left)
            padded.extend(row_data)
            padded.extend([BG_NAME] * pad_right)
        pixels = padded
        new_width = pad_width
        print(f"New dimensions: {new_width}x{cur_height}, {len(pixels)} pixels")

    # Crop height if requested
    new_height = cur_height
    if crop_height and crop_height < cur_height:
        rows_to_remove = cur_height - crop_height
        crop_top = rows_to_remove // 2
        crop_bottom = rows_to_remove - crop_top
        print(f"Cropping: {crop_top}px top + {crop_bottom}px bottom -> {crop_height}px tall")

        cropped = []
        for row in range(crop_top, cur_height - crop_bottom):
            row_start = row * new_width
            cropped.extend(pixels[row_start : row_start + new_width])
        pixels = cropped
        new_height = crop_height
        print(f"New dimensions: {new_width}x{new_height}, {len(pixels)} pixels")

    # Build the new array content
    lines = []
    for i in range(0, len(pixels), VALS_PER_LINE):
        chunk = pixels[i : i + VALS_PER_LINE]
        lines.append("  " + ", ".join(chunk))

    new_array_body = ",\n".join(lines)
    new_array = f"static const uint16_t Voltworks_Garage[]  = {{\n{new_array_body}\n}};"

    # Build everything before the array
    before_array = content[:array_start]

    # Update dimension defines if changed
    if new_width != cur_width:
        before_array = before_array.replace(
            f"#define VOLTWORKS_GARAGE_WIDTH {cur_width}",
            f"#define VOLTWORKS_GARAGE_WIDTH {new_width}",
        )
    if new_height != cur_height:
        before_array = before_array.replace(
            f"#define VOLTWORKS_GARAGE_HEIGHT {cur_height}",
            f"#define VOLTWORKS_GARAGE_HEIGHT {new_height}",
        )
    if new_width != cur_width or new_height != cur_height:
        new_size = new_width * new_height * 2
        before_array = re.sub(
            r"// array size is \d+",
            f"// array size is {new_size}",
            before_array,
        )

    # Add color defines if not already present
    if FG_NAME not in before_array:
        color_defines = f"#define {FG_NAME} {FG_DEFAULT}\n#define {BG_NAME} {BG_DEFAULT}\n\n"
        before_array = before_array.rstrip("\n") + "\n\n" + color_defines

    # Build everything after the array
    after_array = content[semi_pos + 1 :]

    output = before_array + new_array + after_array

    with open(OUTPUT_FILE, "w") as f:
        f.write(output)

    print(f"Written to {OUTPUT_FILE}")


if __name__ == "__main__":
    main()
