llenarS macro palabra
    local llenar,next,terminar
    llenar:
        mov al, palabra[si]
        mov temp[si],al
        cmp si,0
        jnz next
        jz terminar
        
    next:
        sub si, 1
        jmp llenar
        
    terminar:
endm

mImprimC macro t
    lea dx, t
    mov ah, 09h
    int 21h    
endm

mLimpia macro 
    mov ah, 0FH
    int 10h
    mov ah,0
    int 10h
endm

verificarP macro lon texto inicio final
    mov si,lon
    llenarS texto
    mov cl,lon
    mov coordenadaI,inicio
    mov coordenadaF,final
    call verificarIn
endm

.model small
.data
    LF equ 10 ; salto de linea
    CR equ 13 ; Retorno de carro
    TB equ 09 ; tab   
    ingreso db LF,"Ingreso: $"
    perro db "perro"
    delfin db "delfin"
    gato db "gato"    
    tiburon db "tiburon"
    leon db "leon"
    
    sopa1 db "l a p e r r o c f t q c f t q",LF,CR
          db "r a t q u x u r a t q u t o r",LF,CR
          db "b r w v t i g e d e l f i n o",LF,CR
          db "v r e y e b r b p a m b w x q",LF,CR 
          db "l g d t d t f d i v v z v v c",LF,CR
          db "e r c e c i w s y n f v x d x",LF,CR
          db "o e z d b b e a r v m v x g z",LF,CR
          db "n b d w b u q s u j e v x v q",LF,CR
          db "b f t y c r p f z g a t o m d",LF,CR
          db "n h u i n o m e g r m v f b v",LF,CR
          db "j k c u x n v t h w j v v c u",LF,CR
          db "g m j t o u w u z d x c y b t",LF,CR
          db "o x p r t q y h x b v b f v y",LF,CR
          db "t f o d w c b q v n o h e d m",LF,CR
          db "a d w a n x n b a c m v w q r",LF,CR,"$"
          
          
    var1 db LF,CR,"Bien",LF,CR,"$"
    var2 db LF,CR,"Mal",LF,CR,"$"
    cadena db 15,?,15 dup(' ')
    temp db 15 dup(' ')
    coordenadaI dw ?
    coordenadaF dw ?     
          
.code
.start up    
                                                                       
mostrarMatriz:
    mLimpia
    mImprimC sopa1

pedirPalabra:
    mImprimC ingreso
    mov ax,0000h
    mov bx,0000h 
    mov cx,0000h 
    mov dx,0000h 
    mov dx, offset cadena
    mov ah, 0ah
    int 21h

;Verificar leon
    mov si,3
    llenarS leon
    mov cx,3
    mov coordenadaI,0400h
    mov coordenadaF,0700h
    call verificarIn
    
;Verificar perro
    mov si,4
    llenarS perro
    mov cx,4
    mov coordenadaI,0004h
    mov coordenadaF,000Ch
    call verificarIn

;Verificar delfin
    mov si,5
    llenarS delfin
    mov cx,5
    mov coordenadaI,0210h
    mov coordenadaF,021Ah
    call verificarIn
    
;verificarP 5 delfin 0210h 021Ah

;Verificar tiburon
    mov si,6
    llenarS tiburon
    mov cx,6
    mov coordenadaI,040Ah
    mov coordenadaF,0A0Ah
    call verificarIn

;Verificar gato
    mov si,3
    llenarS gato
    mov cx,3
    mov coordenadaI,0811h
    mov coordenadaF,0819h
    call verificarIn
    
salir:
.exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;procedimientos;;;;;;;;;;;;;;;;;;;;;   
verificarIn     PROC
    mov bx,0
    mov al, cadena[1]
    sub al,1
    cmp al, cl
    jb mostrarm
    ja mostrarm
    
    recorrer:
        mov al, cadena[bx+2]
        mov ah, temp[bx]
        cmp al,ah
        jz esfin
        jnz mostrarm

    esfin:
        cmp bx,cx
        jz finCadena
        jnz aumentar

    aumentar:
        add bl,1
        jmp recorrer
    
    finCadena:
        mov al, cadena[1]
        sub al,1
        cmp bl,al
        jz mostrarb
        jnz mostrarm
    
    mostrarb:
        call resaltarP
        jmp mostrarMatriz

    mostrarm:
        ;lea dx, var2
        ;mov ah, 09
        ;int 21h
        jmp termino
        
    termino: 
        RET
verificarIn     ENDP

resaltarP PROC
    MOV Ax,0600h  ;modo video (creo)
    MOV BH,00001110b ;color que se modifico 0 ->parpadeo 000 -> color fondo 0000 ->Color fuente
    MOV CX,coordenadaI   ; pixeles de donde empieza a colorear   ch ->fila    cl->columna
    MOV DX,coordenadaF   ; pixeles de donde termina de colorear  dh ->fila    dl->columna
    INT 10H   
    RET
resaltarP ENDP
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
end