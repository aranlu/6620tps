#define N 576

void ejecutar(){

double a[N][N], b[N][N], c[N][N];
  int i,j,k;
  for (i=0; i<N; i++)
    for (j=0; j<N; j++)
      for (k=0; k<N; k++)
          c[i][j] += a[i][k] * b[k][j];


}

int main(void)
{
  ejecutar();
  return 0;
}

