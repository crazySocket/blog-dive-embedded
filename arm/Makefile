
MCFLAGS = -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -mfpu=fpv4-sp-d16 -fno-exceptions
CFLAGS = ${MCFLAGS} -g
CXXFLAGS = ${CFLAGS}
LDSCRIPT = memory_layout.ld
LDFLAGS = -T ${LDSCRIPT} --specs=nano.specs -lc -lm -static -Wl,-gc-sections

all : app.hex

clean :
	rm -f *.hex
	rm -f *.elf
	rm -f *.o

app.elf : main.o isr.o test.o
	${CC} ${LDFLAGS} -o $@ $^

%.hex : %.elf
	${OBJCOPY} -O ihex $^ $@

.PHONY : all clean
