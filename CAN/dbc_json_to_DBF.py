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
        for signal in message['signals']:
            if signal["length"] == 1:
                data_type = "B"
            else:
                data_type = "U"
            
            # Handle multiplex signals
            multiplex_info = ""
            if signal.get("multiplex") is not None:
                multiplex_info = f",M{signal['multiplex']}"
            elif signal.get("name") and signal["name"].lower() in ["multiplex", "mux"]:
                # This is the multiplexor signal itself
                multiplex_info = ",m"
            
            f_DBF.write("[START_SIGNALS] {},{},{},{},{},{},{},{},{},{},{}{}\n".format(
                signal['name'], 
                signal['length'], 
                int(offset/8) + 1, 
                float(offset%8), 
                data_type, 
                2**signal['length']-1, 
                0, 
                1, 
                signal["offset"], 
                signal["scale"],
                signal["units"],
                multiplex_info
            ))
            offset += int(signal['length'])
        f_DBF.write("[END_MSG]\n\n")
