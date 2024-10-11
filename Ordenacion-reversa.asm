.data
iArray:  .word 5, 34, 16, 27, 12
size:    .word 5
msg1:    .asciiz "Lista desordenada: "
msg2:    .asciiz "\nLista ordenada: "
espacio:   .asciiz " "

.text
.globl iniciar

iniciar:
    li $v0, 4
    la $a0, msg1
    syscall

    la $t2, iArray
    lw $t0, size
    li $t1, 0

imprimir_lista_desordenada:
    beq $t1, $t0, comenzar_ordenamiento
    lw $a0, 0($t2)
    li $v0, 1
    syscall
    la $a0, espacio
    li $v0, 4
    syscall
    addi $t2, $t2, 4
    addi $t1, $t1, 1
    j imprimir_lista_desordenada

comenzar_ordenamiento:
    la $a0, iArray
    lw $t0, size
    sll $t0, $t0, 2        
    add $a1, $a0, $t0      
    addi $a1, $a1, -4      
    j seleccionar_ordenamiento

seleccionar_ordenamiento:
    bge $a0, $a1, imprimir_lista_ordenada 
    move $t3, $a1                  
    jal encontrar_maximo_valor           
    lw $t0, 0($a1)                 
    lw $t1, 0($v0)                 
    sw $t0, 0($v0)                
    sw $t1, 0($a1)                
    addi $a1, $a1, -4             
    j seleccionar_ordenamiento

imprimir_lista_ordenada:
    li $v0, 4
    la $a0, msg2
    syscall

    la $t2, iArray
    lw $t0, size
    li $t1, 0

imprimir_lista_ordenada_loop:
    beq $t1, $t0, salir
    lw $a0, 0($t2)
    li $v0, 1
    syscall
    la $a0, espacio
    li $v0, 4
    syscall
    addi $t2, $t2, 4
    addi $t1, $t1, 1
    j imprimir_lista_ordenada_loop

salir:
    li $v0, 10
    syscall

encontrar_maximo_valor:
    move $t1, $a0                 
    lw $v1, 0($t1)                
    move $v0, $t1                
    addi $t1, $t1, 4             

ciclo_encontrar_maximo:
    bgt $t1, $t3, maximo_encontrado  
    lw $t2, 0($t1)               
    bge $t2, $v1, siguiente_maximo        
    move $v1, $t2               
    move $v0, $t1    
           

siguiente_maximo:
    addi $t1, $t1, 4            
    j ciclo_encontrar_maximo

maximo_encontrado:
    jr $ra                      
