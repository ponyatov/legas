/// @defgroup vm vm

/// @defgroup command command
/// @ingroup vm
/// @{

/// @brief @ref vm command opcode
enum class Op {
    nop = 0x00,   ///< @ref nop
    halt = 0xFF,  //?< @ref halt
};

extern void nop();   ///< `( -- )` empty command: do nothing
extern void halt();  ///< `( -- )` stop system
/// @}
