#!/usr/bin/env python3
"""
Battery Discharge Test Script using Electronic Load
Uses PyVISA to control an electronic load and discharge a battery pack
"""

import sys
import time
import pyvisa
from datetime import datetime
from tkinter import Tk, Label, Entry, Button, StringVar, Frame, messagebox, ttk

class BatteryDischargeGUI:
    def __init__(self, master):
        self.master = master
        master.title("Battery Discharge Test")
        master.geometry("700x550")
        master.resizable(False, False)

        # Variables
        self.discharge_voltage = StringVar(value="3.0")
        self.discharge_current = StringVar(value="1.0")
        self.ocv_voltage = StringVar(value="--")
        self.instantaneous_voltage = StringVar(value="--")
        self.current_current = StringVar(value="--")
        self.total_energy = StringVar(value="0.000")
        self.total_ah = StringVar(value="0.000")
        self.elapsed_time = StringVar(value="00:00:00")
        self.status = StringVar(value="Disconnected")

        # Electronic load connection
        self.eload = None
        self.rm = None
        self.is_discharging = False
        self.update_job = None

        # OCV measurement tracking
        self.last_ocv_check = 0
        self.ocv_check_interval = 10.0  # 10 seconds between OCV checks
        self.ocv_pause_time = 1.0  # 1 second pause for OCV measurement
        self.final_ocv_pause_time = 5.0  # 5 second pause for final check
        self.in_ocv_pause = False
        self.checking_final_voltage = False

        # Energy tracking
        self.accumulated_energy_wh = 0.0  # Watt-hours
        self.accumulated_ah = 0.0  # Amp-hours
        self.discharge_start_time = 0
        self.total_pause_time = 0  # Track time spent paused
        self.pause_start_time = 0
        self.last_energy_update = 0
        self.last_ocv_for_energy = 0.0
        self.last_current_for_energy = 0.0

        self._create_widgets()
        self._connect_to_eload()

    def _create_widgets(self):
        # Title
        title = Label(self.master, text="Battery Discharge Controller",
                     font=("Arial", 16, "bold"))
        title.pack(pady=10)

        # Configuration Frame
        config_frame = Frame(self.master)
        config_frame.pack(pady=10, padx=20, fill="x")

        Label(config_frame, text="Discharge Final Voltage (V):",
              font=("Arial", 10)).grid(row=0, column=0, sticky="e", padx=5, pady=5)
        Entry(config_frame, textvariable=self.discharge_voltage,
              width=15, font=("Arial", 10)).grid(row=0, column=1, padx=5, pady=5)

        Label(config_frame, text="Discharge Current (A):",
              font=("Arial", 10)).grid(row=1, column=0, sticky="e", padx=5, pady=5)
        Entry(config_frame, textvariable=self.discharge_current,
              width=15, font=("Arial", 10)).grid(row=1, column=1, padx=5, pady=5)

        # Separator
        ttk.Separator(self.master, orient="horizontal").pack(fill="x", pady=10)

        # Display Frame
        display_frame = Frame(self.master)
        display_frame.pack(pady=10, padx=20, fill="x")

        Label(display_frame, text="Open Circuit Voltage (V):",
              font=("Arial", 11, "bold")).grid(row=0, column=0, sticky="e", padx=5, pady=6)
        Label(display_frame, textvariable=self.ocv_voltage,
              font=("Arial", 11), fg="blue", width=15,
              relief="sunken", bd=2).grid(row=0, column=1, padx=5, pady=6)

        Label(display_frame, text="Instantaneous Voltage (V):",
              font=("Arial", 11, "bold")).grid(row=1, column=0, sticky="e", padx=5, pady=6)
        Label(display_frame, textvariable=self.instantaneous_voltage,
              font=("Arial", 11), fg="purple", width=15,
              relief="sunken", bd=2).grid(row=1, column=1, padx=5, pady=6)

        Label(display_frame, text="Current (A):",
              font=("Arial", 11, "bold")).grid(row=2, column=0, sticky="e", padx=5, pady=6)
        Label(display_frame, textvariable=self.current_current,
              font=("Arial", 11), fg="green", width=15,
              relief="sunken", bd=2).grid(row=2, column=1, padx=5, pady=6)

        Label(display_frame, text="Total Energy (Wh):",
              font=("Arial", 11, "bold")).grid(row=3, column=0, sticky="e", padx=5, pady=6)
        Label(display_frame, textvariable=self.total_energy,
              font=("Arial", 11), fg="red", width=15,
              relief="sunken", bd=2).grid(row=3, column=1, padx=5, pady=6)

        Label(display_frame, text="Total Capacity (Ah):",
              font=("Arial", 11, "bold")).grid(row=4, column=0, sticky="e", padx=5, pady=6)
        Label(display_frame, textvariable=self.total_ah,
              font=("Arial", 11), fg="orange", width=15,
              relief="sunken", bd=2).grid(row=4, column=1, padx=5, pady=6)

        Label(display_frame, text="Elapsed Time:",
              font=("Arial", 11, "bold")).grid(row=5, column=0, sticky="e", padx=5, pady=6)
        Label(display_frame, textvariable=self.elapsed_time,
              font=("Arial", 11), fg="brown", width=15,
              relief="sunken", bd=2).grid(row=5, column=1, padx=5, pady=6)

        # Status
        status_frame = Frame(self.master)
        status_frame.pack(pady=10)

        Label(status_frame, text="Status:", font=("Arial", 10)).pack(side="left")
        Label(status_frame, textvariable=self.status,
              font=("Arial", 10, "bold"), fg="orange").pack(side="left", padx=5)

        # Separator
        ttk.Separator(self.master, orient="horizontal").pack(fill="x", pady=10)

        # Control Buttons
        button_frame = Frame(self.master)
        button_frame.pack(pady=10)

        self.start_button = Button(button_frame, text="Start Discharge",
                                   command=self._start_discharge,
                                   font=("Arial", 12), bg="green", fg="white",
                                   width=15, height=2)
        self.start_button.pack(side="left", padx=10)

        self.stop_button = Button(button_frame, text="Stop Discharge",
                                  command=self._stop_discharge,
                                  font=("Arial", 12), bg="red", fg="white",
                                  width=15, height=2, state="disabled")
        self.stop_button.pack(side="left", padx=10)

        self.reset_button = Button(button_frame, text="Reset Counters",
                                   command=self._reset_counters,
                                   font=("Arial", 12), bg="gray", fg="white",
                                   width=15, height=2)
        self.reset_button.pack(side="left", padx=10)

    def _connect_to_eload(self):
        """Connect to the electronic load via VISA"""
        try:
            self.rm = pyvisa.ResourceManager()
            resources = self.rm.list_resources()

            if not resources:
                self.status.set("No VISA devices found")
                messagebox.showwarning("Connection Error",
                    "No VISA devices found. Please check connections.")
                return

            # Try to connect to the first available resource
            # Adjust the resource string as needed for your specific e-load
            for resource in resources:
                try:
                    self.eload = self.rm.open_resource(resource)
                    self.eload.timeout = 5000  # 5 second timeout

                    # Query identification
                    idn = self.eload.query("*IDN?").strip()
                    self.status.set(f"Connected: {idn[:30]}...")

                    # Initialize e-load
                    self._initialize_eload()

                    # Start periodic updates
                    self._update_readings()
                    break

                except Exception as e:
                    continue

            if self.eload is None:
                self.status.set("Failed to connect")
                messagebox.showerror("Connection Error",
                    "Could not connect to any electronic load.")

        except Exception as e:
            self.status.set("VISA Error")
            messagebox.showerror("VISA Error",
                f"Error initializing VISA: {str(e)}")

    def _initialize_eload(self):
        """Initialize the electronic load settings"""
        try:
            # Reset to known state
            self.eload.write("*RST")
            time.sleep(0.5)

            # Set to constant current mode
            self.eload.write("MODE CC")

            # Turn off the load initially
            self.eload.write("INP OFF")

        except Exception as e:
            messagebox.showerror("Initialization Error",
                f"Error initializing e-load: {str(e)}")

    def _update_readings(self):
        """Periodically update voltage and current readings"""
        if self.eload is None:
            return

        try:
            # Read instantaneous voltage (most e-loads use MEAS:VOLT? command)
            voltage_str = self.eload.query("MEAS:VOLT?").strip()
            voltage = float(voltage_str)
            self.instantaneous_voltage.set(f"{voltage:.3f}")

            # Read current (most e-loads use MEAS:CURR? command)
            current_str = self.eload.query("MEAS:CURR?").strip()
            current = float(current_str)
            self.current_current.set(f"{current:.3f}")

            # Update energy integration and time during discharge
            if self.is_discharging and not self.in_ocv_pause and not self.checking_final_voltage:
                self._update_energy(current)
                self._update_elapsed_time()

            # Handle OCV measurement cycle during discharge
            if self.is_discharging:
                current_time = time.time()

                # Check if it's time for OCV measurement
                if not self.in_ocv_pause and not self.checking_final_voltage:
                    if current_time - self.last_ocv_check >= self.ocv_check_interval:
                        self._start_ocv_measurement()

        except Exception as e:
            print(f"Error reading values: {str(e)}")

        # Schedule next update (every 500ms)
        self.update_job = self.master.after(500, self._update_readings)

    def _update_energy(self, current):
        """Update accumulated energy and amp-hours using OCV and current"""
        current_time = time.time()

        # Use the last measured OCV for energy calculation
        ocv_str = self.ocv_voltage.get()
        if ocv_str == "--":
            return  # No OCV measurement yet

        ocv = float(ocv_str)

        # Calculate time delta since last update
        if self.last_energy_update > 0:
            delta_time_hours = (current_time - self.last_energy_update) / 3600.0

            # Calculate average power using OCV
            # P = V * I, where V is the open-circuit voltage
            power_watts = ocv * current

            # Integrate energy: E = P * dt
            energy_increment_wh = power_watts * delta_time_hours
            self.accumulated_energy_wh += energy_increment_wh

            # Integrate amp-hours: Ah = I * dt
            ah_increment = current * delta_time_hours
            self.accumulated_ah += ah_increment

            # Update displays
            self.total_energy.set(f"{self.accumulated_energy_wh:.3f}")
            self.total_ah.set(f"{self.accumulated_ah:.3f}")

        self.last_energy_update = current_time
        self.last_ocv_for_energy = ocv
        self.last_current_for_energy = current

    def _update_elapsed_time(self):
        """Update elapsed time display"""
        if self.discharge_start_time > 0:
            # Calculate elapsed time excluding pause periods
            current_pause = self.total_pause_time
            if self.pause_start_time > 0:
                # Currently paused, add current pause duration
                current_pause += (time.time() - self.pause_start_time)

            elapsed_seconds = int(time.time() - self.discharge_start_time - current_pause)
            hours = elapsed_seconds // 3600
            minutes = (elapsed_seconds % 3600) // 60
            seconds = elapsed_seconds % 60
            self.elapsed_time.set(f"{hours:02d}:{minutes:02d}:{seconds:02d}")

    def _start_ocv_measurement(self):
        """Pause discharge and measure open-circuit voltage"""
        try:
            # Turn off the load
            self.eload.write("INP OFF")
            self.in_ocv_pause = True
            self.status.set("Measuring OCV...")

            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Pausing for OCV measurement")

            # Schedule voltage measurement after pause
            self.master.after(int(self.ocv_pause_time * 1000), self._measure_ocv)

        except Exception as e:
            print(f"Error starting OCV measurement: {str(e)}")
            self.in_ocv_pause = False
            self._resume_discharge()

    def _measure_ocv(self):
        """Measure OCV and check if target reached"""
        try:
            # Read open-circuit voltage
            voltage_str = self.eload.query("MEAS:VOLT?").strip()
            ocv = float(voltage_str)
            self.ocv_voltage.set(f"{ocv:.3f}")

            target_voltage = float(self.discharge_voltage.get())

            # Log OCV with energy and time
            energy_str = self.total_energy.get()
            ah_str = self.total_ah.get()
            time_str = self.elapsed_time.get()
            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"OCV: {ocv:.3f}V (target: {target_voltage}V), "
                  f"Energy: {energy_str}Wh, Capacity: {ah_str}Ah, Time: {time_str}")

            # Check if we've reached target voltage
            if ocv <= target_voltage:
                if not self.checking_final_voltage:
                    # First time reaching target - do final 5-second check
                    print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                          f"Target reached. Starting final {self.final_ocv_pause_time}s check...")
                    self.checking_final_voltage = True
                    self.status.set("Final voltage check...")

                    # Schedule final measurement after 5 seconds
                    self.master.after(int(self.final_ocv_pause_time * 1000), self._final_voltage_check)
                else:
                    # Already in final check - should not reach here
                    pass
            else:
                # Voltage above target - resume discharge
                self._resume_discharge()

        except Exception as e:
            print(f"Error measuring OCV: {str(e)}")
            self._resume_discharge()

    def _final_voltage_check(self):
        """Perform final voltage measurement after extended pause"""
        try:
            # Read final open-circuit voltage
            voltage_str = self.eload.query("MEAS:VOLT?").strip()
            final_ocv = float(voltage_str)
            self.ocv_voltage.set(f"{final_ocv:.3f}")

            target_voltage = float(self.discharge_voltage.get())

            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Final OCV measured: {final_ocv:.3f}V (target: {target_voltage}V)")

            if final_ocv <= target_voltage:
                # Discharge complete
                self._discharge_complete()
            else:
                # Voltage recovered above target - continue discharge
                print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                      f"Voltage recovered above target. Resuming discharge...")
                self.checking_final_voltage = False
                self._resume_discharge()

        except Exception as e:
            print(f"Error in final voltage check: {str(e)}")
            self._discharge_complete()

    def _resume_discharge(self):
        """Resume discharge after OCV measurement"""
        try:
            if not self.is_discharging:
                return

            # Turn load back on
            self.eload.write("INP ON")
            self.in_ocv_pause = False
            self.last_ocv_check = time.time()
            self.status.set("Discharging...")

            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Discharge resumed")

        except Exception as e:
            print(f"Error resuming discharge: {str(e)}")

    def _start_discharge(self):
        """Start the battery discharge process"""
        if self.eload is None:
            messagebox.showerror("Error", "Electronic load not connected")
            return

        try:
            # Validate inputs
            target_voltage = float(self.discharge_voltage.get())
            discharge_current = float(self.discharge_current.get())

            if target_voltage <= 0 or discharge_current <= 0:
                messagebox.showerror("Invalid Input",
                    "Voltage and current must be positive values")
                return

            # Check current voltage (use instantaneous if OCV not yet measured)
            current_v_str = self.ocv_voltage.get()
            if current_v_str == "--":
                current_v_str = self.instantaneous_voltage.get()

            if current_v_str != "--":
                current_v = float(current_v_str)
                if current_v <= target_voltage:
                    messagebox.showerror("Error",
                        f"Current voltage ({current_v}V) is already below target ({target_voltage}V)")
                    return
            else:
                current_v = 0.0

            # Confirm with user
            voltage_display = f"Current voltage: {current_v}V\n" if current_v > 0 else ""
            response = messagebox.askyesno("Confirm Discharge",
                f"Start discharge at {discharge_current}A until {target_voltage}V?\n\n"
                f"{voltage_display}"
                f"This will discharge the battery. Continue?")

            if not response:
                return

            # Set current level
            self.eload.write(f"CURR {discharge_current}")
            time.sleep(0.1)

            # Turn on the load
            self.eload.write("INP ON")

            # Update UI and tracking variables
            self.is_discharging = True
            self.last_ocv_check = time.time()
            self.in_ocv_pause = False
            self.checking_final_voltage = False

            # Initialize time tracking if first start
            if self.discharge_start_time == 0:
                self.discharge_start_time = time.time()

            # Resume from pause - account for pause time
            if self.pause_start_time > 0:
                self.total_pause_time += (time.time() - self.pause_start_time)
                self.pause_start_time = 0

            # Reset energy update timer
            self.last_energy_update = time.time()

            self.status.set("Discharging...")
            self.start_button.config(state="disabled")
            self.stop_button.config(state="normal")

            # Log start
            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Discharge started: {discharge_current}A until {target_voltage}V")
            print(f"OCV check interval: {self.ocv_check_interval}s, "
                  f"pause time: {self.ocv_pause_time}s, "
                  f"final check pause: {self.final_ocv_pause_time}s")

        except ValueError:
            messagebox.showerror("Invalid Input",
                "Please enter valid numeric values")
        except Exception as e:
            messagebox.showerror("Error",
                f"Error starting discharge: {str(e)}")

    def _stop_discharge(self):
        """Stop the battery discharge process"""
        if self.eload is None:
            return

        try:
            # Turn off the load
            self.eload.write("INP OFF")

            # Update UI and tracking variables
            self.is_discharging = False
            self.in_ocv_pause = False
            self.checking_final_voltage = False

            # Mark pause start time for elapsed time calculation
            self.pause_start_time = time.time()

            self.status.set("Stopped")
            self.start_button.config(state="normal")
            self.stop_button.config(state="disabled")

            # Log stop with current values
            energy_str = self.total_energy.get()
            ah_str = self.total_ah.get()
            time_str = self.elapsed_time.get()
            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Discharge stopped by user. Energy: {energy_str}Wh, "
                  f"Capacity: {ah_str}Ah, Time: {time_str}")

            messagebox.showinfo("Stopped",
                f"Discharge stopped\n\n"
                f"Energy: {energy_str}Wh\n"
                f"Capacity: {ah_str}Ah\n"
                f"Time: {time_str}\n\n"
                f"Counters preserved. Click 'Reset Counters' to clear.")

        except Exception as e:
            messagebox.showerror("Error",
                f"Error stopping discharge: {str(e)}")

    def _discharge_complete(self):
        """Handle discharge completion"""
        try:
            # Ensure load is off
            self.eload.write("INP OFF")

            # Update UI and tracking variables
            self.is_discharging = False
            self.in_ocv_pause = False
            self.checking_final_voltage = False

            # Mark pause start time for potential resume
            self.pause_start_time = time.time()

            self.status.set("Complete")
            self.start_button.config(state="normal")
            self.stop_button.config(state="disabled")

            # Get final values
            final_voltage = self.ocv_voltage.get()
            final_energy = self.total_energy.get()
            final_ah = self.total_ah.get()
            final_time = self.elapsed_time.get()

            # Log completion
            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Discharge complete. Final OCV: {final_voltage}V, "
                  f"Energy: {final_energy}Wh, Capacity: {final_ah}Ah, Time: {final_time}")

            messagebox.showinfo("Discharge Complete",
                f"Battery discharge complete!\n\n"
                f"Final OCV: {final_voltage}V\n"
                f"Total Energy: {final_energy}Wh\n"
                f"Total Capacity: {final_ah}Ah\n"
                f"Elapsed Time: {final_time}\n\n"
                f"Counters preserved. Click 'Reset Counters' to clear.")

        except Exception as e:
            messagebox.showerror("Error",
                f"Error completing discharge: {str(e)}")

    def _reset_counters(self):
        """Reset all energy, capacity, and time counters"""
        if self.is_discharging:
            messagebox.showwarning("Cannot Reset",
                "Please stop the discharge before resetting counters.")
            return

        response = messagebox.askyesno("Reset Counters",
            "Are you sure you want to reset all counters?\n\n"
            "This will clear:\n"
            "- Total Energy\n"
            "- Total Capacity\n"
            "- Elapsed Time")

        if response:
            self.accumulated_energy_wh = 0.0
            self.accumulated_ah = 0.0
            self.discharge_start_time = 0
            self.total_pause_time = 0
            self.pause_start_time = 0
            self.last_energy_update = 0
            self.total_energy.set("0.000")
            self.total_ah.set("0.000")
            self.elapsed_time.set("00:00:00")

            print(f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                  f"Counters reset by user")

            messagebox.showinfo("Reset Complete", "All counters have been reset to zero.")

    def close(self):
        """Clean up on window close"""
        # Cancel update job
        if self.update_job is not None:
            self.master.after_cancel(self.update_job)

        # Stop discharge if running
        if self.is_discharging:
            try:
                self.eload.write("INP OFF")
            except:
                pass

        # Close connections
        if self.eload is not None:
            try:
                self.eload.close()
            except:
                pass

        if self.rm is not None:
            try:
                self.rm.close()
            except:
                pass

        self.master.destroy()

def main():
    root = Tk()
    app = BatteryDischargeGUI(root)
    root.protocol("WM_DELETE_WINDOW", app.close)
    root.mainloop()

if __name__ == "__main__":
    main()
