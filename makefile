CC=gcc
all:main

main: main.o trapezoidw.o trapezoid.o
	$(CC) -o main.out main.o trapezoidw.o trapezoid.o

main.o: main.c trapezoidw.h
	$(CC) -o main.o main.c -c -W -Wall -ansi -pedantic

trapezoidw.o: trapezoidw.c trapezoidw.h
	$(CC) -Wall -g -c trapezoidw.c -o trapezoidw.o

trapezoid.o: trapezoid.asm
	nasm -f elf64 trapezoid.asm

clean:
	rm -rf *.o *~ main.out
