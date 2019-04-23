#include <stdio.h>

int main{
	int a=6;
	int b=4;
	//Dimensões
	int M[a][b] = {{1,5,2,9},{2,4,4,6},{9,0,9,9},{2,9,5,8},{2,9,9,2},{1,1,1,1}};

	int x, y;
	puts("Digite as coordenadas:");
	scanf("%d", &x);
	scand("%d", &y);
	int i;
	if(x == 0){
		if(y == 0){
			if(M[x][y+1] == 9)
				i++;
			if(M[x+1][y] == 9)
				i++;
		}else if(y == b-1){
			if(M[x+1][y] == 9)
				i++;
			if(M[x][y-1] == 9)
				i++;
		}else{
			if(M[x][y-1] == 9)
				i++;
			if(M[x][y+1] == 9)
				i++;
			if(M[x+1][y] == 9)
				i++;
		}
	}else if(x == a-1){
		if(y == 0){
			if(M[x-1][y] == 9)
				i++;
			if(M[x][y+1] == 9)
				i++;
		}else if(y == b-1){
			if(M[x][y-1] == 9)
				i++;
			if(M[x-1][y] == 9)
				i++;
		}else{
			if(M[x][y-1] == 9)
				i++;
			if(M[x][y+1] == 9)
				i++;
			if(M[x-1][y] == 9)
				i++;
		}
	}else{
		if(y == 0){
			if(M[x-1][y] == 9)
				i++;
			if(M[x+1][y] == 9)
				i++;
			if(M[x][y+1] == 9)
				i++;
		}else if(y == b-1){
			if(M[x-1][y] == 9)
				i++;
			if(M[x+1][y] == 9)
				i++;
			if(M[x][y-1] == 9)
				i++;
		}else{
			if(M[x-1][y] == 9)
				i++;
			if(M[x+1][y] == 9)
				i++;
			if(M[x][y-1] == 9)
				i++;
			if(M[x][y+1] == 9)
				i++;
		}
	}


	printf("A quantidade de 9s é: %d", i);
}