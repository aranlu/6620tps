/* IMPLEMENTACION CONVOLUCION DISCRETA (dconv.c) */

#include <stdio.h>

extern float *y; //xsize + hsize -1 elementos.

/*
*Calcula el producto de convolucion x[n]*h[n]
* http://en.wikipedia.org/wiki/Convolution#Discrete_convolution
*/

void conv(float* x,size_t xsize,float* h,size_t hsize)
{
	unsigned int i =0,count=0;
	unsigned int m;
	float f;
	
	for (i=0;i<xsize + hsize -1;i++)
	{
		f = 0;
		for (m=(i>xsize?i-(xsize-1):i/xsize);m<=i && m < hsize;m++)
		{
			f += x[(i-m)%xsize] * h[m];
		}
		y[count++] = f;
	}
}

/* FIN IMPLEMENTACION CONVOLUCION DISCRETA (dconv.c) */
