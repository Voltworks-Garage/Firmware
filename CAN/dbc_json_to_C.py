# -*- coding: utf-8 -*-
"""
Created on Sun Nov 13 18:12:47 2016

@author: kid group
"""

import json
import os

directory = "./generated"

if not os.path.exists(directory):
    os.makedirs(directory)
    

try:
    with open('dbc.json') as data_file:    
        data = json.load(data_file)
except:
    print("dbc json error found, press enter to quit.")
    s = input();
    quit();
print("CAN DBC file successfully found.\n")



numberOfNodes = len(data["NODE"])
for node in range(0,numberOfNodes):
    send_message_dict = {}
    print("Generating dbc.h and dbc.c for " + str(data["NODE"][node]["name"]))
    thisNode = node
    hfile = "generated/" + str(data["NODE"][node]["name"]).lower() + "_dbc.h"
    cfile = "generated/" + str(data["NODE"][node]["name"]).lower() + "_dbc.c"
    dot_h = open(hfile,'w')
    dot_c = open(cfile,'w')

    #Headers and Includes
    dot_h.write("#ifndef "+str(data["NODE"][node]["name"]) +"_DBC_H\n")
    dot_h.write("#define "+str(data["NODE"][node]["name"]) +"_DBC_H\n\n")
    dot_h.write("#include <stdint.h>\n")
    dot_c.write("#include \""+str(data["NODE"][node]["name"]) + "_dbc.h\"\n")
    dot_c.write("#include \"CAN.h\"\n")
    dot_c.write("#include \"utils.h\"\n")

    #find number of CAN nodes and create enum
    numberOfNodes = len(data["NODE"])
    dot_h.write("typedef enum{\n")
    for i in range(0,numberOfNodes):
        dot_h.write("    " + str(data["NODE"][i]["name"]) + ",\n")
    dot_h.write("} CAN_nodes_E;\n\n")

    #loop through each Node and Parse each message
    for i in range(0,numberOfNodes):
        this_node_name = data["NODE"][i]["name"]
        #create a comment header for each Node
        dot_h.write("/**********************************************************\n")
        dot_h.write(" * " + this_node_name + " NODE MESSAGES\n */\n")
        dot_c.write("/**********************************************************\n")
        dot_c.write(" * " + this_node_name + " NODE MESSAGES\n */\n")
        numberOfMessages = len(data["NODE"][i]["messages"])
        print("Node " + this_node_name + " has " + str(numberOfMessages) + " messages")

        #loop through each message for a given Node.
        for j in range(0, numberOfMessages):
            this_message_name = data["NODE"][i]["messages"][j]["name"]
            this_message_freq = data["NODE"][i]["messages"][j]["freq"]
            this_message_id = data["NODE"][i]["messages"][j]["id"]
            if i == thisNode:
                pass
            # add messages if node is a consumer, or if the consumer field doesn't exist.
            elif not data["NODE"][i]["messages"][j].get("consumers"):
                pass
            elif data["NODE"][thisNode]["name"] in data["NODE"][i]["messages"][j].get("consumers"):
                pass
            else:
                continue

            dot_h.write("#define CAN_{}_{}_interval() {}\n".format(this_node_name, this_message_name, this_message_freq))

            #define the CAN ID
            ID_name = "CAN_" + this_node_name + "_" + this_message_name
            dot_c.write("#define " + ID_name + "_ID " + hex(this_message_id) + "\n\n")
            if data["NODE"][i]["messages"][j].get("x_id"):
                canXID = data["NODE"][i]["messages"][j].get("x_id")
            else:
                canXID = 0

            print("\t" + this_message_name)
            payload_init = ".payload = 0"
            if i == thisNode:
                dot_c.write("static CAN_payload_S " + ID_name + "_payload __attribute__((aligned(sizeof(CAN_payload_S))));\n")
                payload_init = ".payload = &" + ID_name + "_payload"

            dot_c.write("static CAN_message_S " + ID_name + "={\n")
            dot_c.write("\t.canID = " + ID_name + "_ID" + ",\n\t.canXID = " + str(canXID) + ",\n\t.dlc = 8,\n\t" + payload_init
                        + ",\n\t.canMessageStatus = 0\n};\n\n")
            if i != thisNode:
                dot_c.write("uint8_t " + ID_name + "_checkDataIsFresh(void){\n\treturn CAN_checkDataIsFresh(&" + ID_name + ");\n}\n")


            #loop through each signal and parse the data
            numberOfSignals = len(data["NODE"][i]["messages"][j]["signals"])
            multiplex_signal = None
            
            # First pass: identify multiplex signal
            for k in range(0,numberOfSignals):
                signal = data["NODE"][i]["messages"][j]["signals"][k]
                signal_name = signal["name"]
                if signal_name.lower() in ["multiplex", "mux", "multiplexor"]:
                    multiplex_signal = signal_name
                    break
            
            # For multiplexed messages, we need to calculate offsets differently
            # Group signals by mux value and calculate shared offsets
            if multiplex_signal:
                # Group signals by mux value
                mux_groups = {}
                non_mux_signals = []
                
                for k in range(0, numberOfSignals):
                    signal = data["NODE"][i]["messages"][j]["signals"][k]
                    if signal["name"].lower() in ["multiplex", "mux", "multiplexor"]:
                        non_mux_signals.append((k, signal))
                    elif signal.get("multiplex") is not None:
                        mux_val = signal["multiplex"]
                        if mux_val not in mux_groups:
                            mux_groups[mux_val] = []
                        mux_groups[mux_val].append((k, signal))
                    else:
                        non_mux_signals.append((k, signal))
                
                # Calculate offsets for non-mux signals first
                offset = 0
                for k, signal in non_mux_signals:
                    signal["bitOffset"] = offset
                    signal_define_name = signal["name"].upper()
                    dot_c.write(
                        "#define " + ID_name.upper() + "_" + signal_define_name + "_RANGE " + str(signal["length"]) + "\n")
                    dot_c.write(
                        "#define " + ID_name.upper() + "_" + signal_define_name + "_OFFSET " + str(offset) + "\n")
                    offset += signal["length"]
                    print("\t\t" + signal["name"])
                
                # Calculate shared offsets for each mux group (they all start after non-mux signals)
                mux_start_offset = offset
                for mux_val, signal_list in mux_groups.items():
                    offset = mux_start_offset  # Reset offset for each mux group
                    for k, signal in signal_list:
                        signal["bitOffset"] = offset
                        signal_define_name = f"M{mux_val}_{signal['name'].upper()}"
                        dot_c.write(
                            "#define " + ID_name.upper() + "_" + signal_define_name + "_RANGE " + str(signal["length"]) + "\n")
                        dot_c.write(
                            "#define " + ID_name.upper() + "_" + signal_define_name + "_OFFSET " + str(offset) + "\n")
                        offset += signal["length"]
                        print("\t\t" + signal["name"])
                
                # Set final offset to the maximum used
                max_offset = mux_start_offset
                for mux_val, signal_list in mux_groups.items():
                    mux_offset = mux_start_offset
                    for k, signal in signal_list:
                        mux_offset += signal["length"]
                    max_offset = max(max_offset, mux_offset)
                offset = max_offset
            else:
                # Non-multiplexed message - original logic
                offset = 0
                for k in range(0,numberOfSignals):
                    this_signal_name = data["NODE"][i]["messages"][j]["signals"][k]["name"]
                    this_signal_length = data["NODE"][i]["messages"][j]["signals"][k]["length"]
                    this_signal_bit_offset = data["NODE"][i]["messages"][j]["signals"][k]["bitOffset"] = offset
                    
                    signal_define_name = this_signal_name.upper()
                    
                    dot_c.write(
                        "#define " + ID_name.upper() + "_" + signal_define_name + "_RANGE " + str(this_signal_length) + "\n")
                    dot_c.write(
                        "#define " + ID_name.upper() + "_" + signal_define_name + "_OFFSET " + str(offset) + "\n")
                    offset += this_signal_length
                    print("\t\t" + this_signal_name)
            # For multiplexed messages, check if we have a multiplex signal
            # If so, different mux values can use the same bit positions
            is_multiplexed_message = multiplex_signal is not None
            if offset > 64 and not is_multiplexed_message:
                s = input("ERROR: too much data in {} {}. Press any key to quit and try again. ERROR.".format(this_message_name, this_signal_name))
                quit()
            elif is_multiplexed_message:
                print(f"  Note: {this_message_name} is multiplexed - signals will share bit positions based on mux value")
            dot_c.write("\n")

            if(i == thisNode):
                #loop through signals again and create populate functions
                for k in range(0, numberOfSignals):
                    this_signal_name = data["NODE"][i]["messages"][j]["signals"][k]["name"]
                    this_signal_scale = data["NODE"][i]["messages"][j]["signals"][k]["scale"]
                    this_signal_offset = data["NODE"][i]["messages"][j]["signals"][k]["offset"]
                    this_signal_bit_offset = data["NODE"][i]["messages"][j]["signals"][k]["bitOffset"]
                    this_signal_units = data["NODE"][i]["messages"][j]["signals"][k]["units"]
                    this_signal_length = data["NODE"][i]["messages"][j]["signals"][k]["length"]
                    
                    # Handle multiplex signals with special naming
                    signal_func_name = this_signal_name
                    signal_define_name = this_signal_name.upper()
                    signal = data["NODE"][i]["messages"][j]["signals"][k]
                    if signal.get("multiplex") is not None and multiplex_signal:
                        # This is a multiplexed signal, add mux value to name
                        mux_value = signal["multiplex"]
                        signal_func_name = f"M{mux_value}_{this_signal_name}"
                        signal_define_name = f"M{mux_value}_{this_signal_name.upper()}"
                    
                    if this_signal_units in ["V", "A", "degC", "%"]:
                        this_signal_datatype = "float"
                    else:
                        this_signal_datatype = "uint16_t"
                    dot_h.write("void " + ID_name + "_" + signal_func_name
                        + "_set(" + this_signal_datatype + " " + this_signal_name + ");\n")
                    dot_c.write("void " + ID_name + "_" + signal_func_name
                        + "_set(" + this_signal_datatype + " " + this_signal_name + "){\n")
                    dot_c.write("\tuint16_t data_scaled = ({} - {}) / {};\n".format(this_signal_name, this_signal_offset, this_signal_scale))
                    # dot_c.write("\tset_bits((size_t*)"+ ID_name + ".payload, "
                    #             + ID_name.upper() + "_" + this_signal_name.upper() + "_OFFSET, "
                    #             + ID_name.upper() + "_" + this_signal_name.upper() + "_RANGE, "
                    #             + "data_scaled);\n}\n")
                    bit_offset = this_signal_bit_offset
                    bit_length = this_signal_length
                    word = bit_offset // 16
                    shift = bit_offset % 16

                    if shift + bit_length <= 16:
                        mask = ((1 << bit_length) - 1) << shift
                        dot_c.write("\t{}.payload->word{} &= ~0x{:04X};\n".format(ID_name, word, mask))
                        dot_c.write(
                            "\t{}.payload->word{} |= (data_scaled << {}) & 0x{:04X};\n}}\n".format(ID_name, word, shift, mask))
                    else:
                        bits_first = 16 - shift
                        bits_second = bit_length - bits_first
                        low_mask = ((1 << bits_first) - 1) << shift
                        high_mask = (1 << bits_second) - 1
                        dot_c.write("\t{}.payload->word{} &= ~0x{:04X};\n".format(ID_name, word, low_mask))
                        dot_c.write(
                            "\t{}.payload->word{} |= (data_scaled << {}) & 0x{:04X};\n".format(ID_name, word, shift,
                                                                                            low_mask))
                        dot_c.write("\t{}.payload->word{} &= ~0x{:04X};\n".format(ID_name, word + 1, high_mask))
                        dot_c.write("\t{}.payload->word{} |= (data_scaled >> {}) & 0x{:04X};\n}}\n".format(ID_name, word + 1,
                                                                                                    bits_first,
                                                                                                    high_mask))

                if this_message_freq:
                    if not send_message_dict.get(str(this_message_freq)):
                        send_message_dict[str(this_message_freq)] = []
                    send_message_dict[str(this_message_freq)].append("CAN_" + this_node_name + "_" + this_message_name + "_send")
            else:
                #loop through signals again and create retrieve functions
                dot_h.write("uint8_t " + ID_name + "_checkDataIsFresh(void);\n")
                for k in range(0, numberOfSignals):
                    this_signal_name = data["NODE"][i]["messages"][j]["signals"][k]["name"]
                    this_signal_scale = data["NODE"][i]["messages"][j]["signals"][k]["scale"]
                    this_signal_offset = data["NODE"][i]["messages"][j]["signals"][k]["offset"]
                    this_signal_units = data["NODE"][i]["messages"][j]["signals"][k]["units"]
                    
                    # Handle multiplex signals with special naming
                    signal_func_name = this_signal_name
                    signal_define_name = this_signal_name.upper()
                    signal = data["NODE"][i]["messages"][j]["signals"][k]
                    if signal.get("multiplex") is not None and multiplex_signal:
                        # This is a multiplexed signal, add mux value to name
                        mux_value = signal["multiplex"]
                        signal_func_name = f"M{mux_value}_{this_signal_name}"
                        signal_define_name = f"M{mux_value}_{this_signal_name.upper()}"
                    
                    if  this_signal_units in ["V", "A", "degC"]:
                        this_signal_datatype = "float"
                    else:
                        this_signal_datatype = "uint16_t"
                    dot_h.write(this_signal_datatype + " " + ID_name + "_" + signal_func_name + "_get(void);\n")
                    dot_c.write(this_signal_datatype + " " + ID_name + "_" + signal_func_name + "_get(void){\n")

                    dot_c.write("\tuint16_t data = get_bits((size_t*)CAN_" + this_node_name + "_"
                                + this_message_name + ".payload, "
                                + ID_name.upper() + "_" + signal_define_name + "_OFFSET, "
                                + ID_name.upper() + "_" + signal_define_name + "_RANGE);\n")
                    dot_c.write("\treturn (data * {}) + {};\n}}\n".format(this_signal_scale, this_signal_offset))

                dot_h.write("\n")
                dot_c.write("\n")
            if(i == thisNode):

                #finally, write the send fucntion that is called to send the meesage to the CANbus
                dot_h.write("void CAN_" + str(data["NODE"][i]["name"]) + "_" + str(
                    data["NODE"][i]["messages"][j]["name"]) + "_dlc_set(uint8_t dlc);\n\n\n")
                dot_c.write("void CAN_" + str(data["NODE"][i]["name"]) + "_" + str(
                    data["NODE"][i]["messages"][j]["name"]) + "_dlc_set(uint8_t dlc){\n")
                dot_c.write("\tCAN_" + str(data["NODE"][i]["name"]) + "_" + str(
                    data["NODE"][i]["messages"][j]["name"]) + ".dlc = dlc;\n}\n")
                dot_h.write("void CAN_" + str(data["NODE"][i]["name"]) + "_" + str(data["NODE"][i]["messages"][j]["name"]) + "_send(void);\n\n\n")
                dot_c.write("void CAN_" + str(data["NODE"][i]["name"]) + "_" + str(data["NODE"][i]["messages"][j]["name"]) + "_send(void){\n")
                dot_c.write("\tCAN_write(CAN_" + str(data["NODE"][i]["name"]) + "_" + str(data["NODE"][i]["messages"][j]["name"]) + ");\n}\n\n")

    #write the initializer function and close header guards
    dot_h.write("void CAN_DBC_init();\n\n")

    dot_c.write("void CAN_DBC_init(void) {\n")
    for i in range(0, numberOfNodes):
        if i == thisNode:
            continue
        else:
            numberOfMessages = len(data["NODE"][i]["messages"])
            for j in range(0, numberOfMessages):
                # add messages if node is a consumer, or if the consumer field doesn't exist.
                if not data["NODE"][i]["messages"][j].get("consumers"):
                    pass
                elif data["NODE"][thisNode]["name"] in data["NODE"][i]["messages"][j].get("consumers"):
                    pass
                else:
                    continue
                dot_c.write("\tCAN_configureMailbox(&CAN_" + str(data["NODE"][i]["name"]) + "_" + str(data["NODE"][i]["messages"][j]["name"]) + ");\n")
    dot_c.write("}\n")
    for send_message_freq in send_message_dict:
        dot_h.write("void CAN_send_" + send_message_freq + "ms(void);\n")
        dot_c.write("\nvoid CAN_send_" + send_message_freq + "ms(void){\n")
        for message in send_message_dict[send_message_freq]:
            dot_c.write("\t{}();\n".format(message))
        dot_c.write("}\n")
    dot_h.write("\n\n#endif /*" + str(data["NODE"][node]["name"]) + "_DBC_H*/\n")
    dot_h.close
    dot_c.close

s = input("DBC files succefully generated! press enter to quit")
quit()
