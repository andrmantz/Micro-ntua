#include <avr/io.h>

char x;

int main(void)
{
	//initialize PORTB as output and PORTA as input
	DDRA=0xF0;
	DDRB=0xFF;
	x = 1; //arxikopoisi gia na anapsei to led0 stin arxi
	while(1) {
		
		PORTB = x;  //show result
		
		
		if ((PINA & 0x01) == 1){ // An patithei to proto koumpi -> shift right
			while ((PINA & 0x01) == 1);
			
			if (x== 1) { //an eimaste sto LSB -> pigaine sto MSB
				x = 128;
			}
			else {
				x = x >> 1; //allios shift deksia
			}
		}
		
		if ((PINA & 0x02) == 2){ // 2o koumpi -> shift left
			while ((PINA & 0x02) == 2);
			
			if (x== 128) { //an eimaste sto MSB -> pigaine sto LSB
				x = 1;
			}
			else { //allios shift aristera
				x = x << 1;
			}
		}
		
		if ((PINA & 0x04) == 4){ // an patithei to 3o -> pigaine sto LSB
			while ((PINA & 0x04) == 4);
			
			x = 1;
		}
			
		if ((PINA & 0x08) == 8){ // an patithei to 4o -> pigaine sto MSB
			while ((PINA & 0x08) == 8);
			
			x = 128;
			
		}
		
	}
	return 0;
}