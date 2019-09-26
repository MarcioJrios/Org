.text
main:
	addi a0, zero, 4
	add a1, zero, a0
	addi a2, zero, 1
	sub a3, a0, a2
func:
	beq a3, zero, fim
	mul a1, a1, a3
	addi a3, a3, -1
	j func
	
fim:
	#fim