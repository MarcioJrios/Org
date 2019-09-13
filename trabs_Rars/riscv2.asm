.data
	vetor: .word 4, 1, 5, 3, 9
	
.text
main:
	add a3, zero, zero #contador do indice
	addi a4, zero, 5 #tamanho do vetor
	la a0, vetor
	lw t0, 0(a0)
	add a5, t0, zero #primeiro menor do vetor
	jal procura
	add a0, a6, zero # indice do menor
	add a1, a5, zero # valor do menor
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
