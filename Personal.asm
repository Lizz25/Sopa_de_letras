;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
    local empezarVerificar,terminar
     
    mov al, cadena[1]
    sub al,1
    cmp al, lon
    jb terminar
    ja terminar
    
    empezarVerificar:
        mov si,lon
        llenarS texto
        mov cl,lon
        mov coordenadaI,inicio
        mov coordenadaF,final
        call verificarIn
        
    terminar:
    
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.model small
.data
    LF equ 10 ; salto de linea
    CR equ 13 ; Retorno de carro
    TB equ 09 ; tab
    ingreso db LF,"Ingreso: $"
    cadena db 15,?,15 dup(' ')
    temp db 15 dup(' ')
    coordenadaI dw ?
    coordenadaF dw ?
    aciertos db 0
    esExit db 0
    mExit db "exit"
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Sopa - Animales ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    perro db "perro"
    delfin db "delfin"
    gato db "gato"    
    tiburon db "tiburon"
    leon db "leon"
    
    sopaA1 db "l a p e r r o c f t q c f t q",LF,CR
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
          
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    caballo db "caballo"
    llama db "llama"
    avestruz db "avestruz"    
    buey db "buey"
    jirafa db "jirafa"
    
    sopaA2 db "l a f s f e a c f t q c f t l",LF,CR
           db "r a t q u x u r a t q u t o l",LF,CR
           db "b r w v t i g e z x l n p n a",LF,CR
           db "v r a v e s t r u z m b w x m",LF,CR 
           db "l g d t d t f d i v v z v v a",LF,CR
           db "d r c e c c w s y n f v x d x",LF,CR
           db "o e z d b b e a r v m v x g z",LF,CR
           db "r b c a b a l l o j e v x v q",LF,CR
           db "b f t y c k p f z i w t o m d",LF,CR
           db "n h u i n o m e g r m v f b v",LF,CR
           db "j k c u x n v t h a j v v c u",LF,CR
           db "g m j t o u w u z f x c y b t",LF,CR
           db "o x p r t q y h x a v b f v y",LF,CR
           db "t b u e y c b q v n o h e d m",LF,CR
           db "a d w a n x n b a c m v w q r",LF,CR,"$"
          
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Sopa - Transporte ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    barco db "barco"
    carro db "carro"
    moto db "moto"    
    bicicleta db "bicicleta"
    avion db "avion"
    
    sopaT1 db "c s g a s f e c f t q c f t q",LF,CR
           db "a a t q u x u r b a r c o o r",LF,CR
           db "r r w v b a r c d e s c z x o",LF,CR
           db "r r e m o t o b p a m b w x q",LF,CR 
           db "o g d t d t f d i v v z v v c",LF,CR
           db "e r c e c c w s y b f v x d x",LF,CR
           db "b e z d b p e a r i m v x g z",LF,CR
           db "n b d w b u q s u c e v x v q",LF,CR
           db "b f t y c r p f z i p t t m d",LF,CR
           db "n h u i n y m e g c m v f b v",LF,CR
           db "j k c u a v i o n l j v v c u",LF,CR
           db "g m j t o u w u z e x c y b t",LF,CR
           db "o x p r t q y h x t v b f v y",LF,CR
           db "t f o d w c b q v a o h e d m",LF,CR
           db "a d w a n x n b a c m v w q r",LF,CR,"$"
          
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    tren db "tren"
    yate db "yate"
    submarino db "submarino"    
    ferry db "ferry"
    canoa db "canoa"
    
    sopaT2 db "l a f s f e a c f t q c f t l",LF,CR
           db "r a f q u x u a a t q u t o l",LF,CR
           db "b r e v t i g n z x l n p n a",LF,CR
           db "v r r f s e f o f g m b w x m",LF,CR 
           db "l g r t d t f a i v v z v v a",LF,CR
           db "d r y e c c w s y n f v x d x",LF,CR
           db "o e z d b b e a r v m v x g z",LF,CR
           db "r b c a b a s u b m a r i n o",LF,CR
           db "b f t y c k p f z i w t o m d",LF,CR
           db "n h u i n o m e g r m v f b v",LF,CR
           db "j k c u x n v t h t r e n c u",LF,CR
           db "g m j t o u w u z f x c y b t",LF,CR
           db "o x p r t q y h x a v b f v y",LF,CR
           db "t y a t e c b q v n o h e d m",LF,CR
           db "a d w a n x n b a c m v w q r",LF,CR,"$"
           
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Sopa - Programacion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    java db "java"
    ruby db "ruby"
    python db "python"    
    swift db "swift"
    dart db "dart"
    
    sopaP1 db "c s g a s f e c f t q c f t q",LF,CR
           db "q a t q u x u r x a a c b o r",LF,CR
           db "e r w v b d r c d e s c z x o",LF,CR
           db "r r e m j a v a p a m b w x q",LF,CR 
           db "o g d t d r f d i v v z v v c",LF,CR
           db "e r c e c t w s y b f v x d x",LF,CR
           db "b e r u b y e a r r m v x g z",LF,CR
           db "n b d w b u q s u t e v x v q",LF,CR
           db "b f t y c r p f z i p t t m d",LF,CR
           db "n p u i n y m e g c m v f b v",LF,CR
           db "j y c u a v l f s w i f t c u",LF,CR
           db "g t j t o u w u z l x c y b t",LF,CR
           db "o h p r t q y h x t v b f v y",LF,CR
           db "t o o d w c b q v a o h e d m",LF,CR
           db "a n w a n x n b a c m v w q r",LF,CR,"$"
          
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;Java y Python se repiten
    php db "php"    
    javascript db "javascript"
    kotlin db "kotlin"
    
    sopaP2 db "l a f s f p y t h o n c f t l",LF,CR
           db "r a p q u x u a a t q u k o t",LF,CR
           db "b r h v t i g n z x l n o n a",LF,CR
           db "v r p f s e f o f g m b t x m",LF,CR 
           db "l g r t d t f a i v v z l v a",LF,CR
           db "d r y e c c w j y n f v i d x",LF,CR
           db "o e z d b b e a r v m v n g z",LF,CR
           db "r b c a b a s v b m a p i n o",LF,CR
           db "b f t y c k p a z i w t o m d",LF,CR
           db "n h u i n o m s g r m v f b v",LF,CR
           db "j k c u x n v c h t r e n c u",LF,CR
           db "g m j t o u w r z f x c y b t",LF,CR
           db "o x p r t q y i x j a v a v y",LF,CR
           db "t y p s e c b p v n o h e d m",LF,CR
           db "a d w a n x n t a c m v w q r",LF,CR,"$"
               
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;       
.code
.start up
                                                                
mostrarMatriz:
    mLimpia
    mImprimC sopaA1
    cmp aciertos,5
    jz salir

pedirPalabra:
    mImprimC ingreso
    mov ax,0000h
    mov bx,0000h 
    mov cx,0000h 
    mov dx,0000h 
    mov dx, offset cadena
    mov ah, 0ah
    int 21h
    
mov esExit,1
verificarP 3 mExit 0000h 0000h

mov esExit,0
verificarP 3 leon 0400h 0700h
    
verificarP 4 perro 0004h 000Ch
    
verificarP 5 delfin 0210h 021Ah
    
verificarP 6 tiburon 040Ah 0A0Ah
    
verificarP 3 gato 0811h 0819h
    
salir:
.exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Procedures ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
verificarIn     PROC
    mov bx,0
    mov al, cadena[1]
    sub al,1
    cmp al, cl
    jb termino
    ja termino
    
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
        cmp esExit,1
        jz esSalida:
        jnz continuar
        
    continuar:
       add aciertos,1
       call resaltarP
       jmp mostrarMatriz 
        
    esSalida:
        jmp salir
    

    mostrarm:
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
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
end