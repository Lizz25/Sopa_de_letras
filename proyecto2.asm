mLimpia macro 
    mov ah, 0FH
    int 10h
    mov ah,0
    int 10h
endm 

mPausa macro
    mov ah,07h
    int 21h
endm

mImprimC macro t
    lea dx, t
    mov ah, 09h
    int 21h    
endm

mPosrc macro r,c
    mov bh,0     ;indica la pantalla
    mov dh,r     ;indica el renglon(0-24)
    mov dl,c     ;indca la columna (0-79)
    mov ah,2     ;indica el servicio de la interrupcion 
    int 10h
endm 

mValidarNum macro n1  ;valida que se ingrese un numero valido en el menu 
    lea dx, msjError
    mov ah, 09h
    int 21h
    cmp n1, 0
    jna ObtenerOp
    cmp n1,3
    ja ObtenerOp
    cmp n1, 9
    ja ObtenerOp
endm  

.model small
.data
    LF equ 10 ; salto de linea
    CR equ 13 ; Retorno de carro
    TB equ 09 ; tab
    var1 db ?
    menu1 db "-----------** Sopa de letras **-----------"  ,LF,CR,LF,TB
         db  "Elija una tematica para su sopa de letra "  ,LF,CR,TB 
         db   "1.- Animales "                            ,LF,CR,TB 
         db   "2.- Vehiculos de transporte "              ,LF,CR,TB
         db   "3.- Lenguajes de programacion "            ,LF,CR,,TB,LF
         db   "Escriba el numero de la opcion que desea: $",LF,CR 
    op db 0
    mOp1 db "Sopa de letras: Animales $"
    mOp2 db "Sopa de letras: Vehiculos de transporte $"
    mOp3 db "Sopa de letras: Lenguajes de programacion $"   
    volver db 0 
    msjError db CR,LF,TB, "Ingrese una opcion correcta: $"
    
.code
.start up    


    menuPrincipal: 
    mPosrc 1,20
    mImprimC menu1 
    
    ObtenerOp:         ;Recoge la opcion y valida que el numero ngresado sea correcto 
    call leer         
    sub al, 30h      
    mov op, al 
    mValidarNum op
     
     
    cmp op, 1
    je opcion1
    cmp op,2
    je opcion2
    jnz opcion3

    
    opcion1: 
    mLimpia 
    mPosrc 1,20
    mImprimC mOp1  
    mPosrc 3,4
    ;mImprimC msg2
    mPausa
    
    
    opcion2:  
    mLimpia 
    mPosrc 1,20
    mImprimC mOp2 
    mPosrc 3,4
    ;mImprimC msg2
    mPausa
    
    opcion3: 
    mLimpia 
    mPosrc 1,20
    mImprimC mOp3
    mPosrc 3,4
    ;mImprimC msg2
    mPausa
  

.exit   

pLimpia proc near 
    mov ah, 0FH
    int 10h
    mov ah,0
    int 10h    
    ret
pLimpia endp   

pPausa proc near
    mov ah, 07h
    int 21h
    ret
pPausa endp  

leer proc near 
    mov ah, 01h ;leer desde el teclado 
    int 21h
    ret 
leer endp  

 

end 