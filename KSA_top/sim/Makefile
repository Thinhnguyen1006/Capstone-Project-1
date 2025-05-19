# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM_DIR = sim
OUTPUT = KSA_top
VCD_FILE = KSA_top_wave.vcd
TEXT_OUTPUT = KSA_top_tb.txt
RTL_DIR = ../rtl
DV_DIR = ../dv

# Source files
RTL_SOURCES = $(RTL_DIR)/KSA_top.sv \
	      $(RTL_DIR)/KSA_stage1.sv \
	      $(RTL_DIR)/KSA_stage2.sv \
	      $(RTL_DIR)/KSA_stage3.sv \
	      $(RTL_DIR)/KSA_stage4.sv \
	      $(RTL_DIR)/KSA_stage5.sv \
	      $(RTL_DIR)/KSA_stage6.sv \
	      $(RTL_DIR)/KSA_stage7.sv \
	      $(RTL_DIR)/black_cell.sv \

DV_SOURCES = $(DV_DIR)/KSA_top_tb.sv

# Default target
all: build run

# Build, run and create wave
all_wave: build run wave

# Build target
build: $(OUTPUT)

# Rule to compile the Verilog sources
$(OUTPUT): $(RTL_SOURCES) $(DV_SOURCES)
	$(IVERILOG) -o $@ $^ -s KSA_top_tb -g2005-sv
	
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
