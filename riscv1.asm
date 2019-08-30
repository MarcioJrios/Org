main:
	addi a0,zero, 5
	addi s0, zero, 2
	addi t0, zero, 4
	jal triangulo
	nop	
	ebreak

triangulo:
	add t1, a0, s0
add s1, a0, t0
add a1, t0, s0
slt a2, a0, a1
slt s2, s0, s1
slt t2, t0, t1
and s2, t2, s2
and s2, s2, a2
ret
