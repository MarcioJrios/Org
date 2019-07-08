from random import randint

num_cel = 128
tam_bloco_mp = 4 # K
num_l_cache = 8
tam_cel = 8
mem_p = [] # lista que simula a memoria principal
deslocamento = 2

# Numero do bloco = endereço / K
# Deslocamento no bloco = endereço % K
cache = [] # [()] lista de tuplas que guardara qual bloco e qual o deslocamento ha em cada linha (quadro(linha), num. bloco, deslocamento)
cache_lines = [] # [[]] lista que armazena o bloco em cada linha da cache

def dec_to_bin(x): #transforma o numero dec em uma string em binario
    return str(bin(x))

def calc_block(x): #calcula o endereco da primeira celula associada ao bloco x
	endco = x * tam_bloco_mp
	return endco

def gerate_mp(): #preenche a MP com valores aleatorios de 8 bits
	i = 0
	while(i < 128):
		item  = randint(0, 255)
		item = dec_to_bin(item)
		j = 0
		count = 0
		size = len(item) - 2 #tam da string item sem o '0b'
		while(j < size):
			count = count+1
			j = j+1
		if count ==  8:
			item = item.replace('0b', '')
			mem_p.append(item)
		else:
			aux = tam_cel - count
			j = 0
			zeros = ''
			while j<aux:
				zeros = zeros+'0'
				j = j+1
			item = item.replace('0b', zeros)
			mem_p.append(item)
		i = i+1

def get_block(endco): #busca as 4 celulas de um bloco
	lista = []
	h = 0
	while(h < 4):
		lista.append(mem_p[endco+h])
		h = h+1
	return lista

def fill_cache(): #preenche a cache inicialmente com os 8 blocos iniciais da MP
	i = 0
	while(i < 8):
		endereco = calc_block(i)
		num = dec_to_bin(endereco)
		size = len(num) - 2 #tam da string item sem o '0b'
		j = 0
		count =0
		while(j < size):
			count = count+1
			j = j+1
		if count ==  8:
			num = num.replace('0b', '')
			cache.append((i, num, '00'))
			lista = get_block(endereco)
			cache_lines.append(lista)
		else:
			aux = tam_cel - count - 2
			j = 0
			zeros = ''
			while j<aux:
				zeros = zeros+'0'
				j = j+1
			num = num.replace('0b', zeros)
		cache.append((i, num, '00'))
		lista = get_block(endereco)
		cache_lines.append(lista)
		i = i+1

gerate_mp()

fill_cache()


print(cache)
print(cache_lines)
