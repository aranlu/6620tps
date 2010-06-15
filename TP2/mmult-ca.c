#define N 576
#include <string.h>
#include <stdio.h>

#define D 8
#define CE 8 


/*obtiene el blocking factor B */
int calcularB(int distancia){


	return (CE*distancia);

}

int min(int a,int b)
{
	if (a<b) 
		return(a);
	else
		return(b);	
}


/* ejecución del programa*/

void ejecutar(int pad,int B, int distancia){

double a[N][N],pad1[pad],b[N][N],pad2[pad],c[N][N];
int i0,j0,k0,i,j,k;
	for (i0=0;i0<N;i0+=B)
		for (j0=0;j0<N;j0+=B)
			for (k0=0;k0<N;k0+=B){			
				/* PROLOGO*/

				/* proceso la primera línea*/
//				for (k=k0; k<=min(k0+B-1,(N-1)); k+=8)
				for (k=k0; k<=min(k0+B-1,(N-1)); k+=CE)
					__builtin_prefetch(&a[i0][k]);

				
				/* proceso toda la matriz a menos la última fila */

				for (i=i0;i<=min(i0+B-1,(N-1))-1;i++)
					for (k=k0;k<=min(k0+B-1,(N-1));k+=CE){

						__builtin_prefetch(&a[i+1][k]);
						for (j=j0;j<=min(j0+B-1,(N-1));j++){

					/*EXPANSION*/
							



						}
					}	


				/* EPÍLOGO*/
				/*proceso la última línea*/
				for (i=min(i0+B-1,(N-1))-1;i<=min(i0+B-1,(N-1));i++)
					for (k=k0;k<=min(k0+B-1,(N-1));k++)
						for (j=j0;j<=min(j0+B-1,(N-1));j++)
							c[i][j]+=a[i][k]*b[k][j];



			}




}


int main(int argc, char** argv)
{

int m,pad,B;
/*obtengo el tamaño de la línea*/
m=atoi(argv[1]);

/* calculo el pad, múltiplo del tamaño de la línea*/
pad=m*2;

/*obtengo el blocking factor*/
B=calcularB(D);

ejecutar(pad,B,D);



return(0);


}


