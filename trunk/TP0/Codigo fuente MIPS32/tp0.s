        .file   1 "tp0.c"
        .section .mdebug.abi32
        .previous
        .abicalls
        .rdata
        .align  2
$LC0:
        .ascii  "Uso:\n"
        .ascii  "  tp0 -h\n"
        .ascii  "  tp0 -V\n"
        .ascii  "  tp0 [options]\n"
        .ascii  "Options:\n"
        .ascii  "  -V,  --version               Version.\n"
        .ascii  "  -h,  --help                  Ayuda.\n"
        .ascii  "  -f,  --scriptfile scrptfile  Ejecuta los comandos espe"
        .ascii  "cificados en el scriptfile.\n"
        .ascii  "  -e,  --script script         Ejecuta los comandos en e"
        .ascii  "l script.\n"
        .ascii  "Examples:\n"
        .ascii  "  tp0\n"
        .ascii  "  tp0 -e\"22+5*p\"\n"
        .ascii  "  tp0 -f calculo.m\n\000"
        .text
        .align  2
        .globl  imprimir_ayuda
        .ent    imprimir_ayuda
imprimir_ayuda:
        .frame  $fp,40,$ra              # vars= 0, regs= 3/0, args= 16, extra= 8        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,40
        .cprestore 16
        sw      $ra,32($sp)
        sw      $fp,28($sp)
        sw      $gp,24($sp)
        move    $fp,$sp
        sw      $a0,40($fp)
        sw      $a1,44($fp)
        lw      $a0,40($fp)
        la      $a1,$LC0
        la      $t9,fprintf
        jal     $ra,$t9
        lw      $a0,44($fp)
        la      $t9,exit
        jal     $ra,$t9
        .end    imprimir_ayuda
        .size   imprimir_ayuda, .-imprimir_ayuda
        .rdata
        .align  2
$LC1:
        .ascii  "TP0: 1.0 \n\000"
        .text
        .align  2
        .globl  imprimir_version
        .ent    imprimir_version
imprimir_version:
        .frame  $fp,40,$ra              # vars= 0, regs= 3/0, args= 16, extra= 8        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,40
        .cprestore 16
        sw      $ra,32($sp)
        sw      $fp,28($sp)
        sw      $gp,24($sp)
        move    $fp,$sp
        sw      $a0,40($fp)
        sw      $a1,44($fp)
        lw      $a0,40($fp)
        la      $a1,$LC1
        la      $t9,fprintf
        jal     $ra,$t9
        lw      $a0,44($fp)
        la      $t9,exit
        jal     $ra,$t9
        .end    imprimir_version
        .size   imprimir_version, .-imprimir_version
        .align  2
        .globl  destruir_stack
        .ent    destruir_stack
destruir_stack:
        .frame  $fp,48,$ra              # vars= 8, regs= 3/0, args= 16, extra= 8        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,48
        .cprestore 16
        sw      $ra,40($sp)
        sw      $fp,36($sp)
        sw      $gp,32($sp)
        move    $fp,$sp
        sw      $a0,48($fp)
$L20:
        lw      $a0,48($fp)
        addu    $a1,$fp,24
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        move    $v1,$v0
        li      $v0,1                   # 0x1
        beq     $v1,$v0,$L20
        move    $sp,$fp
        lw      $ra,40($sp)
        lw      $fp,36($sp)
        addu    $sp,$sp,48
        j       $ra
        .end    destruir_stack
        .size   destruir_stack, .-destruir_stack
        .rdata
        .align  2
$LC2:
        .ascii  "\000"
        .align  2
$LC3:
        .ascii  " \000"
        .align  2
$LC4:
        .ascii  "i: %i, %c\n\000"
        .align  2
$LC5:
        .ascii  "j: %i %c\n\000"
        .align  2
$LC6:
        .ascii  "0\000"
        .align  2
$LC7:
        .ascii  "ERROR: Caracteres invalidos.\n\000"
        .align  2
$LC8:
        .ascii  "i: %i, %f\n\000"
        .align  2
$LC9:
        .ascii  "ERROR: No hay segundo operando.\n\000"
        .align  2
$LC10:
        .ascii  "ERROR: Pila vacia.\n\000"
        .align  2
$LC11:
        .ascii  "ERROR: Division por 0.\n\000"
        .align  2
$LC12:
        .ascii  "ERROR: Pila vacia.\n"
        .ascii  " \000"
        .align  2
$LC13:
        .ascii  "%.8f\n\000"
        .align  2
$LC14:
        .ascii  "%.8f\000"
        .align  2
$LC15:
        .ascii  "ERROR: Hay un unico elemento en la pila.\n\000"
        .align  2
$LC16:
        .ascii  "ERRROR: '%c' no implementado.\n\000"
        .text
        .align  2
        .globl  ejecutar
        .ent    ejecutar
ejecutar:
        .frame  $fp,96,$ra              # vars= 56, regs= 3/0, args= 16, extra= 8
        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,96
        .cprestore 16
        sw      $ra,88($sp)
        sw      $fp,84($sp)
        sw      $gp,80($sp)
        move    $fp,$sp
        sw      $a0,96($fp)
        sw      $a1,100($fp)
        lw      $a0,96($fp)
        la      $t9,strlen
        jal     $ra,$t9
        addu    $v0,$v0,1
        move    $a0,$v0
        la      $t9,malloc
        jal     $ra,$t9
        sw      $v0,24($fp)
        lw      $a0,24($fp)
        la      $a1,$LC2
        la      $t9,strcpy
        jal     $ra,$t9
        lw      $a0,96($fp)
        la      $a1,$LC3
        la      $t9,strcat
        jal     $ra,$t9
        sw      $zero,28($fp)
        sw      $zero,32($fp)
$L24:
        lw      $a0,96($fp)
        la      $t9,strlen
        jal     $ra,$t9
        lw      $v1,28($fp)
        sltu    $v0,$v1,$v0
        bne     $v0,$zero,$L26
        b       $L25
$L26:
        lw      $v1,96($fp)
        lw      $v0,28($fp)
        addu    $v0,$v1,$v0
        lb      $v1,0($v0)
        lw      $v0,_ctype_
        addu    $v0,$v1,$v0
        addu    $v0,$v0,1
        lbu     $v0,0($v0)
        srl     $v0,$v0,2
        andi    $v0,$v0,0x1
        beq     $v0,$zero,$L27
        lw      $v1,24($fp)
        lw      $v0,32($fp)
        addu    $a0,$v1,$v0
        lw      $v1,96($fp)
        lw      $v0,28($fp)
        addu    $v0,$v1,$v0
        lbu     $v0,0($v0)
        sb      $v0,0($a0)
        lw      $v1,24($fp)
        lw      $v0,32($fp)
        addu    $v0,$v1,$v0
        lb      $v0,0($v0)
        la      $a0,$LC4
        lw      $a1,28($fp)
        move    $a2,$v0
        la      $t9,printf
        jal     $ra,$t9
        lw      $v1,96($fp)
        lw      $v0,32($fp)
        addu    $v0,$v1,$v0
        lb      $v0,0($v0)
        la      $a0,$LC5
        lw      $a1,32($fp)
        move    $a2,$v0
        la      $t9,printf
        jal     $ra,$t9
        lw      $v0,32($fp)
        addu    $v0,$v0,1
        sw      $v0,32($fp)
        b       $L28
$L27:
        lw      $v1,96($fp)
        lw      $v0,28($fp)
        addu    $v0,$v1,$v0
        lb      $v1,0($v0)
        li      $v0,95                  # 0x5f
        bne     $v1,$v0,$L29
        lw      $v1,24($fp)
        lw      $v0,32($fp)
        addu    $v1,$v1,$v0
        li      $v0,45                  # 0x2d
        sb      $v0,0($v1)
        lw      $v0,32($fp)
        addu    $v0,$v0,1
        sw      $v0,32($fp)
        b       $L28
$L29:
        lw      $v1,96($fp)
        lw      $v0,28($fp)
        addu    $v0,$v1,$v0
        lb      $v1,0($v0)
        li      $v0,46                  # 0x2e
        bne     $v1,$v0,$L31
        lw      $v1,24($fp)
        lw      $v0,32($fp)
        addu    $v1,$v1,$v0
        li      $v0,46                  # 0x2e
        sb      $v0,0($v1)
        lw      $v0,32($fp)
        addu    $v0,$v0,1
        sw      $v0,32($fp)
        b       $L28
$L31:
        lw      $v1,24($fp)
        lw      $v0,32($fp)
        addu    $v0,$v1,$v0
        sb      $zero,0($v0)
        lw      $a0,24($fp)
        la      $t9,atof
        jal     $ra,$t9
        s.d     $f0,40($fp)
        lw      $a0,24($fp)
        la      $a1,$LC2
        la      $t9,strcmp
        jal     $ra,$t9
        beq     $v0,$zero,$L33
        l.d     $f2,40($fp)
        mtc1    $zero,$f0
        mtc1    $zero,$f1
        c.eq.d  $f2,$f0
        bc1t    $L35
        b       $L34
$L35:
        lw      $a0,24($fp)
        la      $a1,$LC6
        la      $t9,strcmp
        jal     $ra,$t9
        beq     $v0,$zero,$L34
        la      $a0,__sF+176
        la      $a1,$LC7
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L33
$L34:
        la      $a0,$LC8
        lw      $a1,28($fp)
        lw      $a2,40($fp)
        lw      $a3,44($fp)
        la      $t9,printf
        jal     $ra,$t9
        addu    $v0,$fp,40
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
$L33:
        sw      $zero,32($fp)
        lw      $v1,96($fp)
        lw      $v0,28($fp)
        addu    $v0,$v1,$v0
        lb      $v0,0($v0)
        addu    $v0,$v0,-10
        sw      $v0,76($fp)
        lw      $v1,76($fp)
        sltu    $v0,$v1,109
        beq     $v0,$zero,$L92
        lw      $v0,76($fp)
        sll     $v1,$v0,2
        la      $v0,$L93
        addu    $v0,$v1,$v0
        lw      $v0,0($v0)
        .cpadd  $v0
        j       $v0
        .rdata
        .align  2
$L93:
        .gpword $L28
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L28
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L53
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L48
        .gpword $L38
        .gpword $L92
        .gpword $L43
        .gpword $L92
        .gpword $L58
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L80
        .gpword $L82
        .gpword $L92
        .gpword $L66
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L74
        .gpword $L92
        .gpword $L71
        .gpword $L92
        .gpword $L85
        .gpword $L92
        .gpword $L92
        .gpword $L92
        .gpword $L77
        .text
$L38:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L39
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L40
        l.d     $f2,48($fp)
        l.d     $f0,56($fp)
        add.d   $f0,$f2,$f0
        s.d     $f0,64($fp)
        addu    $v0,$fp,64
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L40:
        la      $a0,__sF+176
        la      $a1,$LC9
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L39:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L43:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L44
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L45
        l.d     $f2,48($fp)
        l.d     $f0,56($fp)
        sub.d   $f0,$f2,$f0
        s.d     $f0,64($fp)
        addu    $v0,$fp,64
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L45:
        la      $a0,__sF+176
        la      $a1,$LC9
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L44:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L48:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L49
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L50
        l.d     $f2,48($fp)
        l.d     $f0,56($fp)
        mul.d   $f0,$f2,$f0
        s.d     $f0,64($fp)
        addu    $v0,$fp,64
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L50:
        la      $a0,__sF+176
        la      $a1,$LC9
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L49:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L53:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L54
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L55
        l.d     $f0,48($fp)
        trunc.w.d $f2,$f0,$a0
        l.d     $f0,56($fp)
        trunc.w.d $f4,$f0,$a0
        mfc1    $v0,$f4
        mfc1    $a0,$f2
        div     $0,$a0,$v0
        mfhi    $v1
        .set    noreorder
        bne     $v0,$0,1f
        nop
        break   7
1:
        .set    reorder
        mtc1    $v1,$f2
        cvt.d.w $f0,$f2
        s.d     $f0,64($fp)
        addu    $v0,$fp,64
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L55:
        la      $a0,__sF+176
        la      $a1,$LC9
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L54:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L58:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L59
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L60
        l.d     $f2,56($fp)
        mtc1    $zero,$f0
        mtc1    $zero,$f1
        c.eq.d  $f2,$f0
        bc1f    $L62
        b       $L61
$L62:
        l.d     $f2,48($fp)
        l.d     $f0,56($fp)
        div.d   $f0,$f2,$f0
        s.d     $f0,64($fp)
        addu    $v0,$fp,64
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L61:
        la      $a0,__sF+176
        la      $a1,$LC11
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L60:
        la      $a0,__sF+176
        la      $a1,$LC9
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L59:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L66:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        bne     $v0,$zero,$L67
        la      $a0,__sF+176
        la      $a1,$LC12
        la      $t9,fprintf
        jal     $ra,$t9
$L67:
        .set    noreorder
        nop
        .set    reorder
$L68:
        lw      $v0,72($fp)
        bne     $v0,$zero,$L70
        b       $L28
$L70:
        la      $a0,$LC13
        lw      $a2,48($fp)
        lw      $a3,52($fp)
        la      $t9,printf
        jal     $ra,$t9
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        b       $L68
$L71:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L72
        la      $a0,$LC13
        lw      $a2,48($fp)
        lw      $a3,52($fp)
        la      $t9,printf
        jal     $ra,$t9
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L72:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L74:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L75
        la      $a0,$LC14
        lw      $a2,48($fp)
        lw      $a3,52($fp)
        la      $t9,printf
        jal     $ra,$t9
        b       $L28
$L75:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L77:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L78
        l.d     $f12,48($fp)
        la      $t9,sqrt
        jal     $ra,$t9
        s.d     $f0,56($fp)
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L78:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L80:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        bne     $v0,$zero,$L81
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
$L81:
        lw      $a0,100($fp)
        la      $t9,destruir_stack
        jal     $ra,$t9
        b       $L28
$L82:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L83
        l.d     $f0,48($fp)
        add.d   $f0,$f0,$f0
        s.d     $f0,56($fp)
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L83:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L85:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L86
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_pop
        jal     $ra,$t9
        sw      $v0,72($fp)
        lw      $v0,72($fp)
        beq     $v0,$zero,$L87
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        addu    $v0,$fp,56
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        b       $L28
$L87:
        addu    $v0,$fp,48
        lw      $a0,100($fp)
        move    $a1,$v0
        la      $t9,tda_stack_push
        jal     $ra,$t9
        la      $a0,__sF+176
        la      $a1,$LC15
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L86:
        la      $a0,__sF+176
        la      $a1,$LC10
        la      $t9,fprintf
        jal     $ra,$t9
        b       $L28
$L92:
        lw      $v1,96($fp)
        lw      $v0,28($fp)
        addu    $v0,$v1,$v0
        lb      $v0,0($v0)
        la      $a0,__sF+176
        la      $a1,$LC16
        move    $a2,$v0
        la      $t9,fprintf
        jal     $ra,$t9
$L28:
        lw      $v0,28($fp)
        addu    $v0,$v0,1
        sw      $v0,28($fp)
        b       $L24
$L25:
        lw      $a0,24($fp)
        la      $t9,free
        jal     $ra,$t9
        move    $sp,$fp
        lw      $ra,88($sp)
        lw      $fp,84($sp)
        addu    $sp,$sp,96
        j       $ra
        .end    ejecutar
        .size   ejecutar, .-ejecutar
        .rdata
        .align  2
$LC17:
        .ascii  "r\000"
        .text
        .align  2
        .globl  ejecutar_desde_archivo
        .ent    ejecutar_desde_archivo
ejecutar_desde_archivo:
        .frame  $fp,56,$ra              # vars= 16, regs= 3/0, args= 16, extra= 8
        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,56
        .cprestore 16
        sw      $ra,48($sp)
        sw      $fp,44($sp)
        sw      $gp,40($sp)
        move    $fp,$sp
        sw      $a0,56($fp)
        sw      $a1,60($fp)
        lw      $a0,56($fp)
        la      $a1,$LC17
        la      $t9,fopen
        jal     $ra,$t9
        sw      $v0,32($fp)
        lw      $v0,32($fp)
        bne     $v0,$zero,$L95
        li      $v0,1                   # 0x1
        sw      $v0,36($fp)
        b       $L94
$L95:
        lw      $a0,32($fp)
        move    $a1,$zero
        li      $a2,2                   # 0x2
        la      $t9,fseek
        jal     $ra,$t9
        lw      $a0,32($fp)
        la      $t9,ftell
        jal     $ra,$t9
        sw      $v0,24($fp)
        lw      $a0,32($fp)
        la      $t9,rewind
        jal     $ra,$t9
        lw      $a0,24($fp)
        la      $t9,malloc
        jal     $ra,$t9
        sw      $v0,28($fp)
        lw      $a0,28($fp)
        li      $a1,1                   # 0x1
        lw      $a2,24($fp)
        lw      $a3,32($fp)
        la      $t9,fread
        jal     $ra,$t9
        lw      $v1,28($fp)
        lw      $v0,24($fp)
        addu    $v0,$v1,$v0
        addu    $v0,$v0,-1
        sb      $zero,0($v0)
        lw      $a0,32($fp)
        la      $t9,fclose
        jal     $ra,$t9
        lw      $a0,28($fp)
        lw      $a1,60($fp)
        la      $t9,ejecutar
        jal     $ra,$t9
        lw      $a0,28($fp)
        la      $t9,free
        jal     $ra,$t9
        sw      $zero,36($fp)
$L94:
        lw      $v0,36($fp)
        move    $sp,$fp
        lw      $ra,48($sp)
        lw      $fp,44($sp)
        addu    $sp,$sp,56
        j       $ra
        .end    ejecutar_desde_archivo
        .size   ejecutar_desde_archivo, .-ejecutar_desde_archivo
        .rdata
        .align  2
$LC18:
        .ascii  "ERROR: No hay recursos para comenzar el procesamiento..."
        .ascii  "\n\000"
        .align  2
$LC19:
        .ascii  "ERROR: No hay recursos para continuar el procesamiento.."
        .ascii  ".\n\000"
        .text
        .align  2
        .globl  leerEntradaStd
        .ent    leerEntradaStd
leerEntradaStd:
        .frame  $fp,80,$ra              # vars= 40, regs= 3/0, args= 16, extra= 8
        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,80
        .cprestore 16
        sw      $ra,72($sp)
        sw      $fp,68($sp)
        sw      $gp,64($sp)
        move    $fp,$sp
        sw      $a0,80($fp)
        sw      $zero,48($fp)
        li      $a0,11                  # 0xb
        li      $a1,1                   # 0x1
        la      $t9,calloc
        jal     $ra,$t9
        sw      $v0,24($fp)
        lw      $v0,24($fp)
        bne     $v0,$zero,$L97
        la      $a0,__sF+176
        la      $a1,$LC18
        la      $t9,fprintf
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,52($fp)
        b       $L96
$L97:
        sw      $zero,28($fp)
        li      $v0,10                  # 0xa
        sw      $v0,32($fp)
$L98:
        la      $a0,__sF
        la      $t9,fgetc
        jal     $ra,$t9
        sb      $v0,44($fp)
        lw      $v1,28($fp)
        lw      $v0,32($fp)
        bne     $v1,$v0,$L101
        lw      $v0,24($fp)
        sw      $v0,40($fp)
        lw      $v1,28($fp)
        li      $v0,-859045888                  # 0xffffffffcccc0000
        ori     $v0,$v0,0xcccd
        multu   $v1,$v0
        mfhi    $v0
        srl     $v1,$v0,3
        move    $v0,$v1
        sll     $v0,$v0,2
        addu    $v0,$v0,$v1
        sll     $v0,$v0,1
        addu    $v0,$v0,10
        lw      $a0,24($fp)
        move    $a1,$v0
        la      $t9,realloc
        jal     $ra,$t9
        sw      $v0,24($fp)
        lw      $v0,24($fp)
        bne     $v0,$zero,$L102
        la      $a0,__sF+176
        la      $a1,$LC19
        la      $t9,fprintf
        jal     $ra,$t9
        lw      $a0,40($fp)
        la      $t9,free
        jal     $ra,$t9
        sw      $zero,40($fp)
        li      $v0,1                   # 0x1
        sw      $v0,52($fp)
        b       $L96
$L102:
        lw      $v0,32($fp)
        addu    $v0,$v0,10
        sw      $v0,32($fp)
$L101:
        lb      $v1,44($fp)
        sw      $v1,56($fp)
        li      $v0,-1                  # 0xffffffffffffffff
        lw      $v1,56($fp)
        beq     $v1,$v0,$L103
        li      $v0,10                  # 0xa
        lw      $v1,56($fp)
        beq     $v1,$v0,$L104
        b       $L107
$L104:
        lw      $v1,24($fp)
        lw      $v0,48($fp)
        addu    $v0,$v1,$v0
        sb      $zero,0($v0)
        lw      $a0,24($fp)
        lw      $a1,80($fp)
        la      $t9,ejecutar
        jal     $ra,$t9
        lw      $a0,24($fp)
        la      $t9,free
        jal     $ra,$t9
        li      $a0,11                  # 0xb
        li      $a1,1                   # 0x1
        la      $t9,calloc
        jal     $ra,$t9
        sw      $v0,24($fp)
        lw      $v0,24($fp)
        bne     $v0,$zero,$L105
        la      $a0,__sF+176
        la      $a1,$LC19
        la      $t9,fprintf
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,52($fp)
        b       $L96
$L105:
        sw      $zero,28($fp)
        li      $v0,10                  # 0xa
        sw      $v0,32($fp)
        sw      $zero,48($fp)
        b       $L103
$L107:
        lw      $v1,24($fp)
        lw      $v0,48($fp)
        addu    $v1,$v1,$v0
        lbu     $v0,44($fp)
        sb      $v0,0($v1)
        lw      $v0,48($fp)
        addu    $v0,$v0,1
        sw      $v0,48($fp)
        lw      $v0,28($fp)
        addu    $v0,$v0,1
        sw      $v0,28($fp)
$L103:
        la      $a0,__sF+88
        la      $t9,fflush
        jal     $ra,$t9
        lb      $v1,44($fp)
        li      $v0,-1                  # 0xffffffffffffffff
        bne     $v1,$v0,$L98
        lw      $a0,24($fp)
        la      $t9,free
        jal     $ra,$t9
        sw      $zero,52($fp)
$L96:
        lw      $v0,52($fp)
        move    $sp,$fp
        lw      $ra,72($sp)
        lw      $fp,68($sp)
        addu    $sp,$sp,80
        j       $ra
        .end    leerEntradaStd
        .size   leerEntradaStd, .-leerEntradaStd
        .rdata
        .align  2
$LC21:
        .ascii  "help\000"
        .align  2
$LC22:
        .ascii  "version\000"
        .align  2
$LC23:
        .ascii  "scriptfile\000"
        .align  2
$LC24:
        .ascii  "script\000"
        .data
        .align  2
$LC25:
        .word   $LC21
        .word   0
        .word   0
        .word   104
        .word   $LC22
        .word   0
        .word   0
        .word   86
        .word   $LC23
        .word   1
        .word   0
        .word   102
        .word   $LC24
        .word   1
        .word   0
        .word   101
        .word   0
        .word   0
        .word   0
        .word   0
        .globl  memcpy
        .rdata
        .align  2
$LC20:
        .ascii  "hVf:e:\000"
        .align  2
$LC26:
        .ascii  "ERROR: No se pudo abrir el archivo %s.\n\000"
        .align  2
$LC27:
        .ascii  "ERROR: Faltan argumentos.\n\000"
        .text
        .align  2
        .globl  main
        .ent    main
main:
        .frame  $fp,184,$ra             # vars= 136, regs= 3/0, args= 24, extra= 8
        .mask   0xd0000000,-8
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,184
        .cprestore 24
        sw      $ra,176($sp)
        sw      $fp,172($sp)
        sw      $gp,168($sp)
        move    $fp,$sp
        sw      $a0,184($fp)
        sw      $a1,188($fp)
        sw      $zero,56($fp)
        la      $v0,$LC20
        sw      $v0,60($fp)
        addu    $v0,$fp,64
        la      $v1,$LC25
        move    $a0,$v0
        move    $a1,$v1
        li      $a2,80                  # 0x50
        la      $t9,memcpy
        jal     $ra,$t9
        sw      $zero,144($fp)
        sw      $zero,152($fp)
        addu    $a0,$fp,32
        li      $a1,8                   # 0x8
        la      $t9,tda_stack_crear
        jal     $ra,$t9
        addu    $v0,$fp,48
        move    $a0,$v0
        la      $a1,$LC2
        la      $t9,strcpy
        jal     $ra,$t9
        lw      $v1,184($fp)
        li      $v0,1                   # 0x1
        bne     $v1,$v0,$L113
        addu    $a0,$fp,32
        la      $t9,leerEntradaStd
        jal     $ra,$t9
        sw      $v0,156($fp)
        b       $L110
$L113:
        addu    $v0,$fp,64
        sw      $zero,16($sp)
        lw      $a0,184($fp)
        lw      $a1,188($fp)
        lw      $a2,60($fp)
        move    $a3,$v0
        la      $t9,getopt_long
        jal     $ra,$t9
        sw      $v0,40($fp)
        lw      $v0,40($fp)
        sw      $v0,160($fp)
        li      $v0,101                 # 0x65
        lw      $v1,160($fp)
        beq     $v1,$v0,$L120
        lw      $v1,160($fp)
        slt     $v0,$v1,102
        beq     $v0,$zero,$L127
        li      $v0,63                  # 0x3f
        lw      $v1,160($fp)
        beq     $v1,$v0,$L122
        lw      $v1,160($fp)
        slt     $v0,$v1,64
        beq     $v0,$zero,$L128
        li      $v0,-1                  # 0xffffffffffffffff
        lw      $v1,160($fp)
        beq     $v1,$v0,$L115
        li      $v0,58                  # 0x3a
        lw      $v1,160($fp)
        beq     $v1,$v0,$L124
        b       $L115
$L128:
        li      $v0,86                  # 0x56
        lw      $v1,160($fp)
        beq     $v1,$v0,$L121
        b       $L115
$L127:
        li      $v0,102                 # 0x66
        lw      $v1,160($fp)
        beq     $v1,$v0,$L118
        li      $v0,104                 # 0x68
        lw      $v1,160($fp)
        beq     $v1,$v0,$L117
        b       $L115
$L117:
        la      $a0,__sF+88
        move    $a1,$zero
        la      $t9,imprimir_ayuda
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,152($fp)
        b       $L115
$L118:
        li      $v0,1                   # 0x1
        sw      $v0,144($fp)
        lw      $a0,optarg
        addu    $a1,$fp,32
        la      $t9,ejecutar_desde_archivo
        jal     $ra,$t9
        sw      $v0,148($fp)
        lw      $v1,148($fp)
        li      $v0,1                   # 0x1
        bne     $v1,$v0,$L119
        la      $a0,__sF+176
        la      $a1,$LC26
        lw      $a2,optarg
        la      $t9,fprintf
        jal     $ra,$t9
$L119:
        li      $v0,1                   # 0x1
        sw      $v0,152($fp)
        b       $L115
$L120:
        lw      $a0,optarg
        addu    $a1,$fp,32
        la      $t9,ejecutar
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,152($fp)
        b       $L115
$L121:
        la      $a0,__sF+88
        move    $a1,$zero
        la      $t9,imprimir_version
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,152($fp)
        b       $L115
$L122:
        la      $a0,__sF+176
        li      $a1,1                   # 0x1
        la      $t9,imprimir_ayuda
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,152($fp)
        b       $L115
$L124:
        la      $a0,__sF+176
        la      $a1,$LC27
        la      $t9,fprintf
        jal     $ra,$t9
$L115:
        lw      $v1,40($fp)
        li      $v0,-1                  # 0xffffffffffffffff
        bne     $v1,$v0,$L113
        lw      $v0,152($fp)
        bne     $v0,$zero,$L130
        lw      $v0,184($fp)
        slt     $v0,$v0,2
        bne     $v0,$zero,$L130
        lw      $v0,188($fp)
        addu    $v0,$v0,4
        lw      $a0,0($v0)
        addu    $a1,$fp,32
        la      $t9,ejecutar
        jal     $ra,$t9
$L130:
        lw      $v0,144($fp)
        beq     $v0,$zero,$L131
        lw      $v0,optind
        sw      $v0,56($fp)
$L132:
        lw      $v0,56($fp)
        lw      $v1,184($fp)
        slt     $v0,$v0,$v1
        bne     $v0,$zero,$L135
        b       $L131
$L135:
        lw      $v0,56($fp)
        sll     $v1,$v0,2
        lw      $v0,188($fp)
        addu    $v0,$v1,$v0
        lw      $a0,0($v0)
        addu    $a1,$fp,32
        la      $t9,ejecutar_desde_archivo
        jal     $ra,$t9
        sw      $v0,148($fp)
        lw      $v1,148($fp)
        li      $v0,1                   # 0x1
        bne     $v1,$v0,$L134
        lw      $v0,56($fp)
        sll     $v1,$v0,2
        lw      $v0,188($fp)
        addu    $v0,$v1,$v0
        la      $a0,__sF+176
        la      $a1,$LC26
        lw      $a2,0($v0)
        la      $t9,fprintf
        jal     $ra,$t9
$L134:
        lw      $v0,56($fp)
        addu    $v0,$v0,1
        sw      $v0,56($fp)
        b       $L132
$L131:
        addu    $v0,$fp,48
        move    $a0,$v0
        addu    $a1,$fp,32
        la      $t9,ejecutar
        jal     $ra,$t9
        addu    $a0,$fp,32
        la      $t9,destruir_stack
        jal     $ra,$t9
        sw      $zero,156($fp)
$L110:
        lw      $v0,156($fp)
        move    $sp,$fp
        lw      $ra,176($sp)
        lw      $fp,172($sp)
        addu    $sp,$sp,184
        j       $ra
        .end    main
        .size   main, .-main
        .ident  "GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
