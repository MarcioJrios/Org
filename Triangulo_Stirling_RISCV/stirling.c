#include <stdio.h>
long int stirling(int n, int k){
    long int res;
    if(n == 1){ // (n, k) || n>1
        if(k == 1)
            return 1;
        else
            return 0;
        
        
    }else { //(1, k) || n <=1, k > 1
        res = k * stirling(n-1, k) + stirling(n-1, k-1);
    }
    printf("n = %d\n", n);
    printf("k = %d\n", k); 
    printf("res = %ld\n", res);
    return res;
}
int main(){
    int k, n;
    printf("Digite os valores de n e k:\n");
    scanf("%d", &n);
    scanf("%d", &k);
    long int x = stirling(n, k);
    printf("res = %ld", x);
};