// Sum1toN.asm
// Computes RAM[1] = 1+2+...+n
// Usage: put a number(n) in RAM[0]

// ====== pseudo code ====
//  	n = R0
//  	i = 1
//  	sum = 0
//  LOOP:
//  	if i > n goto STOP
//  	sum = sum + i
//  	i = i + 1
//  	goto LOOP
//  STOP:
//  	R1 = sum
//  ---------------------------------

	@R0
	D=M
	@n		//n var
	M=D
	@i		//i var
	M=1
	@sum	//sum var
	M=0
(LOOP)
	//if condition & goto
	@n 		
	D=M
	@i
	D=D-M
	@STOP
	D;JLT
	//if body
	@i
	D=M
	@sum
	M=M+D // sum=sum+i
	@i
	M=M+1 //i=i+1
	@LOOP
	0;JMP
(STOP)
	@sum
	D=M
	@R1
	M=D
(END)
	@END
	0;JMP

