.data
msg: .string "matriz: "
new_line: .string "\n"
b_space: .string " "

matriz:                    # matriz visualizada pelo usuário
        .word   -1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1
        .word   -1,-1,-1,-1,-1,-1,-1
        
.text
	la a0, matriz
	addi a1, zero, 7
	add a2, zero, zero #contador de linha
	add a3, zero, zero #contador da posicao de memoria
	add a4, a0, zero
	la a0, msg
	li a7, 4
	add a0, zero, a4
	add a5, zero, zero #contador de coluna
	
imprime_matriz:
	beq a3, a1, fim
	beq a5, a1, coluna7
	add a6, a0, a3
	add a4, zero, a0
	lw a0, (a6)
	li a7, 1
	ecall
	addi a3, zero, 4
	addi a5, zero, 1
	add a0, a4, zero
	j imprime_matriz
	
coluna7:
	add a5, zero, zero
	addi a2, zero, 1
	j imprime_matriz
	
fim:
	#end