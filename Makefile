# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM_DIR = sim
OUTPUT = <output name>
VCD_FILE = $(OUTPUT)_wave.vcd
TEXT_OUTPUT =$(OUTPUT)_tb.txt
RTL_DIR = ../rtl
DV_DIR = ../dv

# Source files
RTL_SOURCES = $(RTL_DIR)/*.sv

DV_SOURCES = $(DV_DIR)/$(OUTPUT)_tb.sv

# Default target
all: build run

# Build, run and create wave
all_wave: build run wave

# Build target
build: $(OUTPUT)

# Rule to compile the Verilog sources
$(OUTPUT): $(RTL_SOURCES) $(DV_SOURCES)
	$(IVERILOG) -o $@ $^ -s $(OUTPUT)_tb -g2005-sv
	
# Run target
run: build
	$(VVP) $(OUTPUT) | tee $(TEXT_OUTPUT)

# Wave target
wave: $(VCD_FILE)
	$(GTKWAVE) $(VCD_FILE)

# Clean up
clean:
	rm -f $(OUTPUT) $(VCD_FILE) $(TEXT_OUTPUT)

# Help
help:
	@echo " make build	: build the design"
	@echo " make run	: run simulation"
	@echo " make wave	: open waveform"
	@echo " make all	: build and run simulation"
	@echo " make all_wave	: build, run simulation and open wavefor
