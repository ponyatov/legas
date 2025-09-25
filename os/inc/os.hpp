/// @defgroup os os
/// @ingroup cross
#pragma once

#include "libc.hpp"
#include "main.hpp"

#ifdef LINUX
#include "linux.hpp"
#endif  // LINUX

#ifdef WIN32
#include "win32.hpp"
#endif
