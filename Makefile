#TO RUN THE PROGRAM (in Linux) PLEASE FOLLOW THESE STEPS:
# 1. open Terminal (in the current folder).
# 2. type the command->		make
# 3. type the command->		make run


#Compiler
CC = gcc
#Flex command
FLEX = flex

#Input and output files
LEX_FILE = olympics.lex
LEX_OUTPUT = lex.yy.c
EXECUTABLE = olympics

#Test file
TEST_FILE = test_olympics.txt

#default target
all: $(EXECUTABLE)

#Flex target
$(LEX_OUTPUT): $(LEX_FILE)
	$(FLEX) $(LEX_FILE)

#Compile target
$(EXECUTABLE): $(LEX_OUTPUT)
	$(CC) -o $(EXECUTABLE) $(LEX_OUTPUT)

#Clean target
clean:
	rm -f $(LEX_OUTPUT) $(EXECUTABLE)

#Run target
run: $(EXECUTABLE)
	./$(EXECUTABLE) $(TEST_FILE)

.PHONY: all clean run


