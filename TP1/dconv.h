/* IMPLEMENTACION CONVOLUCION DISCRETA (dconv.h) */

#ifndef __DCONV_H__

  #define __DCONV_H__

	/*
	 * Calcula el producto de convolucion x[n]*h[n]
	 * http://en.wikipedia.org/wiki/Convolution#Discrete_convolution
	 */

	void conv(float* x, size_t xsize, float* h, size_t hsize);

#endif

/* FIN IMPLEMENTACION CONVOLUCION DISCRETA (dconv.h) */
