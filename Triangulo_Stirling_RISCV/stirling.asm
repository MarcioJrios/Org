	.data
valorn:		.string		"\nDigite o valor de N:\n"
valork:		.string		"\nDigite o valor de K:\n"
erron:		.string		"\nValor de N incorreto! Digite novamente:\n"
errok:		.string		"\nValor de K incorreto! Digite novamente:\n"

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
	blt a0, a1, erro2	# verifica se K e menor que 1
	blt s0, a0, erro2	# verifica se N e menor que K
        add s1, zero, a0	# salva o valor de K digitado pelo usuario1
        
	sw s0, 0(sp)		# salva o valor de N-1 na pilha
	addi sp, sp, -4
	sw s1, 0(sp)		# salva o valor de K na pilha
	addi sp, sp, -4
	add s7, zero, zero	# contador de chamadas de ST_2
        add s8, s0, zero	# salva valor de N em auxiliar
        add s9, s1, zero	# salva valor de K em auxiliar
        
stirling:
	lw s0, 8(sp)		# carrega o valor de N da recorrência
	lw s1, 4(sp)		# carrega o valor de K da recorrência
	blt s0, a1, n1		# verifica se se n é menor ou igual a 1
	addi s0, s0, -1
	sw s0, 0(sp)		# salva o valor de N-1 na pilha
	addi sp, sp, -4
	sw s1, 0(sp)		# salva o valor de K na pilha
	addi sp, sp, -4
	addi s7, s7, 1		
	
	j stirling
	
n1:
	blt s1, a1, k1		# verifica se K é menor que 1
	add s6,	zero, zero	# registrador de retorno
	j resolve

k1:
	addi s6, zero, 1	# registrador de retorno
	j resolve
	
resolve:
	#codigo que multiplica k pelo retorno e chama a recursao da soma
	
continue:
        j fim
        
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
	#acaba
