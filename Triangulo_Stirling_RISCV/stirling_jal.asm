.data
valorn:		.string		"\nDigite o valor de N:\n"
valork:		.string		"\nDigite o valor de K:\n"
erron:		.string		"\nValor de N incorreto! Digite novamente:\n"
errok:		.string		"\nValor de K incorreto! Digite novamente:\n"
res:		.string		"\nResultado:    "

	.text
escolhen:
	li  a7, 4               # seta valor de operação para string
        la  a0, valorn          # mensagem para escolher o valor de n
        ecall			# imprime string
        
        li a7, 5
        ecall
        
        addi a1, zero, 1
        blt a0, a1, erro1	# verifica se N e melhor que 1
        add s0, zero, a0	# salva o valor de N digitado pelo usuario
        
escolhek:
	li  a7, 4               # seta valor de operação para string
        la  a0, valork          # mensagem para escolher o valor de n
        ecall			# imprime string
        
        li a7, 5
        ecall
        
        addi a1, zero, 1
        addi a3, zero, 2
	blt a0, a1, erro2	# verifica se K e menor que 1
	blt s0, a0, erro2	# verifica se N e menor que K
        add s1, zero, a0	# salva o valor de K digitado pelo usuario
        sw zero, 0(sp)		# indica que é a primeira chamada da recursão (k * ST_2)
        addi sp, sp, -4
        addi sp, sp, -4
	sw s0, 0(sp)		# salva o valor de N na pilha
	addi sp, sp, -4
	sw s1, 0(sp)		# salva o valor de K na pilha
	addi sp, sp, -4
	add s7, zero, zero	# Retorno acumulativo
        add s8, s0, zero	# salva valor de N em auxiliar
        add s9, s1, zero	# salva valor de K em auxiliar
        jal stirling
        j fim
        
stirling:
	
	lw s2, 16(sp)		# registrador que indica se esta na primeira ou segunda chamada da recursao
	sw ra, 12(sp)
	#beq ra, zero, fim       # se ra for zero, salva o resultado e termina o loop
	lw s0, 8(sp)		# carrega o valor de N da recorrência
	lw s1, 4(sp)		# carrega o valor de K da recorrência
	beq s0, s8, if
continue:
	blt s0, a3, n1		# verifica se n é menor ou igual a 1
	addi s0, s0, -1
	sw zero, 0(sp)		# 0 indica que deve-se multiplicar o retorno recebido por K
	addi sp, sp, -4
	#sw ra, 0(sp)		# salva o retorno na pilha
	addi sp, sp, -4
	sw s0, 0(sp)		# salva o valor de N-1 na pilha
	addi sp, sp, -4
	sw s1, 0(sp)		# salva o valor de K na pilha
	addi sp, sp, -4	
	
	jal stirling
	lw s2, 16(sp)
	beq s2, a1, Soma
	#lw ra, 12(sp)		# registrador de retorno (ra)
	lw s0, 8(sp)		# carrega o valor de N da recorrência
	lw s1, 4(sp)		# carrega o valor de K da recorrência
	mul s5, s1, s6
	addi s1, s1, -1
	addi s0, s0, -1
	sw s5, 4(sp)		# salva o resultado da multiplicação em K
	sw a1, 16(sp)		# 1 indica que deve-se somar o valor que esta em K com o retorno
	sw zero, 0(sp)		#indica que a proxima operação sera da recursão da multiplicação (k * ST_2)
	addi sp, sp, -4
	#sw ra, 0(sp)		# salva o registrador de retorno
	addi sp, sp, -4
	sw s0, 0(sp)		# salta o valor de N-1 na pilha
	addi sp, sp, -4
	sw s1, 0(sp)		# salva o valor de K-1 na pilha
	addi sp, sp, -4
	
	jal stirling
Soma:
	lw ra, 12(sp)		# registrador de retorno (ra)
	lw s0, 8(sp)		# carrega o valor de N da recorrência
	lw s1, 4(sp)		# carrega o valor de K da recorrência
	add s6, s6, s1
	add s7, zero, s6
	addi sp, sp, 16
	ret
	
	
n1:
	beq s1, a1, k1		# verifica se K é igual a 1
	add s6,	zero, zero	# registrador de retorno
	addi sp, sp, 16
	ret

k1:
	addi s6, zero, 1	# registrador de retorno
	addi sp, sp, 16
	ret
	
if:                     
	bne s1, s9, continue
	sw ra, 12(sp)
	j continue	
	
erro1:
	li  a7, 4               # seta valor de operação para string
        la  a0, erron       	# mensagem de erro no valor de N
        ecall			# imprime string
        j escolhen
       
erro2:
	li  a7, 4               # seta valor de operação para string
        la  a0, errok      	# mensagem de erro no valor de N
        ecall			# imprime string
        j escolhek
        
fim:
	li  a7, 4              # seta valor de operação para string
        la  a0, res          # mensagem para escolher o valor de n
        ecall			# imprime string
        
        add a0, s7, zero
        li a7, 1
        ecall
	#acaba
