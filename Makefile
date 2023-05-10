All: findMaxOfThree
LIB=libConversions.o
CC=gcc

findMaxOfThree: findMaxOfThree.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@
