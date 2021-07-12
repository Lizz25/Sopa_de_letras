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
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Opciones - Menu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    var1 db ?
    menu1 db "-----------** Sopa de letras **-----------"  ,LF,CR,LF,TB
          db "Elija una tematica para su sopa de letra "   ,LF,CR,TB 
          db "1.- Animales "                               ,LF,CR,TB 
          db "2.- Vehiculos de transporte "                ,LF,CR,TB
          db "3.- Lenguajes de programacion "              ,LF,CR,,TB,LF
          db "Escriba el numero de la opcion que desea: $" ,LF,CR 
    
    op db 0
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Pantalla - Juego ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    mOp1 db "Sopa de letras: Animales $"
    mOp2 db "Sopa de letras: Vehiculos de transporte $",LF
    mOp3 db "Sopa de letras: Lenguajes de programacion $",LF   
    volver db 0 
    msjError db CR,LF,TB, "Ingrese una opcion correcta: $"
    
    juego db "Escoja una opcion de juego" ,LF,CR,TB
          db "Juego 1"                    ,LF,CR,TB
          db "Juego 2 "                   ,LF,CR,TB,LF 
          db "Escriba el numero: $"       ,LF,CR 
    
    op2 db 0
    
    ingreso db LF,"Ingrese la palabra encontrada: $"
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


    menuPrincipal: 
    mPosrc 1,20
    mImprimC menu1 
    
    ObtenerOp:         ;Recoge la opcion y valida que el numero ingresado sea correcto 
    call leer         
    sub al, 30h      
    mov op, al 
    mValidarNum op
     
    cmp op, 1
    je opcion1
    cmp op,2
    je opcion2
    jnz opcion3

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion1: Animales;;;;;;;;;;;;;;;;;;;;;;;;;;; 
    
    opcion1: 
    mLimpia 
    mPosrc 1,20
    mImprimC mOp1
    mPosrc 3,8
    mImprimC juego 
    ObtenerOpA:         ;Recoge la opcion y valida que el numero ingresado sea correcto 
    call leer         
    sub al, 30h      
    mov op2, al 
    mValidarNum op2 
    
    cmp op2,1
    je Animales1
    cmp op2,2
    je Animales2
    cmp op2,3
    je ObtenerOpA
    
    ;------------Sopa 1--------------;
    
    Animales1: 
    
    mostrarMatrizA1:
    mLimpia 
    mPosrc 1,20
    mImprimC mOp1
    mPosrc 3,8
    mImprimC sopaA1
    ;cmp aciertos,5
    ;jz salir

    ;pedirPalabra:
    ;mImprimC ingreso
    ;mov ax,0000h
    ;mov bx,0000h 
    ;mov cx,0000h 
    ;mov dx,0000h 
    ;mov dx, offset cadena
    ;mov ah, 0ah
    ;int 21h   
    
    ;call convertir
    
    ;mov esExit,1
    ;verificarP 3 mExit 0000h 0000h

    ;mov esExit,0
    ;verificarP 3 leon 0400h 0700h
    
    ;verificarP 4 perro 0004h 000Ch
    
    ;verificarP 5 delfin 0210h 021Ah
    
    ;verificarP 6 tiburon 040Ah 0A0Ah
    
    ;verificarP 3 gato 0811h 0819h
    
    ;------------Sopa 2--------------;
    
    Animales2:   
    mostrarMatrizA2:
    mLimpia 
    mPosrc 1,20
    mImprimC mOp1
    mPosrc 3,8
    mImprimC sopaA2
    ;cmp aciertos,5
    ;jz salir

    ;pedirPalabra:
    ;mImprimC ingreso
    ;mov ax,0000h
    ;mov bx,0000h 
    ;mov cx,0000h 
    ;mov dx,0000h 
    ;mov dx, offset cadena
    ;mov ah, 0ah
    ;int 21h   
    
    ;call convertir
    ;mov esExit,1
    ;verificarP 3 mExit 0000h 0000h

    ;mov esExit,0
    ;verificarP 6 caballo 0400h 0700h
    
    ;verificarP 4 llama 0004h 000Ch
    
    ;verificarP 7 avestruz 0210h 021Ah
    
    ;verificarP 3 buey 040Ah 0A0Ah
    
    ;verificarP 5 jirafa 0811h 0819h    
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2: Vehiculos de transporte;;;;;;;;;;;;;;;;;;;;;;;;;; 
    
    opcion2: 
    mLimpia 
    mPosrc 1,20
    mImprimC mOp2
    mPosrc 3,8
    mImprimC juego 
    ObtenerOpT:         ;Recoge la opcion y valida que el numero ingresado sea correcto 
    call leer         
    sub al, 30h      
    mov op2, al 
    mValidarNum op2 
    
    cmp op2,1
    je Vehiculos1
    cmp op2,2
    je Vehiculos2
    cmp op2,3
    je ObtenerOpT
    
    ;------------Sopa 1--------------;
    
    Vehiculos1: 
    
    mostrarMatrizT1:
    mLimpia 
    mPosrc 1,20
    mImprimC mOp2
    mPosrc 3,8
    mImprimC sopaT1
    ;cmp aciertos,5
    ;jz salir

    ;pedirPalabra:
    ;mImprimC ingreso
    ;mov ax,0000h
    ;mov bx,0000h 
    ;mov cx,0000h 
    ;mov dx,0000h 
    ;mov dx, offset cadena
    ;mov ah, 0ah
    ;int 21h   
    
    ;call convertir
    
    ;mov esExit,1
    ;verificarP 3 mExit 0000h 0000h

    ;mov esExit,0
    ;verificarP 4 barco 0400h 0700h
    
    ;verificarP 3 moto 0004h 000Ch
    
    ;verificarP 8 bicicleta 0210h 021Ah
    
    ;verificarP 4 avion 040Ah 0A0Ah
    
    ;verificarP 4 carro 0811h 0819h
    
    ;------------Sopa 2--------------;
    
    Vehiculos2:  
    mostrarMatrizT2:
    mLimpia 
    mPosrc 1,20
    mImprimC mOp2
    mPosrc 3,8
    mImprimC sopaT2
    ;cmp aciertos,5
    ;jz salir

    ;pedirPalabra:
    ;mImprimC ingreso
    ;mov ax,0000h
    ;mov bx,0000h 
    ;mov cx,0000h 
    ;mov dx,0000h 
    ;mov dx, offset cadena
    ;mov ah, 0ah
    ;int 21h   
    
    ;call convertir
    ;mov esExit,1
    ;verificarP 3 mExit 0000h 0000h

    ;mov esExit,0
    ;verificarP 3 tren 0400h 0700h
    
    ;verificarP 3 yate 0004h 000Ch
    
    ;verificarP 8 submarino 0210h 021Ah
    
    ;verificarP 4 ferry 040Ah 0A0Ah
    
    ;verificarP 4 canoa 0811h 0819h 
    
    ;;;;;;;;;;;;;;;;;;;;;;;;Opcion3: Lenguajes de programacion;;;;;;;;;;;;;;;;;;;;;;;;; 
    
    opcion3: 
    mLimpia 
    mPosrc 1,20
    mImprimC mOp3
    mPosrc 3,8
    mImprimC juego 
    
    ObtenerOpP:         ;Recoge la opcion y valida que el numero ingresado sea correcto 
    call leer         
    sub al, 30h      
    mov op2, al 
    mValidarNum op2 
    
    cmp op2,1
    je Program1
    cmp op2,2
    je Program2
    cmp op2,3
    je ObtenerOpP
    
    ;------------Sopa 1--------------;
    
    Program1: 
    
    mostrarMatrizP1:
    mLimpia 
    mPosrc 1,20
    mImprimC mOp3
    mPosrc 3,8
    mImprimC sopaP1
    ;cmp aciertos,5
    ;jz salir

    ;pedirPalabra:
    ;mImprimC ingreso
    ;mov ax,0000h
    ;mov bx,0000h 
    ;mov cx,0000h 
    ;mov dx,0000h 
    ;mov dx, offset cadena
    ;mov ah, 0ah
    ;int 21h   
    
    ;call convertir
    
    ;mov esExit,1
    ;verificarP 3 mExit 0000h 0000h

    ;mov esExit,0
    ;verificarP 3 java 0400h 0700h
    
    ;verificarP 3 ruby 0004h 000Ch
    
    ;verificarP 5 python 0210h 021Ah
    
    ;verificarP 4 swift 040Ah 0A0Ah
    
    ;verificarP 3 dart 0811h 0819h
    
    ;------------Sopa 2--------------;
    
    Program2:   
    mostrarMatrizP2:
    mLimpia 
    mPosrc 1,20
    mImprimC mOp3
    mPosrc 3,8
    mImprimC sopaP2
    ;cmp aciertos,5
    ;jz salir

    ;pedirPalabra:
    ;mImprimC ingreso
    ;mov ax,0000h
    ;mov bx,0000h 
    ;mov cx,0000h 
    ;mov dx,0000h 
    ;mov dx, offset cadena
    ;mov ah, 0ah
    ;int 21h   
    
    ;call convertir
    ;mov esExit,1
    ;verificarP 3 mExit 0000h 0000h

    ;mov esExit,0
    ;verificarP 3 java 0400h 0700h
    
    ;verificarP 5 python 0004h 000Ch
    
    ;verificarP 2 php 0210h 021Ah
    
    ;verificarP 9 javascript 040Ah 0A0Ah
    
    ;verificarP 5 kotlin 0811h 0819h
                                    
                                    
                                 
  
salir:
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

convertir PROC
    mov cx,0
    mov si,0
    mov cl,cadena[1]
    inicio:
        mov al, cadena[si+2]
        cmp si,cx
        je FinPalabra
        
        cmp al,20h
        je espacio
        
        cmp al,41h
        jb guardar
        
        cmp al,5ah
        ja guardar
        
        add al,20h
        
    guardar:
        mov cadena[si+2],al
        inc si
        jmp inicio
        
    espacio:
        inc si
        jmp inicio        
        
        
     FinPalabra:
        RET
    
    
convertir ENDP

 

end 