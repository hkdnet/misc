GLOBAL _main

SECTION .text

_main:
  mov rax, 0x2000004;
  mov rdi, 1;
  mov rsi, hello_world;
  mov rdx, 13;
  syscall;
  mov rax, 0x2000001;
  mov rdi, 0;
  syscall;


SECTION .data;
  hello_world db "Hello World", 0x0a;
