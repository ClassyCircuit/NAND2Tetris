// Rectangle.asm
// Draws filled rectangle at screens top left corner
// Width is always 16px, height is RAM[0]
// Usage: put non-negative number in RAM[0] (it will be rect height)

// ====== pseudo code ====
//	height = RAM[0]
//	i = 0
//	addr = SCREEN
//	for(i=0; i<height; i++){
//		SCREEN[addr] = -1
//		addr += 32		//32 because every next row starts by offset of +32 registers
//	}

	@R0
	D=M
	@height
	M=D		//initialize height, which basically is row amount to draw
	
	@i
	M=0 	//initialize i counter to keep track of iterations

	@SCREEN //base address of screen
	D=A
	@addr
	M=D		//assign base address of screen to addr variable
(LOOP)
	@i		//if condition
	D=M
	@height
	D=D-M
	@END
	D;JGT 	//if i > height, jump to end

	@addr	//get current row address
	A=M		//select current row address
	M=-1	//set the whole register to -1, so the row lights up
	
	@32		//next row starts at +32 registers
	D=A
	@addr
	M=M+D	//increment current screen address by 32 (to get next row)

	@i
	M=M+1	//increment loop's counter

	@LOOP
	0;JMP	//jump to beginning of loop

(END)
	@END
	0;JMP
