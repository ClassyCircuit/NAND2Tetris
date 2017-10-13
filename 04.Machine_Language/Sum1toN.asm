// Sum1toN.asm
// Computes RAM[1] = 1+2+...+n
// Usage: put a number(n) in RAM[0]

	n = R0
	i = 1
	sum = 0
LOOP:
	if i > n goto STOP
	sum = sum + i
	i = i + 1
	goto LOOP
STOP:
	R1 = sum
---------------------------------

	@R0
	D=M
	@n
	M=D

	@i
	M=1

	@sum
	M=0
(LOOP)
	

