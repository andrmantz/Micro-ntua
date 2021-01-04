#include <avr/io.h>

char a, b,notb,  c, notc, d,  f0, f1;

int main(void)
{	
	//initialize PORTA 0-1 for output and PORTB 0-3 for input
	DDRA=0x03; 
	DDRB=0xF0; 
	while(1) {
		a = PINB & 0x01;
		b = PINB & 0x02;
		b = b>>1; 
		notb = ~b & 0x01;// & 0x01;
		c = PINB & 0x04;
		c = c>>2; 
		notc = ~c & 0x01;
		d = PINB & 0x08;
		d = d>>3;
		
		f0 = ~((a & notb) |  (b & notc & d));
		f0 = f0 & 0x01;
		f1 = ((a | c) &(b | d));
		if (f0==0 && f1==0){
			PORTA = 0;
		}
		else if (f0 == 1 && f1 == 0){
			PORTA = 1;
		}
		else if (f0==0 && f1 == 1){
			PORTA = 2;
		}
		else {
			PORTA = 3;
		}
	}
	return 0;
}
