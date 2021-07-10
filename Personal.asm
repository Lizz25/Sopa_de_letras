.model small
.data
    LF equ 10 ; salto de linea
    CR equ 13 ; Retorno de carro
    TB equ 09 ; tab   
    ingreso db LF,"Ingreso: $"
    perro db "perro"
    
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
          
          
    var1 db "Bien",LF,CR,"$"
    var2 db "Mal",LF,CR,"$"
    cadena db 15,?,15 dup(' ')
    igual db 0
          
          
.code
.start up    

;mov ax,0000h
;mov bx,0000h 
;mov cx,0000h 
;mov dx,0000h 

;RESALTAR LEON
;MOV Ah,06h ;modo video (creo)    al -> (No he probado como funciona dandole valor)
;MOV BH,00001110b ;color que se modifico 0 ->parpadeo 000 -> color fondo 0000 ->Color fuente
;MOV CX,0400h ; pixeles de donde empieza a colorear   ch ->fila    cl->columna
;MOV DX,0700h ; pixeles de donde termina de colorear  dh ->fila    dl->columna
;INT 10H  


;RESALTAR PERRO
;MOV Ah,06h 
;MOV BH,00001110b 
;MOV CX,0004h 
;MOV DX,000Ch 
;INT 10H 


;RESALTAR TIBURON
;MOV Ah,06h 
;MOV BH,00001110b 
;MOV CX,040Ah 
;MOV DX,0A0Ah
;INT 10H


;RESALTAR DELFIN
;MOV Ah,06h 
;MOV BH,00001110b 
;MOV CX,0210h 
;MOV DX,021Ah
;INT 10H


;RESALTAR GATO
;MOV Ah,06h 
;MOV BH,00001110b 
;MOV CX,0811h 
;MOV DX,0819h
;INT 10H
 
;lea dx, sopa1
;mov ah, 09
;int 21h  

;Pedir palabra 
 
pedirPalabra:
mov ax,0000h
mov bx,0000h 
mov cx,0000h 
mov dx,0000h 

mov dx, offset cadena
mov ah, 0ah
int 21h
;mov bl, 2
mov cl,0

recorrer:
mov al, cadena[bx+2]
mov ah, perro[bx]
cmp al,ah
jz esfin
jnz mostrarm


esfin:
cmp bx,4
jz mostrarb
jnz aumentar

aumentar:
add bl,1
jmp recorrer


mostrarb:
lea dx, var1
mov ah, 09
int 21h
jmp salir

mostrarm:
lea dx, var2
mov ah, 09
int 21h
jmp salir



salir:
.exit