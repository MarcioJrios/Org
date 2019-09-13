	.data
vetor: .word 5,4,3,2,10
	.text
main:
	la a0,vetor
	addi a1,zero,0 #recebe o indicie para trocar
	addi a2,zero,3 #recebe o outro indicie para trocar 
	addi a4,zero,0 #variavel para controle do fim do vetor e indicie
	addi a5,zero,4 #variavel para o controle do fim do vetor
	jal percorre
	nop 
	ebreak
	
percorre:
	beq a4,a5,fim #veririfica se chegou ao fim do vetor
	lw t0,0(a0) #carregar o valor do vetor em uma variavel
	beq a4,a1 achou1 #verifica se esta no indicie desejado do vetor
	addi a0,a0,4 #soma 4 bits para andar no vetor
	addi a4,a4,1 #da ++ na variavel do indicie do vetor e do for
	j percorre
achou1:
	addi t1,t0,0 #salva o valor que foi achado no indicie desejado
	addi t2,a0,0 #salva o endereco em que se encontra tal valor
	
percorre1:
	beq a4,a5,fim
	lw t0,0(a0)
	beq a4,a2,achou2 #verifica se encontrou o segundo valor desejado
	addi a0,a0,4 
	addi a4,a4,1
	j percorre1
		
achou2:
	
	sw t1,(a0)#coloca o valor que estava no indicie 2 no lugar do indicie 1	
	sw t0,(t2)#coloca o valor que estava no indicie 1 no lugar do indicie 2

fim:
	ret
