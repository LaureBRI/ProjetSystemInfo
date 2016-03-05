OBJECTS=$(patsubst %.c,%.o,$(wildcard *.c))
INCLUDE=-Iinclude
LDFLAGS=-g
CCFLAGS=-Wall -Werror -g
TARGET=projetSystLex
CC=gcc
LD=gcc

all: $(TARGET)

$(TARGET): $(OBJECTS)
	@echo [LD] $@
	$(LD) -o $@ $(LDFLAGS) $^

%.o: %.c
	@echo [CC] $@
	$(CC) -c $^ -o $@ $(INCLUDE) $(CCFLAGS)

info:
	@echo OBJECTS[$(OBJECTS)]

clean:
	@echo remove target and objects
	@rm -f $(TARGET) $(OBJECTS)
