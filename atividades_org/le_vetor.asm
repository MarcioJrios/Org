.data
vetor: .space 20
msg: .string "Digite os valores do vetor: "
new_line: .string "\n"
b_space: .string " "

.text

le_vetor:
	addi s0, zero, 4
	addi a1, zero, 20	
	div a1, a1, s0
	add a2, zero, zero #contador do laço
	add a3, zero, zero #contador do vetor
laco:	
	la a0, vetor
	beq a2, a1, fim
	add a4,a0,zero
	la a0, msg
	li a7, 4
	ecall
	li a7, 5
	ecall
	add s0, a0, zero
	add a0, a4, zero
	add a0, a0, a3
	sw s0, (a0)
	addi a2, a2, 1
	addi a3, a3, 4
	j laco
	
fim:
	#end
	
	
	
	