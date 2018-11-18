hello.out: hello.o
	ld -lSystem -o hello.out -macosx_version_min 10.13 hello.o
hello.o: hello.asm
	nasm -f macho64 -o hello.o hello.asm
