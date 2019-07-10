from random import randint

num_cel = 128 # quantidade de celulas na memoria
tam_bloco_mp = 4 # K : tamanho do bloco
num_l_cache = 8 # numero de linhas da cache
tam_cel = 8	# tamanho de bits da celula
mem_p = [] # lista que simula a memoria principal
acertos_L = 0
acertos_E = 0
falhas_L = 0
falhas_E = 0
total_L = 0
total_E = 0
# Numero do bloco = endereço / K
# Deslocamento no bloco = endereço % K
cache = [] # [[]] lista de tuplas que guardara qual bloco e qual o deslocamento ha em cada linha (quadro(linha), num. bloco, deslocamento, LRU)
cache_lines = [] # [[]] lista que armazena o bloco em cada linha da cache

def bin_to_dec(x): # transforma numero binario para decimal
	binary1 = x
	decimal, i, n = 0, 0, 0
	while x != 0:
		dec = x % 10
		decimal = decimal + dec * pow(2, i)
		x = x//10
		i += 1
	return decimal

def dec_to_bin(x): #transforma o numero dec em uma string em binario
    return str(bin(x))

def calc_end(x): #calcula o endereco da primeira celula associada ao bloco x
	endco = x * tam_bloco_mp
	return endco

def calc_block(x): #calcula o numero do bloco associado ao endereco x
	num_block = x / 4
	return int(num_block)

def gerate_mp(): #preenche a MP com valores aleatorios de 8 bits
	i = 0
	while(i < 128):
		item  = randint(0, 127)
		item = dec_to_bin(item)
		j = 0
		size = len(item) - 2 #tam da string item sem o '0b'
		if size ==  8:
			item = item.replace('0b', '')
			mem_p.append(item)
		else:
			aux = tam_cel - size
			j = 0
			zeros = ''
			while j<aux:
				zeros = zeros+'0'
				j = j+1
			item = item.replace('0b', zeros)
			mem_p.append(item)
		i = i+1

def replace_end(num, size): # elimina o caractere '0b' e preenche a string com a quantidade de 0's necessaria para fechar 8 bits e retorna o deslocamento
	if size == 8:
		num = num.replace('0b', '')
	else:
		aux = 7 - size
		j = 0
		zeros = ''
		while j<aux:
			zeros = zeros+'0'
			j = j+1
		num = num.replace('0b', zeros)
	num = num[5:] # pega apenas os 2 ultimos bits que representam o deslocamento
	return num

def get_block(endco): #busca as 4 celulas de um bloco
	lista = []
	h = 0
	while(h < 4):
		lista.append(mem_p[endco+h])
		h = h+1
	return lista

def get_value(ender): # verifica se o valor esta na cache
	i = 0
	for line in cache:
		if ender == line[1]:
			return line[0]
		i = i+1
	return 'Not'

def fill_cache(): #preenche a cache inicialmente com os 8 blocos iniciais da MP
	i = 0
	while(i < 8):
		endereco = calc_end(int(i))
		num = dec_to_bin(int(i))
		size = len(num) - 2 #tam da string item sem o '0b'
		j = 0
		if size ==  6:
			num = num.replace('0b', '')
			cache.append([i, num, '00', int(i)])
			lista = get_block(endereco)
			cache_lines.append(lista)
		else:
			aux = 7 - size - 2#	contador de bits em num sem o deslocamento
			j = 0
			zeros = ''
			while j<aux:
				zeros = zeros+'0'
				j = j+1
			num = num.replace('0b', zeros)
		cache.append([i, num, '00', int(i)])
		lista = get_block(endereco)
		cache_lines.append(lista)
		i = i+1


def leitura(acertos_L, falhas_L): # funcao para ler um endereco de memoria
	endereco = input("Digite o endereço em decimal: \n")
	if(int(endereco) >127):
		print('endereco invalido')
		return [acertos_L, falhas_L]
	block = calc_block(int(endereco))
	num_block = dec_to_bin(int(block))
	size = len(num_block) - 2 #tam da string item sem o '0b'
	j = 0
	#transforma o tamanho do bloco em uma string em binario sem o '0b'
	if size == 6:
		num_block = num_block.replace('0b', '')
	else:
		aux = 7 - size -2
		j = 0
		zeros = ''
		while j<aux:
			zeros = zeros+'0'
			j = j+1
		num_block = num_block.replace('0b', zeros)
	print('Bloco: ', num_block)
	i = 0
	for linha in cache:
		if num_block == linha[1]: # verifica se o bloco obtido pelo endereco fornecido esta em alguma linha da cache
			line = linha[0]
			valid = linha[3]
			j = 0
			for item2 in cache:
				if int(item2[3]) < valid:	
					line2 = item2[0]
					b = item2[1]
					desl = item2[2]
					val = item2[3]
					cache[j] = [line2, b, desl, val+1] # incrementa em 1 o valor valid de cada linha da cache
					j = j+1
			print("Bloco na cache!")
			print("Linha: ")
			print(cache[i])
			cache[i] = [line, num_block, linha[2], 0]
			acertos_L = acertos_L +1
			binary = int(num_block)
			dec = bin_to_dec(binary)
			endereco = dec_to_bin(int(endereco))
			size = len(endereco) - 2
			num = endereco
			#transforma o endereco em uma string em binario sem o '0b'
			#num = replace_end(num, size)
			lista = get_block(line)
			#falta alterar os bits de dirty e valid
			return acertos_L, falhas_L
		else:
			pass
		i = i+1
	#Caso nao esteja na cache
	num = dec_to_bin(int(endereco))
	size = len(num) - 2
	falhas_L = falhas_L +1
	# transforma o endereco em binario sem o '0b'
	num = replace_end(num, size)
	lista = get_block(int(endereco))
	line = 0
	for item in cache:
		if(item[3] == 7):
			line = item[0]
			del cache[line] # remove a linha da cache mais antiga
			j = 0
			for item2 in cache:
				line2 = item2[0]
				b = item2[1]
				desl = item2[2]
				val = item2[3]
				val = val + 1
				cache[j] = [line2, b, desl, val] # incrementa em 1 o valor valid de cada linha da cache
				j = j+1
			print("Bloco não esta na cache!")
			print("Linha: ")
			print(item)
			cache.append([line, num_block, num, 0]) # adiciona a tupla nova a cache
			cache_lines[line] = lista # adiciona o novo bloco a sua respectiva linha
			linha = cache_lines[line]
			return [acertos_L, falhas_L]
		else:
			pass
	return [acertos_L, falhas_L]

def escrita(acertos_E, falhas_E): # escreve um dado em um endereço da MP
	endereco  = input("digite o endereço em decimal onde se deseja inserir: \n")
	if(int(endereco) >127):
		print('endereco invalido')
		return [acertos_L, falhas_L]
	num = dec_to_bin(int(endereco))
	valor = input("Digite o valor a ser inseriro em decimal:\n")
	if(int(valor) >255):
		print('valor invalido')
		return [acertos_L, falhas_L]
	item = dec_to_bin(int(endereco))
	valor = dec_to_bin(int(valor))
	num_block = calc_block(int(endereco))
	num_block = dec_to_bin(int(num_block))
	size = len(num_block) - 2 #tam da string item sem o '0b'
	j = 0
	#transforma o tamanho do bloco em uma string em binario sem o '0b'
	if size == 6:
		num_block = num_block.replace('0b', '')
	else:
		aux = 7 - size -2 
		j = 0
		zeros = ''
		while j<aux:
			zeros = zeros+'0'
			j = j+1
		num_block = num_block.replace('0b', zeros)
	print('Bloco: ', num_block)
	j = 0
	size = len(item) - 2 #tamanho da string item sem o '0b'
	if size ==  8:
		item = item.replace('0b', '')
	else:
		aux = tam_cel - size
		j = 0
		zeros = ''
		while j<aux:
			zeros = zeros+'0'
			j = j+1
		item = item.replace('0b', zeros)
	block = item[:5]
	deslocamento = item[6:]
	size = len(valor) - 2
	if size ==  8:
		valor = valor.replace('0b', '')
	else:
		aux = tam_cel - size
		j = 0
		zeros = ''
		while j<aux:
			zeros = zeros+'0'
			j = j+1
		valor = valor.replace('0b', zeros)
	R = get_value(num_block)
	if R == 'Not': # O dado que esta sendo inserido não esta na cache
		mem_p[int(endereco)] = valor
		i = 0
		for item in cache:
			if(item[3] == 7):
				line = item[0]
				print('Elemento substituido: ', cache[i])
				cache.pop(i) # remove a linha da cache mais antiga
				j = 0
				for item2 in cache:
					line2 = item2[0]
					b = item2[1]
					desl = item2[2]
					val = item2[3]
					val = val + 1
					cache[j] = [line2, b, desl, int(val)] # incrementa em 1 o valor valid de cada linha da cache
					j = j+1
				print("Bloco não esta na cache!")
				print("Linha: ")
				print(item)
				size = len(num) - 2
				num = replace_end(num, size)
				cache.append([line, num_block, num, 0]) # adiciona a tupla nova a cache
				lista = get_block(int(endereco))
				cache_lines[line] = lista # adiciona o novo bloco a sua respectiva linha
				linha = cache_lines[line]
				falhas_E = falhas_E + 1
				return [acertos_E, falhas_E]
			else:
				pass
			i=i+1
	else:
		lista = get_block(int(endereco))
		linha = R
		print(R)
		cache_lines[linha] = lista
		size = len(num) - 2
		num = replace_end(num, size)
		j = 0
		valid = 0
		for item2 in cache:
			if item2[0] == linha:
				valid = item2[3]
		for item2 in cache:
			if item2[3] < valid:
				line2 = item2[0]
				b = item2[1]
				desl = item2[2]
				val = int(item2[3])
				val = val + 1
				cache[j] = [line2, b, desl, int(val)] # incrementa em 1 o valor valid de cada linha da cache
				j = j+1
		print("Bloco na cache!")
		print("Linha: ")
		print(cache[R])
		acertos_E = acertos_E + 1
		i = 0
		for item in cache:
			if item[0] == R:
				cache[i] = [R, num_block, num, 0]
				return [acertos_E, falhas_E]
			i = i+1
		#cache[linha] = [linha[0], num_block, num, 0]



def estatisticas():
	total_L = acertos_L + falhas_L
	if(total_L == 0):
		print("Sem leituras\n")
	else:
		print("Leitura:")
		porcentagem_acertos_L = (100 / total_L) * acertos_L
		print("Acertos -> ",round(porcentagem_acertos_L,2), "%")
		print("Falhas  -> ",round(100 - porcentagem_acertos_L,2), "%")
	total_E = acertos_E + falhas_E
	if(total_E == 0):
		print("Sem escritas\n")
	else:
		print("\nEscrita:")
		porcentagem_acertos_E = (100 / total_E) * acertos_E
		print("Acertos -> ",round(porcentagem_acertos_E,2),"%")
		print("Falhas  -> ",round(100 - porcentagem_acertos_E,2),"%")
	input("\nAperte Enter para continuar...")

def sair():
	print('voce escolheu sair')
n = -1
gerate_mp()
fill_cache()

while n != 0:
	m = 0
	print('MEMÓRIA PRINCIPAL\n')
	for line in mem_p:
		print(m, ': ', mem_p[m])
		m = m+1
	print('MEMÓRIA CACHE\n')
	for line in cache:
		print(line)
		print(line[0])
		print(line, '\n', cache_lines[line[0]], '\n')

	for line in cache:
		if(line[3] == 7):
			print("Linha da cache a ser substituida: ")
			print(line)
	print('Escolha uma opção:')
	print('---------------------------------------------------')
	print("1 : Leitura de endereço da memoria\n2 : Escrita de valor em um endereço de memória\n3 : Exibir estatísticas de acertos e falhas\n0 : Sair")
	print('---------------------------------------------------')
	n = int(input())
	if(n == 1):
		stats = leitura(acertos_L, falhas_L)
		acertos_L = stats[0]
		falhas_L = stats[1]
	elif(n == 2):
		stats = escrita(acertos_E, falhas_E)
		acertos_E = stats[0]
		falhas_E = stats[1]
	elif(n == 3):
		estatisticas()
	elif(n == 0):
		sair()
		break
	else:
		print("Opção inválida")
