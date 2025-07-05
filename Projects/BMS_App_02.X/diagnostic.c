#include "diagnostic.h"
#include "IO.h"
#include "can_iso_tp_lite.h"
#include "stdbool.h"

static bool running = false;

void dianostic_run(void){
    running = true;
}

void dianostic_halt(void){
    running = false;
}

void diagnostic_HandleIO(){
    if (running){
        if (isoTP_peekCommand() != ISO_TP_NONE){
            isoTP_command_S thisCommand = isoTP_getCommand();
            switch(thisCommand.payload[0]){
                case 0xC:
                    switch(thisCommand.payload[1]){
                        case 0:
                            thisCommand.payload[2];
                            break;
                        default:
                            break;
                    }
                default:
                    break;


            }
        }
    }
}
