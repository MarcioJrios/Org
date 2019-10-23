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
        add s1, zero, a0	# salva o valor de N digitado pelo usuario
        
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