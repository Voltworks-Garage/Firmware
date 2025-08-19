# CAN code generation

After editing the json file, use the batch file to generate new .h/.c files for each ECU, and to generate a new DBF file for using BUSMaster.

## Adding Signals

### Regular Messages
To add a signal to a regular message, ensure that the total number of bits used is less than 65.

### Multiplexed Messages
To add a signal to a multiplexed message, new signals should be added by mux group, then by bit order. Each mux group can only hold 64 - mux_bits in a single group, so any new signals may need a new mux group. Try to fill each group unless specified by the user.

For example, if a message has a 2-bit multiplex field, each mux group can hold 64 - 2 = 62 bits of data. If adding signals would exceed this limit, create a new mux group.
