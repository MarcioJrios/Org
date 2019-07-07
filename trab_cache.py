from random import randint

num_cel = 128
tam_bloco_mp = 4 # K
num_l_cache = 8
tam_cel = 8
mem_p = []
deslocamento = 2

# Numero do bloco = endereço / K
# Deslocamento no bloco = endereço % K
cache = [] # [()] lista de tuplas que guardara qual bloco e qual o deslocamento ha em cada linha (quadro(linha), num. bloco, deslocamento)
cache_lines = [] # [[]] lista que armazena o bloco em cada linha da cache

def dec_to_bin(x):
    return str(bin(x))

def gerate_mp():
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

gerate_mp()

i = 0
while(i < 8):
	endereco = i * tam_bloco_mp
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
	else:
		aux = tam_cel - count - 2
		j = 0
		zeros = ''
		while j<aux:
			zeros = zeros+'0'
			j = j+1
		num = num.replace('0b', zeros)
	cache.append((i, num, '00'))
	i = i+1

print(cache)
print(mem_p)