# DIR_TREE
# include/
# lib/
# src/Makefile	<- 'is here'
#
# include directory contain .h files.
# lib directory cotain .a static library files.
# src directory cotain sources files.
#
# assume this Makefile was spaced to 'src' directory. and uplevel directory contain include and lib directory.
# your can set LANGUAGE to c or cpp to select compiler and suffix of files such as...
#
# Usage: 
# Compiler C:
# 	make
# Compiler C++:
# 	make LANGUAGE=cpp
# Run:
# 	make run
# Clean:
# 	make clean
#
# you can change vairable to add library link
# or change default language
#
# The VARIABLE:
# LANGUAGE		: language, value can be: (c, cpp), default is 'c'
# EXE			: executable program name
# LDLIBS		: -l<libname> args with space separate for CC, such as: (-lmath -lstdio)
# DEBUG			: add -g flag to enable debug, value can be: (yes, no) default is 'yes' to enable
# INCLUDE_PATH	: header file search path
# LIBRARY_PATH	: .a lib file search path
#
# CC			: your compiler
# SOURCES_SUFFIX: source file suffix
# OBJS_SUFFIX	: objs file suffix

# 
LANGUAGE = c
DEBUG = yes

# compiler
# CC =
# SOURCES_SUFFIX =
# OBJS_SUFFIX =

# compiling arguments
INCLUDE_PATH = ../include
LIBRARY_PATH = ../lib
LDLIBS =
LDFLAGS = -L $(LIBRARY_PATH) $(LDLIBS)
CFLAGS = -I $(INCLUDE_PATH) -Wall -Wextra


# SOURCES and OBJS
EXE = main.exe
SOURCES = $(wildcard *$(SOURCES_SUFFIX))
OBJS = $(SOURCES:$(SOURCES_SUFFIX)=$(OBJS_SUFFIX))

# language
ifeq ($(LANGUAGE), c)
	CC = gcc
	SOURCES_SUFFIX = .c
	OBJS_SUFFIX = .o
else ifeq ($(LANGUAGE), cpp)
	CC = g++
	SOURCES_SUFFIX = .cpp
	OBJS_SUFFIX = .o
endif

# debug
ifeq ($(DEBUG), yes)
	CFLAGS += -g
endif

# recipes
.DEFAULT_GOAL = $(EXE)

$(EXE)	: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)
$(OBJS)	: %$(OBJS_SUFFIX) : %$(SOURCES_SUFFIX)
	$(CC) -o $@ -c $< $(CFLAGS)

# PHONY
.PHONY	: clean run

RM = rm -f
clean	:
	$(RM) $(EXE) $(OBJS)
	
run		:
	@echo run $(EXE)...
	$(EXE)
