#include <mips/regdef.h>

        .text
        .globl  conv
conv:
        subu    sp,sp,40				# Creo el stack frame
        sw      $fp,36(sp)				# Guardo $fp
        sw      gp,32(sp)				# Guardo gp
        move    $fp,sp					
        sw      a0,40($fp)				# Guardo el argumento 0 (x)
        sw      a1,44($fp)				# Guardo el argumento 1 (xsize)
        sw      a2,48($fp)				# Guardo el argumento 2 (h)
        sw      a3,52($fp)				# Guardo el argumento 3 (hsize)
        sw      zero,8($fp)				# i = 0	
        sw      zero,12($fp)				# count = 0
$until_1loop:						# De aquí en adelante se verifica si se cumple i < xsize + hsize - 1
        lw      v1,44($fp)				# v1 = xsize
        lw      v0,52($fp)				# v0 = hsize
        addu    v0,v1,v0				# v0 = xsize + hsize
        addu    v1,v0,-1				# v1 = xsize + hsize -1
        lw      v0,8($fp)				# v0 = i
        sltu    v0,v0,v1				# Si i < xsize + hsize - 1, v0 vale 1, 0 si no
        bne     v0,zero,$loop1_1			# Si v0!=0 (v0==1) ejecuta el primer for en $loop1_1
        b       $fin					# Si v0==0 entonces sale del for, en $fin
$loop1_1:						# Se ejecuta el primer for
        sw      zero,20($fp)				# f = 0
        lw      v0,8($fp)				# v0 = i
        lw      v1,44($fp)				# v1 = xsize
        sltu    v0,v1,v0				# Si xsize < i v0 vale 1, si no 0
        beq     v0,zero,$false1				# Si v0 vale 0, entonces xsize >= i, ejecuto i/xsize en $false1
        lw      v1,8($fp)				# De aca en adelante xsize < i, v1=i
        lw      v0,44($fp)				# v0 = xsize
        subu    v1,v1,v0				# v1 = i -xsize
        sw      v1,24($fp)				# v1 -> 24(fp)
        lw      v0,24($fp)				# v0 = 24(fp)
        addu    v0,v0,1					# v0 = i - xsize + 1
        sw      v0,24($fp)				# v0 -> 24(fp)
        b       $asignacion				# Paso a $asignacion para asignar el resultado a m
$false1:						# Ejecuta el false de la condición inicial del segundo for
        lw      v1,8($fp)				# v1 = i
        lw      v0,44($fp)				# v0 = xsize
        divu    $0,v1,v0				# i/xsize y descarto el resultado
        mflo    a0					# Muevo el cociente de la división anterior a a0
        sw      a0,24($fp)				# Guardo el cociente de la división en 24($fp)
        .set    noreorder				
        bne     v0,$0,$continuar1			# Si el xsize es 0, entonces se produce un error (división por 0), si no continua la ejecución en $continuar1
        nop
        break   7					# Error: división por 0
$continuar1:
        .set    reorder
$asignacion:						# Se asigna el valor calculado anteriormente a m
        lw      v0,24($fp)				# Obtengo el valor recién calculado en v0
        sw      v0,16($fp)				# Guardo v0 en m
$until_2loop:						# Se verifica la condición de corte del segundo for
        lw      v0,16($fp)				# v0 = m
        lw      v1,8($fp)				# v1 = i
        sltu    v0,v1,v0				# Si i<m, v0 vale 1, 0 si no
        bne     v0,zero,$loop1_2			# Si v0==1 entonces no ejecuta el for, pasa a $loop1_2 (segunda parte del loop 1)
        lw      v0,16($fp)				# Si v0==0 (i>=m), para verificar la segunda condición del AND cargo nuevamente m en v0
        lw      v1,52($fp)				# v1 = hsize
        sltu    v0,v0,v1				# Si m < hsize, v0 vale 1, 0 si no
        bne     v0,zero,$loop2				# Si v0==0, se verifican las dos condiciones del AND, ejecuto el segundo loop en $loop2
        b       $loop1_2				# Si v0==1 entonces no ejecuta el for, pasa a $loop1_2 (segunda parte del loop 1)
$loop2:
        lw      v1,8($fp)				# v1 = i
        lw      v0,16($fp)				# v0 = m
        subu    v1,v1,v0				# v1 = i - m
        lw      v0,44($fp)				# v0 = xsize
        divu    $0,v1,v0				# (i-m) / xsize
        mfhi    v1					# Muevo a v1 el módulo de la división anterior
        .set    noreorder				
        bne     v0,$0,$mul				# Si el xsize es 0, entonces se produce un error (división por 0), si no continua la ejecución en $mul
        nop
        break   7					# Error: división por 0
$mul:							# realiza la multiplicación de x[(i-m)%xsize] * h[m]; y la asignación en f
					
        .set    reorder					
        move    v0,v1					# v0 = v1				
        sll     v1,v0,2					# v1 = v1 * 4 (4 = tamaño del dato del array, porque es un float)
        lw      v0,40($fp)				# v0 = x
        addu    a0,v1,v0				# a0 = x + v1, en v1 se guardaron cuantos bytes hay que moverse desde el inicio del array
        lw      v0,16($fp)				# v0 = m
        sll     v1,v0,2					# v1 = v0 * 4 (4 = tamaño del dato del array, porque es un float)
        lw      v0,48($fp)				# v0 = h
        addu    v0,v1,v0				# v0 = h + v1, en v0 se guardaron cuantos bytes hay que moverse desde el inicio del array
        l.s     $f2,0(a0)				# Obtengo el floating point simple precisión en a0 y lo guardo en $f2
        l.s     $f0,0(v0)				# Obtengo el floating point simple precisión en v0 y lo guardo en $f0
        mul.s   $f2,$f2,$f0				# $f2 = $f2 * $f0 (multiplicación de punto flotante simple precisión)
        l.s     $f0,20($fp)				# Obtengo el floating point simple precisión f y lo guardo en $f0 
        add.s   $f0,$f0,$f2				# f = f + multiplicación (suma de floating point simple precisión)
        s.s     $f0,20($fp)				# Guardo el floating point simple precisión resultante en f
        lw      v0,16($fp)				# v0 = m
        addu    v0,v0,1					# m++
        sw      v0,16($fp)				# Guardo m
        b       $until_2loop				# Siguiente ciclo
$loop1_2: 						# Segunda parte del primer for		
        addu    a1,$fp,12				# obtengo la dirección de count, que es 12 + $fp
        lw      v1,0(a1)				# v1 = count
        move    v0,v1					# v0 = v1
        sll     a0,v0,2					# a0 = v0*4 (4 = tamaño del dato del array, porque es un float)
        lw      v0,y					# v0 = y
        addu    v0,a0,v0				# v0 = y + a0
        l.s     $f0,20($fp)				# Obtengo f, un floating point simple precisión, en $f0
        s.s     $f0,0(v0)				# Guardo $f0 en (v0)=(y+4*count)
        addu    v1,v1,1					# count++
        sw      v1,0(a1)				# Guardo v1 en count
        lw      v0,8($fp)				# v0 = i
        addu    v0,v0,1					# i++
        sw      v0,8($fp)				# Guardo i
        b       $until_1loop				# Siguiente ciclo
$fin:
        move    sp,$fp					
        lw      $fp,36(sp)				# Restauro
        addu    sp,sp,40				# Elimino el stack frame
        j       ra					# Vuelvo al main

