let app = "MultithreadedGeneratorUDP"
let version = "0.0.1"

let title = "генератор высокоскоростного UDP-трафика"

let subtitle = "zmq: cppzmq + pcpp (DPDK)"
let user = "Nicktonious"
let telegram = "@minionpilled"
let author = "Nikita Umnov"
let email = "nikita.umnov@mas-tech.ru"
let license = "All rights reserved"

let about = "- поток до 100...200 Gbit\n- UDP трафик на порты 40000..40024\n"

let task = "https://tracker.yandex.ru/ECOLITESOFTT-150"

let remote =
  [
    ("flic", "git@gitflic.ru:dponyatov/multithreadedgeneratorudp.git");
    ("gh", "git@github.com:ponyatov/MultithreadedGeneratorUDP.git");
    ("origin", "https://github.com/Nicktonious/MultithreadedGeneratorUDP.git");
  ]

let raw_00 =
  [
    "ClassZMQServer";
    "ClassSocketClient";
    "childProcessASM";
    "mainCPP";
    "ClassDataAsm";
    "ClassDataGenerator";
    "ClockGenWrapper";
    "ClassSender";
    "argsParser_copy";
  ]

let modules =
  raw_00
  @ [
      "utils";
      "client";
      "setqlen";
      "main";
      "argsParser";
      "configParser";
      "childProcess";
      "Stats";
      "ClassDataProvider";
      "ClassControlChannel";
      "test-fs";
      "createTempConf";
    ]
