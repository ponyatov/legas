// https://os.phil-opp.com/ru/
// https://docs.rust-embedded.org/embedonomicon/smallest-no-std.html

// disable standard library
#![no_std]
// disables runtime init
#![no_main]
#![allow(internal_features)]
#![feature(lang_items)]

/// stack roll back
#[lang = "eh_personality"]
extern "C" fn eh_personality() {}

use core::panic::PanicInfo;
use core::sync::atomic;
use core::sync::atomic::Ordering;

/// panic handler
#[inline(never)]
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {
        atomic::compiler_fence(Ordering::SeqCst);
    }
}

/// system entry point
#[no_mangle]
// the name must be `_start`
pub extern "C" fn _start() -> ! {
    loop {}
}
