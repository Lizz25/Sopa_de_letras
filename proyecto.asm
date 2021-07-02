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
    mov bh,0   ;indica la pantalla
    mov dh,r   ;ndica el renglon(0-24)
    mov dl,c   ;indca la columna (0-79)
    mov ah,2   ;indica el servicio de la nterrupcion 
    int 10h
endm
.model small
.data
    LF equ 10 ; salto de linea
    CR equ 13 ; Retorno de carro
    TB equ 09 ; tab
    var1 db ?
    msg1 db "-----------** Sopa de letras **----------- $"
    msjE db "Elija una tematica para su sopa de letra $"
    msjO1 db "1.- Animales $"
    msjO2 db "2.- Vehiculos de transporte $" 
    msjO3 db "3.- Lenguajes de programacion $"
    msjop db "Escriba el numero de la opcion que desea: $"
    msg2  db "Escriba la palabra que encuentre, o escriba exit para salir$",0
    
.code
.start up  

    mPosrc 1,20
    mImprimC msg1 
    mPosrc 3,4
    mImprimC msjE
    mPosrc 4,4
    mImprimC msjO1 
    mPosrc 5,4
    mImprimC msjO2
    mPosrc 6,4
    mImprimC msjO3 
    mPosrc 8,4  
    mImprimC msjop

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

end 

