CC=clang
CFLAGS=-O3 -march=native -g
LDFLAGS=

all: main

main: main.c aes.o crc32.o
	$(CC) $(CFLAGS) $^ -o main $(LDFLAGS)

aes.o: aes.asm
	nasm -f elf64 -o $@ $^

crc32.o: crc32.asm
	nasm -f elf64 -o $@ $^

clean:
	rm -f *.o main
