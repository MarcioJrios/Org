.text
main:
	addi a0, zero, 4
	addi a2, zero, 0
	sw a0, 0(sp)
func:
	sub a3, a0, a2
	beq a3, zero, fim_laco
	addi a2, a2, 1
	addi sp, sp, -4
	sw a3, 0(sp)
	j func
fim_laco:
	lw a2, 0(sp)
	lw a3, 4(sp)
	mul a1, a2, a3
	addi sp, sp, 4
	sw a1, 0(sp)
	addi a0, a0, -1
	addi a5, zero, 1
	beq a0, a5, fim
	j fim_laco
fim:
	#fim