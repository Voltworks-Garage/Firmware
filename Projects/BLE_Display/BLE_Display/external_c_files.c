// Wrapper to include the generated CAN decoder implementation
// This allows Arduino IDE to compile the external C files

// Include DBC generated files
// Note: dash_dbc.c will find utils.h via the redirect in local utils.h
#include "../../../Libraries/Standard/utils.c"
#include "../../../CAN/generated/dash_dbc.c"
