.data
vetor: .word 2,6,3,5,-7

.text
main:
	addi a0, zero, 6
	la a1, vetor
	addi a2, zero, 5
	jal procura
	nop
	ebreak
	
procura:
	beq a2, zero, fim_laco
	lw t0, 0(a1)
	beq a0, t0, encontrou
	addi a2, a2, -1
	addi a1, a1, 4
	j procura

fim_laco:
	addi a0, zero, -1
	ret
encontrou:
	addi t1, zero, 5
	sub a0, t1, a2
	ret