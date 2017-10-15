// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

//=====	PSEUDO CODE =====
//	a=R0		//3
//	b=R1		//4
//	sum=a		//3		
//	for(i=1; i<=b; i++){
//		sum += a;
//		i += 1
//	}
	@R0
	D=M
	@a
	M=D		//init a

	@sum
	M=D		//init sum
	
	@R1
	D=M
	@b
	M=D		//init b
	
	@i
	M=1		//init i counter to keep track of iterations
(LOOP)
	@b
	D=M
	@i
	D=D-M
	@STOP
	D;JLE	//if b-i <= 0, then jump to STOP

	@a
	D=M
	@sum
	M=M+D	//add a to sum

	@i
	M=M+1	//increment i by 1
	@LOOP
	0;JMP
(STOP)
	@sum
	D=M
	@R2
	M=D		//set RAM[2] to value of sum
(END)
	@END
	0;JMP
