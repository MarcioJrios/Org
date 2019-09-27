.text
main:
	addi a0, zero, 5 # n
	addi a2, zero, 0 # contador que conta quantas multiplicações devem ser feitas
	sw a0, 0(sp) # salva o valor de n no inicio da pilha
	addi s0,zero,1
	beq a0,a2,um # excecao caso o n seja 0
	beq a0,s0,um # execao caso o n seja 1
func:
	sub a3, a0, a2 # subtrai de n o valor do contador para saber qual e o valor do proximo fatorial
	beq a3, zero, fim_laco # verifica se esta no caso de !0 
	addi a2, a2, 1 # incrementa o contador
	addi sp, sp, -4 # move o topo da pilha para o proximo valor para poder inserir um novo elemento na pilha
	sw a3, 0(sp) # insere o proximo fatorial na pilha
	j func
fim_laco:
	lw a2, 0(sp) # carrega o valor do topo da pilha
	lw a3, 4(sp) # carrega o valor do topo - 1
	jal multiplica
fim1:
	addi a1,a7,0 # passa o resultado da multiplicacao para a1
	addi a7,zero,0 # zera o auxiliar da soma
	addi sp, sp, 4 # executa pop na pilha
	sw a1, 0(sp) # salva o resultado da multiplicacao dos dois valores no topo da pilha no topo da pilha
	addi a0, a0, -1 # decrementa n em 1
	addi a5, zero, 1
	beq a0, a5, fim # verifica se ja somou todas as multiplicacoes
	j fim_laco

multiplica:
	addi a6,a2,0 # passa o parametro de a2 para nao modificar o registrador a2
for:
	beq a6,zero, fim1 # verifica se o as somas sucessivas chegaram ao valor final
	add a7,a7,a3 # faz as somas sucessivas
	
	addi a6,a6,-1 # -- na variavel do for
	j for
um:
	addi a1,zero,1 # caso de excecoes
fim:
	
