// https://os.phil-opp.com/ru/
// https://docs.rust-embedded.org/embedonomicon/smallest-no-std.html

// disable standard library
#![no_std]
// disables runtime init
#![no_main]
#![allow(internal_features)]
#![feature(lang_items)]
#![allow(dead_code)]
#![allow(non_upper_case_globals)]
#![feature(const_mut_refs)]

/// stack roll back
#[lang = "eh_personality"]
extern "C" fn eh_personality() {}

use core::panic::PanicInfo;
use core::sync::atomic::{self, Ordering};

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
    hello();
    loop {}
}

/// VGA hardware buffer
const W: usize = 80;
const H: usize = 25;
const VGA: *mut u16 = 0xb8000 as *mut u16;
// const VGA: *mut [u16; 2000] = 0xb8000 as *mut [u16;W*H];
const vgarg: u16 = 0b0_001_0011 << 8;

/// `Hello World!` message
#[no_mangle]
static HELLO: &[u8] = b"Hello World!";

#[no_mangle]
pub fn hello() {
    let _t = HELLO;
    let _v = VGA;
    for (i, &byte) in HELLO.iter().enumerate() {
        unsafe {
            // VGA[i] = vgarg | (byte as u16);
            *VGA.offset((i as isize) << 1) = vgarg | (byte as u16);
        }
    }
}

// https://os.phil-opp.com/ru/minimal-rust-kernel/
