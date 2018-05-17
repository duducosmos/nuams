PNAME=nuasm.out

C_SOURCE=$(wildcard ./source/*.c)

H_SOURCE=$(wildcard ./source/*.h)

A_SOURCE=$(wildcard ./source/*.asm)

SC=nasm
SC_FLAGS=-f elf64
SINCLUDE= -I ./source/
OBJA=$(subst .asm,.o,$(subst source,objects,$(A_SOURCE)))

OBJ=$(subst .c,.o,$(subst source,objects,$(C_SOURCE)))


CC=gcc
CC_FLAGS=-c         \
         -W         \
         -Wall      \
         -ansi      \
         -pedantic

RM = rm -rf

all: objFolder $(PNAME)

$(PNAME): $(OBJ) $(OBJA)
	@ echo 'Building binary using GCC linker: $@'
	$(CC) $^ -o $@
	@ echo 'Finished building binary: $@'
	@ echo ' '

./objects/%.o: ./source/%.asm
	@ echo 'Building target using NASM compiler: $<'
	$(SC) $< $(SC_FLAGS) $(SINCLUDE) -o $@
	@ echo ' '


./objects/%.o: ./source/%.c ./source/%.h
	@ echo 'Building target using GCC compiler: $<'
	$(CC) $< $(CC_FLAGS) -o $@
	@ echo ' '

./objects/main.o: ./source/main.c $(H_SOURCE)
	@ echo 'Building target using GCC compiler: $<'
	$(CC) $< $(CC_FLAGS) -o $@
	@ echo ''

objFolder:
	@ mkdir -p objects

clean:
	@ $(RM) ./objects/*.o $(PROJ_NAME) *~
	@ rmdir objects

.PHONY: all clean
