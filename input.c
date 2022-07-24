#include <stdio.h>
#include <stdlib.h>

int main(int argc,char *argv[]){
	int c=0;
	printf("\e[0;32;47mpress a key?\n");
	do{ 
		c=fgetc(stdin);
	}while(c==-1);
	printf("%d\n",c);
	return 0;
}