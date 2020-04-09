CC = clang++
CFLAGS = -Wall -g
.PHONY: all clean

all: main.out
main.out: poly.o main.o
	#$(CC) poly.o main.o -o $@
	$(CC) $(CPPFLAGS) $^ -o $@
clean:
	-rm -f *.out *.o

