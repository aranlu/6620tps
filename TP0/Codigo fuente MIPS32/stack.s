        .file   1 "stack.c"
        .section .mdebug.abi32
        .previous
        .abicalls
        .text
        .align  2
        .globl  tda_stack_crear
        .ent    tda_stack_crear
tda_stack_crear:
        .frame  $fp,16,$ra              # vars= 0, regs= 2/0, args= 0, extra= 8
        .mask   0x50000000,-4
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,16
        .cprestore 0
        sw      $fp,12($sp)
        sw      $gp,8($sp)
        move    $fp,$sp
        sw      $a0,16($fp)
        sw      $a1,20($fp)
        lw      $v0,16($fp)
        sw      $zero,0($v0)
        lw      $v1,16($fp)
        lw      $v0,20($fp)
        sw      $v0,4($v1)
        li      $v0,1                   # 0x1
        move    $sp,$fp
        lw      $fp,12($sp)
        addu    $sp,$sp,16
        j       $ra
        .end    tda_stack_crear
        .size   tda_stack_crear, .-tda_stack_crear
        .align  2
        .globl  tda_stack_push
        .ent    tda_stack_push
tda_stack_push:
        .frame  $fp,48,$ra              # vars= 8, regs= 4/0, args= 16, extra= 8        .mask   0xd0010000,-4
        .fmask  0x00000000,0
        .set    noreorder
        .cpload $t9
        .set    reorder
        subu    $sp,$sp,48
        .cprestore 16
        sw      $ra,44($sp)
        sw      $fp,40($sp)
        sw      $gp,36($sp)
        sw      $s0,32($sp)
        move    $fp,$sp
        sw      $a0,48($fp)
        sw      $a1,52($fp)
        li      $a0,8                   # 0x8
        la      $t9,malloc
        jal     $ra,$t9
        sw      $v0,24($fp)
        lw      $v0,24($fp)
        bne     $v0,$zero,$L15
        sw      $zero,28($fp)
        b       $L14
$L15:
        lw      $s0,24($fp)
        lw      $v0,48($fp)
        lw      $a0,4($v0)
        la      $t9,malloc
        jal     $ra,$t9
        sw      $v0,4($s0)
        lw      $v0,24($fp)
        lw      $v0,4($v0)
        bne     $v0,$zero,$L16
        lw      $a0,24($fp)
        la      $t9,free
        jal     $ra,$t9
        sw      $zero,28($fp)
        b       $L14
$L16:
        lw      $v0,24($fp)
        lw      $v1,48($fp)
        lw      $a0,4($v0)
        lw      $a1,52($fp)
        lw      $a2,4($v1)
        la      $t9,memcpy
        jal     $ra,$t9
        lw      $v1,24($fp)
        lw      $v0,48($fp)
        lw      $v0,0($v0)
        sw      $v0,0($v1)
        lw      $v1,48($fp)
        lw      $v0,24($fp)
        sw      $v0,0($v1)
        li      $v0,1                   # 0x1
        sw      $v0,28($fp)
$L14:
        lw      $v0,28($fp)
        move    $sp,$fp
        lw      $ra,44($sp)
        lw      $fp,40($sp)
        lw      $s0,32($sp)
        addu    $sp,$sp,48
        j       $ra
        .end    tda_stack_push
        .size   tda_stack_push, .-tda_stack_push
        .align  2
        .globl  tda_stack_pop
        .ent    tda_stack_pop
tda_stack_pop:
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
        sw      $a1,52($fp)
        lw      $v0,48($fp)
        lw      $v0,0($v0)
        bne     $v0,$zero,$L18
        sw      $zero,28($fp)
        b       $L17
$L18:
        lw      $v0,48($fp)
        lw      $v0,0($v0)
        lw      $v1,48($fp)
        lw      $a0,52($fp)
        lw      $a1,4($v0)
        lw      $a2,4($v1)
        la      $t9,memcpy
        jal     $ra,$t9
        lw      $v0,48($fp)
        lw      $v0,0($v0)
        sw      $v0,24($fp)
        lw      $v1,48($fp)
        lw      $v0,24($fp)
        lw      $v0,0($v0)
        sw      $v0,0($v1)
        lw      $v0,24($fp)
        lw      $a0,4($v0)
        la      $t9,free
        jal     $ra,$t9
        lw      $a0,24($fp)
        la      $t9,free
        jal     $ra,$t9
        li      $v0,1                   # 0x1
        sw      $v0,28($fp)
$L17:
        lw      $v0,28($fp)
        move    $sp,$fp
        lw      $ra,40($sp)
        lw      $fp,36($sp)
        addu    $sp,$sp,48
        j       $ra
        .end    tda_stack_pop
        .size   tda_stack_pop, .-tda_stack_pop
        .ident  "GCC: (GNU) 3.3.3 (NetBSD nb3 20040520)"
