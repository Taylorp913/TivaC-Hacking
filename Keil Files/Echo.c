#include "TM4C123GH6PM.h"


void main(void){
	int echo ()
	{
		char buffer [32];
		gets ( buffer );
		printf ( buffer );
		return 1;
	}
}