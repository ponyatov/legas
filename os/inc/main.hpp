#pragma once

#include "os.hpp"

/// @defgroup main main
/// @{

/// @brief POSIX entry point
/// @param[in] argc arguments count
/// @param[in] argv arguments array (`argv[0]` = program/firmware name)
extern int main(int argc, char *argv[]);

/// @brief callback for processing command line / boot loader arguments
/// @param[in] argc argument index (0 = program/firmware name)
/// @param[in] argv argument string value
extern void arg(int argc, char *argv);

/// @brief first call: callback on system startup
extern void setup();

/// @brief application event loop callback
extern void loop();

/// @}
