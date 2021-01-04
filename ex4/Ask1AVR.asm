.include "m16def.inc"

reset: 
	ldi r24 , low(RAMEND) ; initialize stack pointer
	out SPL , r24
	ldi r24 , high(RAMEND)
	out SPH , r24
	ser r24 ; initialize PORTB for output
	out DDRB , r24
	ldi r26, 251 ;11111011 -> C
	out DDRC, r26 
	ldi r26, 1 ;arxikopoihsh r26

move_left:
	ldi r28,1 ;san flag sthn pause
	in r27, PINC
	cpi r27, 4
	breq freeze
	out PORTB, r26
	ldi r24, low(500)
	ldi r25, high(500) ;delay 0.5 sec
	;rcall wait_msec
	nop
	lsl r26
	cpi r26, 128
	brlo move_left ;elegxei r26 etsi wste na sunexisei h move left

move_right:
	ldi r28,2
	in r27, PINC
	cpi r27, 4
	breq freeze
	out PORTB, r26
	ldi r24, low(500)
	ldi r25, high(500) ;delay 0.5 sec
	;rcall wait_msec
	nop
	lsr r26
	cpi r26, 2
	brsh move_right ;elegxei r26 etsi wste na sunexisei h move right
	rjmp move_left

freeze:
	in r27, PINC
	cpi r27, 4
	breq freeze
	cpi r28, 1
	breq move_left
	rjmp move_right

wait_msec:
	push r24 ; 2 κύκλοι (0.250 μsec)
	push r25 ; 2 κύκλοι
	ldi r24 , low(998) ; φόρτωσε τον καταχ. r25:r24 με 998 (1 κύκλος - 0.125 μsec)	
	ldi r25 , high(998) ; 1 κύκλος (0.125 μsec)
	rcall wait_usec ; 3 κύκλοι (0.375 μsec), προκαλεί συνολικά καθυστέρηση 998.375
		; μsec
	pop r25 ; 2 κύκλοι (0.250 μsec)
	pop r24 ; 2 κύκλοι
	sbiw r24 , 1 ; 2 κύκλοι
	brne wait_msec ; 1 ή 2 κύκλοι (0.125 ή 0.250 μsec)
	ret ; 4 κύκλοι (0.500 μsec)

wait_usec:
	sbiw r24 ,1 ; 2 κύκλοι (0.250 μsec)
	nop ; 1 κύκλος (0.125 μsec)
	nop ; 1 κύκλος (0.125 μsec)
	nop ; 1 κύκλος (0.125 μsec)
	nop ; 1 κύκλος (0.125 μsec)
	brne wait_usec ; 1 ή 2 κύκλοι (0.125 ή 0.250 μsec)
	ret ; 4 κύκλοι (0.500 μsec)