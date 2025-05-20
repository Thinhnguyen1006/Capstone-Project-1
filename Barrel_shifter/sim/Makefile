# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM_DIR = sim
OUTPUT = Barrel_shifter 
VCD_FILE = Barrel_shifter.vcd
TEXT_OUTPUT = Barrel_shifter.txt
RTL_DIR = ../rtl
DV_DIR = ../dv

# Source files
RTL_SOURCES = $(RTL_DIR)/Barrel_shifter.sv \
	      $(RTL_DIR)/sr1.sv \
	      $(RTL_DIR)/sr2.sv \
	      $(RTL_DIR)/sr4.sv \
	      $(RTL_DIR)/sr8.sv \
	      $(RTL_DIR)/sr16.sv \
	      $(RTL_DIR)/mux2_1.sv \
	      $(RTL_DIR)/reverse.sv \

DV_SOURCES = $(DV_DIR)/Barrel_shifter_tb.sv

# Default target
all: build run

# Build, run and create wave
all_wave: build run wave

# Build target
build: $(OUTPUT)

# Rule to compile the Verilog sources
$(OUTPUT): $(RTL_SOURCES) $(DV_SOURCES)
	$(IVERILOG) -o $@ $^ -s Barrel_shifter_tb -g2005-sv
	
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
	@echo " make all_wave	: build, run simulation and open waveform"
