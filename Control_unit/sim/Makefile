# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM_DIR = sim
OUTPUT = Control_unit
VCD_FILE = Control_unit_wave.vcd
TEXT_OUTPUT = Control_unit_tb.txt
RTL_DIR = ../rtl
DV_DIR = ../dv

# Source files
RTL_SOURCES = $(RTL_DIR)/Control_unit.sv \

DV_SOURCES = $(DV_DIR)/Control_unit_tb.sv

# Default target
all: build run

# Build, run and create wave
all_wave: build run wave

# Build target
build: $(OUTPUT)

# Rule to compile the Verilog sources
$(OUTPUT): $(RTL_SOURCES) $(DV_SOURCES)
	$(IVERILOG) -o $@ $^ -s Control_unit_tb -g2005-sv
	
# Run target
run: build
	$(VVP) $(OUTPUT) | tee $(TEXT_OUTPUT)

# Wave target
wave: $(VCD_FILE)
	$(GTKWAVE) $(VCD_FILE)

# Clean up
clean:
	rm -f $(OUTPUT) $(VCD_FILE)

# Help
help:
	@echo " make build	: build the design"
	@echo " make run	: run simulation"
	@echo " make wave	: open waveform"
	@echo " make all	: build and run simulation"
	@echo " make all_wave	: build, run simulation and open waveform"
