.data
	vetor: .word 5,4,3,2,10
	
.text
	add s0, zero, zero #contador que indica em qual indice comeca o vetor para realizar o swap(0 - 4)
	add s1, zero, zero #contador que indica quantas posicoes de memoria deve-se mover para chegar no valor inicial do laco
main:
	add a3, s0, zero #contador que conta a posicao atual do laço no vetor
	addi a1, zero, 5 #tamanho do vetor
	la a0, vetor #recebe o endereco inicial do vetor
	add a0, a0, s1
	lw t1, 0(a0) #recebe o primeiro valor do vetor como o menor
main2:
	add a5, t1, zero #primeiro menor do vetor
	jal procura
	add a0, a6, zero #pega o indice do menor que esta em a6
	add a1, a5, zero #pega o valor associado ao menor que esta em a5
	# codigo para trocar o menor por outro valor
	blt a1, t1, Swap
continue:
	addi s0, s0, 1 # incrementa em 1 o contador da posicao do vetor
	addi s1, s1, 4 # incrementa em 4 o auxiliar da posicao do vetor
	beq a0, s0, main #verifica se o indice do menor é o mesmo indice do primeiro valor do vetor segundo s0
	addi a5, zero, 5
	bne s0, a5, main # verifica se ja passou por todos os valores do vetor, senao retorna para a main
	nop
	ebreak
Swap:
	la a0, vetor #recebe o endereco inicial do vetor
	add a0, a0, s1
	sw a1, (a0)
	sw t1, (a7)
	j continue
procura: #procura pelo menor valor
	beq a1, a3, fim_laco #se o laco(a3) estiver na posicao 5(a1) significa que ja passou por todos os valores da lista
	lw t0, 0(a0)
	blt t0, a5, menor #se o valor da posicao atual for menor que o menor atual desvia para o rotulo menor
	addi a3, a3, 1 #incrementa em 1 o controlador do laço
	addi a0, a0, 4 #passa para o proximo valor do vetor
	j procura
	
menor:
	add a5, t0, zero #salva o novo menor
	add a6, zero, a3 #salva o indice do menor
	add a7, zero, a0 #salva o endereco do menor
	addi a3, a3, 1 #incrementa em 1 o controlador do laço
	addi a0, a0, 4 #passa para o proximo valor do vetor
	j procura
	
fim_laco:

	ret
