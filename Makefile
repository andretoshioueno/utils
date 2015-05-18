
DIRS = $(shell find . -not -path '*/\.*' -type d -print)
INCLUDE := $(addprefix -I,$(DIRS))
CFLAGS = -I$(INCLUDE) -std=c99 -DPRODUCT_MVX150_PACK_BRIDGE=1 -DBOARD=MVX150 -DAT45DB -DFREERTOS_USED -DUSING_RADIOSTATUS_REQUEST -Werror -mpart=uc3b0512 -march=ucr2  

LFLAGS = -Wl,--gc-sections -Wl,-e,_trampoline  -Tsoftware_framework/utils/linker_scripts/AT32UC3B/0512/GCC/link_uc3b0512.lds
CSOURCES := $(shell find . -name '*.c') 

all: Mxv150App
	
Mxv150App: $(CSOURCES:.c=.o)
	@echo Criando arquivo executavel: $@
	avr32-gcc -o $@ $^ $(LDFLAGS) $(LFLAGS)
	@echo 

%.o: %.c
	@echo Compilando arquivo objeto: $@
	avr32-gcc -c $< $(CFLAGS) -o $@
	@echo  

clean:
	@echo Limpando arquivos
	@rm -f *.o *.d Mvx150App *~ 
	
remade:
	$(MAKE) clean
	$(MAKE)

#-include $(CSOURCES:.c=.d)
	
#%.d: %.c
#	avr32-gcc $< -MM -MT '$*.o $*.d ' -MD $(CFLAGS)
#	@echo
