#include <mips/regdef.h>

        .text
        .globl  conv

conv:
        subu    sp,sp,24		# Creo el stack frame
        sw      $fp,20(sp)		# Guardo $fp
        sw      gp,16(sp)		# Guardo gp
        move    $fp,sp			# fp=sp


# GUARDO LOS ARGUMENTOS DE LA FUNCIÓN

	sw 	a0,24($fp)		# Guardo el argumento 0 (x)
	sw 	a1,28($fp)		# Guardo el argumento 1 (xsize)
	sw 	a2,32($fp)		# Guardo el argumento 2 (h)
	sw 	a3,36($fp)		# Guardo el argumento 3 (hsize)

#INICIALIZACIÓN DE I Y COUNT

	sw	zero,0($fp)		# i=0
	sw	zero,4($fp)		# count=0
	


# EL PRIMER FOR NO TIENE CONDICIONES DE INICIALIZACIÓN

# PRIMER FOR
	
$for1: 

	#VERIFICO UNTIL DEL PRIMER FOR
	
	lw	v0,28($fp)		# v0=xsize
	lw	v1,36($fp)		# v1=hsize
	addu	v0,v1,v0		# v0 = xsize + hsize
	subu	v0,v0,1 		# v0= xsize + hsize - 1 
	lw	v1,0($fp)		# v1 = i
	bgeu	v1,v0,$fin_for1		# si no se cumple v0<v1 termina el for


	sw	zero,12($fp)		# f=0
	
	#INICIALIZACIÓN DEL SEGUNDO FOR
	
	lw	v0,0($fp)		#v0=i
	lw	v1,28($fp)		#v1=xsize
	bleu	v0,v1,$else1		#si v0<=v1 se llama al false del if
	subu	v0,v0,v1		#v0=i-xsize
	addu	v0,v0,1			#v0=i-xsize+1
	sw	v0,8($fp)		#Guardo v0 en m
	b 	$next1

$else1:
	lw	v0,0($fp)		# v0=i
	lw	v1,28($fp)		# v1=xsize
	divu	zero,v0,v1		# i/size
	mflo	a0			# Muevo el cociente de la división anterior a a0
	sw	a0,8($fp)		# Guardo el cociente en m	
	

$next1:

# SEGUNDO FOR

$for2:
	#IF1

	lw 	v0,8($fp)		#v0=m
	lw	v1,0($fp)		#v1=i
	bgtu	v0,v1,$fin_for2		#si v0>v1 termina la ejecución del segundo for



	#IF2

	lw	v0,8($fp)		# v0=m
	lw	v1,36($fp)		# v1=hsize
	bgeu	v0,v1,$fin_for2		#si v0>=v1 termina la ejecución del segundo for

	#SE CUMPLE EL IF, EJECUTO EL SEGUNDO FOR

	lw	v0,0($fp)		# v0=i
	lw	v1,8($fp)		# v1=m
	subu	v0,v0,v1		# v0=i-m
	lw	v1,28($fp)		# v1=xsize
	divu	zero,v0,v1		# (i-m)/xsize
	mfhi	a0			# muevo a a0 el resto de la división anterior
	sll	a0,a0,2			# a0=a0*4
	lw	a1,24($fp)		# obtengo el puntero x
	addu	a0,a1,a0		# a0=x+((i-m)%xsize)*4 (4 porque el vector x contiene float, que ocupan una palabra, 4 bytes)
	l.s	$f0,0(a0)		# obtengo el elemento x[(i-m)%xsize]
	lw	v1,8($fp)		# v1=m
	sll	v1,v1,2			# v1=m*4 (4 porque el vector h contiene float, que ocupan una palabra, 4 bytes)
	lw	v0,32($fp)		# obtengo el puntero h
	addu	a1,v0,v1		# a1=h + m*4
	l.s	$f2,0(a1)		# obtengo el elemento h[m]
	mul.s	$f0,$f0,$f2		# multiplico f0*f2
	l.s	$f2,12($fp)		# f2=f
	add.s	$f2,$f2,$f0		# f=f+f0
	s.s	$f2,12($fp)		# Guardo el resultado en f

	lw	v0,8($fp)		# v0=m
	addu	v0,v0,1			# m++
	sw	v0,8($fp)		# Guardo m
	
	b 	$for2			# Siguiente ciclo del segundo for





$fin_for2:


	l.s	$f0,12($fp)		# f0 = f
	lw	a0,y			# Obtengo el puntero y
	lw	v1,4($fp)		# v1 = count
	sll	a1,v1,2			# a1=count*4 (4 porque el vector y contiene float, que ocupan una palabra, 4 bytes)
	addu	a0,a0,a1		# a0=y+count*4
	s.s	$f0,0(a0)		# y[count]=f
	addu	v1,v1,1			# count++
	sw	v1,4($fp)		# Guardo count
	lw	v1,0($fp)		# v1=i
	addu	v1,v1,1			# i++
	sw	v1,0($fp)		# Guardo i
	b $for1				# Siguiente ciclo del primer for
	


		
	
$fin_for1:


# FIN DE LA FUNCIÓN				


$fin:
        move    sp,$fp			# sp=fp
        lw      $fp,20(sp)		# Restauro
        lw      gp,16(sp)		# Restauro
        addu    sp,sp,24		# Elimino el stack frame
        j       ra			# Vuelvo al main


