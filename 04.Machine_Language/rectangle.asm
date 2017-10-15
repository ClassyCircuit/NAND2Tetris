// Rectangle.asm
// Draws filled rectangle at screens top left corner
// Width is always 16px, height is RAM[0]
// Usage: put non-negative number in RAM[0] (it will be rect height)

// ====== pseudo code ====
//	height = RAM[0]
//	i = 0
//	offset = 0
// 	increment_by = 32
//	arr = SCREEN
//	for(i=0; i<=height; i++){
//		SCREEN[offset] = -1
//		offset += increment_by
//	}

	@R0
	D=M
	@height
	M=D		//initialize height, which basically is row amount to draw
	
	@i
	M=0 	//initialize i counter

	@offset
	M=0		//initialize address offset to 0

	@32
	D=A
	@increment_by
	M=D		//initialize increment_by to 32, because next row starts after 31 registers
	
	@SCREEN //base address of screen
	D=A
	@arr
	M=D		//assign base address of screen to arr variable
(LOOP)
	@i		//if condition
	D=M
	@height
	D=D-M
	@END
	D;JGT //if i > height, jump to end

	@arr	//get base address
	D=M
	@offset	//get current counter value
	D=D+M	//add base and counter to get the new address
	A=D		//assign the new address
	M=-1	//set the whole register to -1, so 1 row lights up
	
	@increment_by
	D=M
	@offset
	M=M+D	//increment offset by 32

	@i
	M=M+1	//increment counter

	@LOOP
	0;JMP	//jump to beginning of loop

(END)
	@END
	0;JMP
