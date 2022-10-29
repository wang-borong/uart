# Makefile template to develop digital circuits
# with iverilog and gtkwave

SIM_TOOL := iverilog
SIM_EXEC := vvp
WAVE_TOOL := gtkwave

VSRC = $(shell find src -name "*.v")

SEARCH_SRCS := $(VSRC)
ifdef TESTBENCH
	SEARCH_SRCS = $(TESTBENCH)
endif

# find the dumpfile name from v sources
WAVE_FILE := $(shell grep dumpfile $(SEARCH_SRCS) | \
			 sed -E "s/.*dumpfile.*\"(.*)\".*/\1/")
ifndef WAVE_FILE
	$(error Can not get wave file!)
endif

TOPFILE := $(shell grep -H --only-matching dumpfile $(SEARCH_SRCS) | \
		   sed 's/:dumpfile//')
TOPMODULE := $(shell sed -nE 's/module (\w+).*/\1/p' $(TOPFILE))
BIN := $(TOPMODULE).vvp
SIMOPTS := -s $(TOPMODULE) -o $(BIN)

.PHONY: all clean sim wave

all: $(BIN)

$(BIN): $(VSRC)
	@$(SIM_TOOL) $(SIMOPTS) $^

sim: $(BIN)
	@$(SIM_EXEC) $(BIN)

wave: sim
	@$(WAVE_TOOL) $(WAVE_FILE) &

clean:
	@$(RM) *.vvp *.vcd a.out
