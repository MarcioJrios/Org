.data
	vetor: .word 4, 1, 5, 3, 9
	
.text
main:
	add a3, zero, zero
	addi a4, zero, 4
	la a1, vetor
	lw t0, 0(a1)
	add a5, t0, zero #primeiro menor do vetor
	jal procura
	nop
	ebreak
	
procura:
	beq a4, a3, fim_laco
	lw t0, 0(a1)
	blt t0, a5, menor
	addi a3, a3, 1
	addi a1, a1, 4
	j procura
	
menor:
	add a5, t0, zero
	add a6, zero, a3
	addi a3, zero, 1
	addi a1, a1, 4
	j procura
	
fim_laco:
	ret