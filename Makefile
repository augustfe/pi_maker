# Compiler and flags
FC = gfortran
FLAGS = -Wall -Wextra -O2 -std=f2018

# Directory structure
SRC_DIR = src
TEST_DIR = test
BUILD_DIR = build
BIN_DIR = bin

# Executables
MAIN_EXEC = $(BIN_DIR)/main
TEST_EXEC = $(BIN_DIR)/test

# Dependency file
DEP_FILE = $(BUILD_DIR)/dependencies.mk

-include $(DEP_FILE)

# Source files
MAIN_SRC_FILES = $(SRC_DIR)/main.f90
MAIN_OBJ = $(BUILD_DIR)/main.o
ALL_SRC_FILES = $(wildcard $(SRC_DIR)/*.f90)
SRC_FILES = $(filter-out $(MAIN_SRC_FILES), $(ALL_SRC_FILES))
TEST_FILES = $(wildcard $(TEST_DIR)/*.f90)

# Object files and module files
OBJ_FILES = $(patsubst $(SRC_DIR)/%.f90, $(BUILD_DIR)/%.o, $(SRC_FILES))
TEST_OBJ_FILES = $(patsubst $(TEST_DIR)/%.f90, $(BUILD_DIR)/%.o, $(TEST_FILES))

# Shared library (ctypes) setup
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  SOEXT = dylib
  SHARED_LDFLAGS = -dynamiclib
else
  SOEXT = so
  SHARED_LDFLAGS = -shared
endif

# Shared library target and sources
SHLIB = $(BIN_DIR)/libpiopsowrap.$(SOEXT)
SHLIB_SRCS = $(SRC_DIR)/posix.f90 $(SRC_DIR)/pi.f90 $(SRC_DIR)/pi_ctypes_wrap.f90
SHLIB_OBJS = $(patsubst $(SRC_DIR)/%.f90,$(BUILD_DIR)/%.o,$(SHLIB_SRCS))

# Ensure shared objects are PIC
$(SHLIB_OBJS): FLAGS += -fPIC

# Default target: build everything
.PHONY: all shared clean test
all: $(MAIN_EXEC) $(TEST_EXEC) $(SHLIB)

# Build the shared library for ctypes
shared: $(SHLIB)
$(SHLIB): $(SHLIB_OBJS) | $(BIN_DIR)
	$(FC) $(FLAGS) $(SHARED_LDFLAGS) -o $@ $^

# Rule for building the main program
$(MAIN_EXEC): $(OBJ_FILES) $(MAIN_OBJ) | $(BIN_DIR)
	$(FC) $(FLAGS) -o $@ $^

# Rule for building the test program
$(TEST_EXEC): $(OBJ_FILES) $(TEST_OBJ_FILES) | $(BIN_DIR)
	$(FC) $(FLAGS) -o $@ $^

# some manual dependencies
$(BUILD_DIR)/pi.o: $(BUILD_DIR)/posix.o
$(BUILD_DIR)/jittersin.o: $(BUILD_DIR)/pi.o
$(BUILD_DIR)/main.o: $(BUILD_DIR)/jittersin.o
# Shared wrapper depends on pi as well
$(BUILD_DIR)/pi_ctypes_wrap.o: $(BUILD_DIR)/pi.o

# Generic rule for compiling source files into object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.f90 | $(BUILD_DIR)
	$(FC) $(FLAGS) -c -J $(BUILD_DIR) $< -o $@

# Generic rule for compiling test files into object files
$(BUILD_DIR)/%.o: $(TEST_DIR)/%.f90 | $(BUILD_DIR)
	$(FC) $(FLAGS) -c -J $(BUILD_DIR) $< -o $@

# Ensure build and bin directories exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Clean build and binary files
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

# Run tests
test: $(TEST_EXEC)
	./$(TEST_EXEC)
