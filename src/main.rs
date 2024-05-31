// https://os.phil-opp.com/ru/

// disable standard library
#![no_std]
// disables runtime init
#![no_main]
//
// see https://docs.rust-embedded.org/embedonomicon/smallest-no-std.html
#![allow(internal_features)]
#![feature(lang_items)]
#[lang = "eh_personality"]
extern "C" fn eh_personality() {}

use core::panic::PanicInfo;
use core::sync::atomic;
use core::sync::atomic::Ordering;

#[inline(never)]
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {
        atomic::compiler_fence(Ordering::SeqCst);
    }
}

#[no_mangle]
// the name must be `_start`
pub extern "C" fn _start() -> ! {
    loop {}
}
