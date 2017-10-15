// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

//==== PSEUDO CODE ====
//	screen_end = SCREEN + 8160
//	screen_state = 0		// 0 white, -1 black
//	
//	while(true){
//		if KBD and not screen_state: //key down and white screen
//			fill_screen()
//		if not KBD and screen_state == -1: //key up and black screen
//			fill_screen()
//	}
//	
//	fill_screen() {
//		screen_state = !screen_state //set screen_state to its opposite
//		scr_addr = SCREEN	//reset current screen address
//		for(i=0; i<screen_end; i++){
//			screen[scr_addr] = screen_state
//			scr_addr++;
//		}
//	}

	@screen
	D=A				//get base addr of screen
	@8160
	D=D+A			//add all registers to base adr
	@screen_end		
	M=D				//init screen_end with the last adr of screen
	
	@screen_state
	M=0				//set default screen state to WHITE

(LISTEN_TO_KBD)
	@KBD
	D=M
	@KEY_DOWN
	D;JNE			//if key is pressed, jump to KEY_DOWN section else continue
	@KEY_UP			
	D;JEQ			//if no key is pressed, jump to KEY_UP section, else continue

(KEY_DOWN)
	@screen_state
	D=M
	@FILL_SCREEN_FUNC
	D;JEQ			//if screen_state == 0, jump to fill function, else continue
	@LISTEN_TO_KBD
	0;JMP			//force jump back to LISTEN_TO_KBD loop

(KEY_UP)
	@screen_state
	D=M
	@FILL_SCREEN_FUNC
	D;JNE			//if screen_state != 0, jump to fill function, else continue
	@LISTEN_TO_KBD
	0;JMP			//force jump back to LISTEN_TO_KBD loop

(FILL_SCREEN_FUNC)
	@screen_state
	M=!M			//set screen_state to opposite of whats it now
	@screen
	D=A
	@scr_addr		//scr_addr must be reset each time fill_screen is called
	M=D				//set current scr adr to base of screen
	@i
	M=0				//set counter to 0
(FILL_SCREEN_LOOP)
	@screen_end
	D=M
	@i
	D=D-M
	@LISTEN_TO_KBD
	D;JLT			//if counter has reached screen end, jump back to KBD loop
	//body of loop:
	@screen_state
	D=M
	@scr_addr
	A=M				//get register which is pointed by scr_addr
	M=D				//change whole register to value of screen_state

	@scr_addr
	M=M+1			//get register for next iteration
	@FILL_SCREEN_LOOP
	0;JMP			//jump back to beginning of this loop





