.include "m8535def.inc"
.equ step1 = 8
.equ step2 = 4
.equ step3 = 2
.equ step4 = 1
.def step = r16
.def aux = r17

reset:
rjmp inicio
.org $008
rjmp TIMER1_OVF_vect
.org $009
rjmp TIMER0_OVF_vect

inicio:
	ldi aux,low(RAMEND)
	out spl,aux
	ldi aux,high(ramend)
	out sph,aux
	ser aux
	ldi aux,$0F
	out ddrc,aux
	ldi aux,0b11111110
	out ddrb,aux
	ldi aux,0b00000001
	out portb,aux
	ldi aux,1
	out timsk,aux
	ldi aux,6
	out tccr0,aux
	ldi aux,251
	out tcnt0,aux
	ldi step,0
	sei

ciclo:
	nop
	nop
	rjmp ciclo

TIMER0_OVF_vect:
	ldi aux,2
	out tccr1b,aux
	ldi aux,4
	out timsk,aux
	reti

TIMER1_OVF_vect:
	inc step
	cpi step,1
	breq caso1
	cpi step,2
	breq caso2
	cpi step,3
	breq caso3
	cpi step,4
	breq caso4
caso1:
	ldi aux,step4
	out portc,aux
	reti
caso2:
	ldi aux,step3
	out portc,aux
	reti
caso3:
	ldi aux,step2
	out portc,aux
	reti
caso4:
	ldi aux,step1
	out portc,aux
	ldi step,0
	reti
