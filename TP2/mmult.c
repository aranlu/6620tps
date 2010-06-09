
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 576


int main(int argc, char **argv) 

{
   double a[N][N], b[N][N], c[N][N];
   int i,j,k;

   /* Multiplica las matrices */
   for (i=0; i<N; i++)
      for (j=0; j<N; j++)
         for (k=0; k<N; k++)
            c[i][j] += a[i][k] * b[k][j];


   return 0;
}

