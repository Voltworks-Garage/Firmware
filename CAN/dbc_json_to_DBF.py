import json


file = './dbc.json' #easygui.fileopenbox("select json dbc file", default='C:\\Repos\\E_Moto\\Firmware\\CAN\\dbc.json')

dbc_dict = json.load(open(file))

f_DBF = open('./emoto.dbf', 'w')

f_DBF.write("//******************************BUSMASTER Messages and signals Database ******************************//\n\n")
f_DBF.write("[DATABASE_VERSION] 1.3\n\n")
f_DBF.write("[PROTOCOL] CAN\n\n")
f_DBF.write("[BUSMASTER_VERSION] [3.2.2]\n\n")
num_mess = 0
for node in dbc_dict["NODE"]:
    for message in node['messages']:
        num_mess += 1
f_DBF.write("[NUMBER_OF_MESSAGES] {}\n\n".format(num_mess))

base_address = 0x1

for node in dbc_dict["NODE"]:

    for message in node['messages']:
        id = message["id"]
        if id is None:
            id = base_address
            base_address +=1
        f_DBF.write("[START_MSG] {}_{},{},{},{},{},{}\n".format(node['name'], message['name'], id, "8", len(message['signals']), 1, "X" if message.get("x_id") else "S"))
        offset = 0
        multiplex_offset = 0  # Separate offset for multiplex signals
        for signal in message['signals']:
            if signal["length"] == 1:
                data_type = "B"
            else:
                data_type = "U"
            
            # Handle multiplex signals
            multiplex_info = ""
            is_multiplexor = signal.get("name") and signal["name"].lower() in ["multiplex", "mux"]
            is_multiplexed = signal.get("multiplex") is not None
            
            if is_multiplexed:
                multiplex_info = f",M{signal['multiplex']}"
                # For multiplexed signals, use multiplex_offset and reset for each new multiplex group
                if signal['multiplex'] == 0:
                    multiplex_offset = 4  # Start after the 4-bit multiplexor signal
                current_offset = multiplex_offset
            elif is_multiplexor:
                multiplex_info = ",m"
                current_offset = offset
            else:
                current_offset = offset
            
            f_DBF.write("[START_SIGNALS] {},{},{},{},{},{},{},{},{},{},{}{}\n".format(
                signal['name'], 
                signal['length'], 
                int(current_offset/8) + 1, 
                float(current_offset%8), 
                data_type, 
                2**signal['length']-1, 
                0, 
                1, 
                signal["offset"], 
                signal["scale"],
                signal["units"],
                multiplex_info
            ))
            
            # Only advance offset for non-multiplexed signals or multiplexor
            if not is_multiplexed:
                offset += int(signal['length'])
            elif is_multiplexed and signal['multiplex'] == 0:
                # Advance multiplex_offset only for M0 signals to establish the pattern
                multiplex_offset += int(signal['length'])
        f_DBF.write("[END_MSG]\n\n")
