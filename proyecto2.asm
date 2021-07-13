;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Macros ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Limpia la pantalla
mLimpia macro 
    mov ah, 0FH
    int 10h
    mov ah,0
    int 10h
endm 

;Espera una entrada para simular una pausa
mPausa macro
    mov ah,07h
    int 21h
endm

;Macro para mostrar por pantalla un string terminado en $
mImprimC macro t
    lea dx, t
    mov ah, 09h
    int 21h    
endm

;Macro para posicionar el puntero en la pantalla
mPosrc macro r,c
    mov bh,0     ;indica la pantalla
    mov dh,r     ;indica el renglon(0-24)
    mov dl,c     ;indca la columna (0-79)
    mov ah,2     ;indica el servicio de la interrupcion 
    int 10h
endm 

;Macro para validar el ingreso del menu principal
ValidarOp macro n1
    local err, sValidacion, vBien
    cmp n1,31h
    jz vBien
    cmp n1,32h
    jz vBien
    cmp n1,33h
    jz vBien
    cmp n1,34h
    jnz err
      
    vBien:
    mov opcionValida,1
    jmp sValidacion
     
    err:
    mov opcionValida,0
    lea dx, msjError
    mov ah, 09h
    int 21h
     
    sValidacion:
    
endm
     
;Macro para validar el ingreso del segundo menu para eligir el juego 1 o 2   
ValidarOp2 macro n1
    local err, sValidacion, vBien
    cmp n1,31h
    jz vBien
    cmp n1,32h
    jz vBien
    jnz err
    
    vBien:
    mov opcionValida,1
    jmp sValidacion
     
    err:
    mov opcionValida,0
    lea dx, msjError
    mov ah, 09h
    int 21h
     
    sValidacion:
    
endm
  
; LLena el contenido de un arreglo en otro arreglo
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
   
; Se compara una de las 5 palabras en la sopa de letra
; con la palabra ingresada
verificarP macro lon texto inicio final
    local empezarVerificar,terminar
    
    ;Si la palabra en la sopa de letra y la palabra ingresada
    ;no son del mismo tamano determina que son la misma palabra 
    mov al, cadena[1]
    sub al,1
    cmp al, lon
    jb terminar
    ja terminar
    
    ;Si son del mismo tamano procede a comparar
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
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Opciones - Menu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    var1 db ?
    menu1 db "-----------** Sopa de letras **-----------"  ,LF,CR,LF,TB
          db "Elija una tematica para su sopa de letra "   ,LF,CR,TB 
          db "1.- Animales "                               ,LF,CR,TB 
          db "2.- Vehiculos de transporte "                ,LF,CR,TB
          db "3.- Lenguajes de programacion "              ,LF,CR,TB
          db "4.- Salir "              ,LF,CR,TB,LF
          db "Escriba el numero de la opcion que desea: $" ,LF,CR 
    
    op db 0
    
    opcionValida db 1
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Pantalla - Juego ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    mOp1 db "Sopa de letras: Animales $"
    mOp2 db "Sopa de letras: Vehiculos de transporte $",LF
    mOp3 db "Sopa de letras: Lenguajes de programacion $",LF   
    volver db 0 
    msjError db CR,LF,TB, "Ingrese una opcion correcta: $"
    ganador db CR,LF,"FELICIDADES!! GANASTE...",CR,LF,"$"
    rendicion db CR,LF,"Para rendirse ingrese la palabra exit",CR,LF,"$"
    
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
        db TB,"r a t q u x u r a t q u t o r",LF,CR
        db TB, "b r w v t i g e d e l f i n o",LF,CR
        db TB, "v r e y e b r b p a m b w x q",LF,CR 
        db TB, "l g d t d t f d i v v z v v c",LF,CR
        db TB, "e r c e c i w s y n f v x d x",LF,CR
        db TB, "o e z d b b e a r v m v x g z",LF,CR
        db TB, "n b d w b u q s u j e v x v q",LF,CR
        db TB, "b f t y c r p f z g a t o m d",LF,CR
        db TB, "n h u i n o m e g r m v f b v",LF,CR
        db TB, "j k c u x n v t h w j v v c u",LF,CR
        db TB, "g m j t o u w u z d x c y b t",LF,CR
        db TB, "o x p r t q y h x b v b f v y",LF,CR
        db TB, "t f o d w c b q v n o h e d m",LF,CR
        db TB, "a d w a n x n b a c m v w q r",LF,CR,"$"
           
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    caballo db "caballo"
    llama db "llama"
    avestruz db "avestruz"    
    buey db "buey"
    jirafa db "jirafa"
    
    sopaA2 db  "l a f s f e a c f t q c f t l",LF,CR
        db TB, "r a t q u x u r a t q u t o l",LF,CR
        db TB, "b r w v t i g e z x l n p n a",LF,CR
        db TB, "v r a v e s t r u z m b w x m",LF,CR 
        db TB, "l g d t d t f d i v v z v v a",LF,CR
        db TB, "d r c e c c w s y n f v x d x",LF,CR
        db TB, "o e z d b b e a r v m v x g z",LF,CR
        db TB, "r b c a b a l l o j e v x v q",LF,CR
        db TB, "b f t y c k p f z i w t o m d",LF,CR
        db TB, "n h u i n o m e g r m v f b v",LF,CR
        db TB, "j k c u x n v t h a j v v c u",LF,CR
        db TB, "g m j t o u w u z f x c y b t",LF,CR
        db TB, "o x p r t q y h x a v b f v y",LF,CR
        db TB, "t b u e y c b q v n o h e d m",LF,CR
        db TB, "a d w a n x n b a c m v w q r",LF,CR,"$"
          
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Sopa - Transporte ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    barco db "barco"
    carro db "carro"
    moto db "moto"    
    bicicleta db "bicicleta"
    avion db "avion"
    
    sopaT1 db  "c s g a s f e c f t q c f t q",LF,CR
        db TB, "a a t q u x u r b a r c o o r",LF,CR
        db TB, "r r w v b a r c d e s c z x o",LF,CR
        db TB, "r r e m o t o b p a m b w x q",LF,CR 
        db TB, "o g d t d t f d i v v z v v c",LF,CR
        db TB, "e r c e c c w s y b f v x d x",LF,CR
        db TB, "b e z d b p e a r i m v x g z",LF,CR
        db TB, "n b d w b u q s u c e v x v q",LF,CR
        db TB, "b f t y c r p f z i p t t m d",LF,CR
        db TB, "n h u i n y m e g c m v f b v",LF,CR
        db TB, "j k c u a v i o n l j v v c u",LF,CR
        db TB, "g m j t o u w u z e x c y b t",LF,CR
        db TB, "o x p r t q y h x t v b f v y",LF,CR
        db TB, "t f o d w c b q v a o h e d m",LF,CR
        db TB, "a d w a n x n b a c m v w q r",LF,CR,"$"
         
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    tren db "tren"
    yate db "yate"
    submarino db "submarino"    
    ferry db "ferry"
    canoa db "canoa"
    
    sopaT2 db  "l a f s f e a c f t q c f t l",LF,CR
        db TB, "r a f q u x u a a t q u t o l",LF,CR
        db TB, "b r e v t i g n z x l n p n a",LF,CR
        db TB, "v r r f s e f o f g m b w x m",LF,CR 
        db TB, "l g r t d t f a i v v z v v a",LF,CR
        db TB, "d r y e c c w s y n f v x d x",LF,CR
        db TB, "o e z d b b e a r v m v x g z",LF,CR
        db TB, "r b c a b a s u b m a r i n o",LF,CR
        db TB, "b f t y c k p f z i w t o m d",LF,CR
        db TB, "n h u i n o m e g r m v f b v",LF,CR
        db TB, "j k c u x n v t h t r e n c u",LF,CR
        db TB, "g m j t o u w u z f x c y b t",LF,CR
        db TB, "o x p r t q y h x a v b f v y",LF,CR
        db TB, "t y a t e c b q v n o h e d m",LF,CR
        db TB, "a d w a n x n b a c m v w q r",LF,CR,"$"
          
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   Sopa - Programacion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    java db "java"
    ruby db "ruby"
    python db "python"    
    swift db "swift"
    dart db "dart"
    
    sopaP1 db  "c s g a s f e c f t q c f t q",LF,CR
        db TB, "q a t q u x u r x a a c b o r",LF,CR
        db TB, "e r w v b d r c d e s c z x o",LF,CR
        db TB, "r r e m j a v a p a m b w x q",LF,CR 
        db TB, "o g d t d r f d i v v z v v c",LF,CR
        db TB, "e r c e c t w s y b f v x d x",LF,CR
        db TB, "b e r u b y e a r r m v x g z",LF,CR
        db TB, "n b d w b u q s u t e v x v q",LF,CR
        db TB, "b f t y c r p f z i p t t m d",LF,CR
        db TB, "n p u i n y m e g c m v f b v",LF,CR
        db TB, "j y c u a v l f s w i f t c u",LF,CR
        db TB, "g t j t o u w u z l x c y b t",LF,CR
        db TB, "o h p r t q y h x t v b f v y",LF,CR
        db TB, "t o o d w c b q v a o h e d m",LF,CR
        db TB, "a n w a n x n b a c m v w q r",LF,CR,"$"
         
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Opcion2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;Java y Python se repiten
    php db "php"    
    javascript db "javascript"
    kotlin db "kotlin"
    
    sopaP2 db  "l a f s f p y t h o n c f t l",LF,CR
        db TB, "r a p q u x u a a t q u k o t",LF,CR
        db TB, "b r h v t i g n z x l n o n a",LF,CR
        db TB, "v r p f s e f o f g m b t x m",LF,CR 
        db TB, "l g r t d t f a i v v z l v a",LF,CR
        db TB, "d r y e c c w j y n f v i d x",LF,CR
        db TB, "o e z d b b e a r v m v n g z",LF,CR
        db TB, "r b c a b a s v b m a p i n o",LF,CR
        db TB, "b f t y c k p a z i w t o m d",LF,CR
        db TB, "n h u i n o m s g r m v f b v",LF,CR
        db TB, "j k c u x n v c h t r e n c u",LF,CR
        db TB, "g m j t o u w r z f x c y b t",LF,CR
        db TB, "o x p r t q y i x j a v a v y",LF,CR
        db TB, "t y p s e c b p v n o h e d m",LF,CR
        db TB, "a d w a n x n t a c m v w q r",LF,CR,"$"
               
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    
.code
.start up    


    menuPrincipal:
        mov aciertos,0 
        mPosrc 1,20
        mImprimC menu1 
    
    ObtenerOp:         ;Recoge la opcion y valida que el numero ingresado sea correcto 
        call leer               
        mov op, al 
        ValidarOp op
        cmp opcionValida,0
        jz ObtenerOp
     
        cmp op,31h
        je opcion1
        cmp op,32h
        je opcion2
        cmp op,33h
        je opcion3
        jnz salir
    
    opcion1: 
        mLimpia 
        mPosrc 1,20
        mImprimC mOp1
        jmp ObtenerOpJ 
     
    opcion2:  
        mLimpia 
        mPosrc 1,20
        mImprimC mOp2 
        jmp ObtenerOpJ
        
    opcion3:  
        mLimpia 
        mPosrc 1,20
        mImprimC mOp2 
        jmp ObtenerOpj       
     
        
    ObtenerOpJ:
        mPosrc 3,8
        mImprimC juego
    
    ObtenerOpA:         ;Recoge la opcion y valida que el numero ingresado sea correcto 
        call leer               
        mov op2, al 
        ValidarOp2 op2
        cmp opcionValida,0
        jz ObtenerOpA
    
    mostrarMatriz: ;Inicia Juego
        mLimpia
        mPosrc 1,20
        
    VerCategoria:  ;Verifica que categoria escogio el usuario
        cmp op, 31h
        je Animales
        cmp op,32h
        je Transportes
        jnz LProgramacion
     
    Animales:      ;Si escogio Animales, verifica si escogio juego 1 o 2
        mImprimC mOp1  
        mPosrc 3,8
        cmp op2, 31h
        jz Animales1
        jnz Animales2
    
    Transportes:   ;Si escogio Transportes, verifica si escogio juego 1 o 2
        mImprimC mOp2  
        mPosrc 3,8
        cmp op2, 31h
        jz Transportes1
        jnz Transportes2
    
    LProgramacion: ;Si escogio Lenguajes de programacion, verifica si escogio juego 1 o 2
        mImprimC mOp3  
        mPosrc 3,8
        cmp op2, 31h
        jz LProgramacion1
        jnz LProgramacion2
    
        
    Animales1:  ;Juego 1 de Animales   
        mImprimC sopaA1
        cmp aciertos,5
        jz gano1
        jnz pedirPalabra1
        
        gano1:
            mImprimC ganador
            mPausa
            call colorearNegro
            mLimpia
            jmp salir
            

        pedirPalabra1:
            mImprimC rendicion
            call leerString       
    
        call convertir
        mov esExit,1
        verificarP 3 mExit 0000h 0000h

        mov esExit,0
        verificarP 3 leon 0708h 0A08h
        verificarP 4 perro 030Ch 0314h
        verificarP 5 delfin 0518h 0522h
        verificarP 6 tiburon 0712h 0D12h   
        verificarP 3 gato 0B1Ah 0B20h
        
        jmp mostrarMatriz 
        
    Animales2:  ;Juego 2 de Animales
        mImprimC sopaA2
        cmp aciertos,5
        jz gano2
        jnz pedirPalabra2
        
        gano2:
            mImprimC ganador
            mPausa
            call colorearNegro
            mLimpia
            jmp salir

        pedirPalabra2:
        mImprimC rendicion
        call leerString       
    
        call convertir
        mov esExit,1
        verificarP 3 mExit 0000h 0000h

        mov esExit,0
        verificarP 4 llama 0324h 0724h
        verificarP 3 buey 100Ah 1010h
        verificarP 6 caballo 0A0Ch 0A18h
        verificarP 5 jirafa 0A1Ah 0F1Ah   
        verificarP 7 avestruz 060Ch 061Ah
        
        jmp mostrarMatriz 
        
    Transportes1:  ;Juego 1 de Transportes
        mImprimC sopaT1
        cmp aciertos,5
        jz gano3
        jnz pedirPalabra3
        
        gano3:
            mImprimC ganador
            mPausa
            call colorearNegro
            mLimpia
            jmp salir

        pedirPalabra3:
        mImprimC rendicion
        call leerString       
    
        call convertir
        mov esExit,1
        verificarP 3 mExit 0000h 0000h

        mov esExit,0
        verificarP 4 barco 0418h 0420h
        verificarP 4 carro 0308h 0708h
        verificarP 3 moto 060Eh 0614h
        verificarP 8 bicicleta 081Ah 101Ah   
        verificarP 4 avion 0D10h 0D18h
        
        jmp mostrarMatriz 
        
    Transportes2:  ;Juego 2 de Transportes
        mImprimC sopaT2
        cmp aciertos,5
        jz gano4
        jnz pedirPalabra4
        
        gano4:
            mImprimC ganador
            mPausa
            call colorearNegro
            mLimpia
            jmp salir

        pedirPalabra4:
        mImprimC rendicion
        call leerString       
    
        call convertir
        mov esExit,1
        verificarP 3 mExit 0000h 0000h

        mov esExit,0
        verificarP 3 tren 0D1Ah 0D20h
        verificarP 3 yate 100Ah 1010h
        verificarP 8 submarino 0A14h 0A24h
        verificarP 4 ferry 040Ch 080Ch   
        verificarP 4 canoa 0316h 0716h 
        
        jmp mostrarMatriz 
    
    LProgramacion1: ;Juego 1 de Lenguajes de Programacion
        mImprimC sopaP1
        cmp aciertos,5
        jz gano5
        jnz pedirPalabra5
        
        gano5:
            mImprimC ganador
            mPausa    
            call colorearNegro
            mLimpia
            jmp salir

        pedirPalabra5:
        mImprimC rendicion
        call leerString       
    
        call convertir
        mov esExit,1
        verificarP 3 mExit 0000h 0000h

        mov esExit,0
        verificarP 3 java 0610h 0616h
        verificarP 3 ruby 090ch 0912h
        verificarP 5 python 0C0Ah 110Ah
        verificarP 4 swift 0D18h 0D20h   
        verificarP 3 dart 0512h 0812h
        
        jmp mostrarMatriz 
    
    LProgramacion2: ;Juego 2 de Lenguajes de Programacion
        mImprimC sopaP2
        cmp aciertos,5
        jz gano6
        jnz pedirPalabra6
        
        gano6:
            mImprimC ganador
            mPausa
            call colorearNegro
            mLimpia
            jmp salir

        pedirPalabra6:
        mImprimC rendicion
        call leerString       
    
        call convertir
        mov esExit,1
        verificarP 3 mExit 0000h 0000h

        mov esExit,0
        verificarP 2 php 040Ch 060Ch
        verificarP 9 javascript 0816h 1116h
        verificarP 3 java 0F1Ah 0F20h
        verificarP 5 python 0312h 031Ch   
        verificarP 5 kotlin 0420h 0920h
        
        jmp mostrarMatriz 
    

  
salir:
    .exit
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Procedures ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

;Lee un caracter
leer proc near 
    mov ah, 01h
    int 21h
    ret 
leer endp
    
;Limpia la pantalla    
pLimpia proc near 
    mov ah, 0FH
    int 10h
    mov ah,0
    int 10h    
    ret
pLimpia endp


;Lee un string y lo almacena en un arreglo
;En el indice 0 se almacena el tamano del arreglo
;En el indice 1 se almacena el tamano del string ingresado
;A partir del indice 3 empiza almacenar el String, en el final del string se incluye el enter
leerString PROC
    mImprimC ingreso
    mov ax,0000h
    mov bx,0000h 
    mov cx,0000h 
    mov dx,0000h 
    mov dx, offset cadena
    mov ah, 0ah
    int 21h
    RET   
leerString ENDP   

;Comprueba caracter a caracter si dos strings de igual tamano
;son iguales
verificarIn     PROC
    mov bx,0
    mov al, cadena[1]
    sub al,1
    cmp al, cl
    jb termino
    ja termino
    
    ;Compara los caracteres, si no son iguales termina el proceso de comparacion
    ;Si son iguales, comprueba si la palabra en la sopa de letra ya se recorrio
    ;por completo
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
    ;Colorea la palabra ingresada, ya que se encuentra en la sopa de letra
    ;y permite seguir con el juego    
    continuar:
       add aciertos,1
       call resaltarP
       jmp mostrarMatriz 
    
    ;Si la palabra ingresada es exit, vuelve al menu principal    
    esSalida:
        call colorearNegro
        mLimpia
        jmp salir
    

    mostrarm:
        jmp termino
        
    termino: 
        RET
verificarIn     ENDP
 
;Pinta las letras de color amarillo 
resaltarP PROC
    MOV Ax,0600h  ;modo video (creo)
    MOV BH,00001110b ;color que se modifico 0 ->parpadeo 000 -> color fondo 0000 ->Color fuente
    MOV CX,coordenadaI   ; pixeles de donde empieza a colorear   ch ->fila    cl->columna
    MOV DX,coordenadaF   ; pixeles de donde termina de colorear  dh ->fila    dl->columna
    INT 10H   
    RET
resaltarP ENDP 
  
;Pinta las palabras de color blanco  
colorearNegro PROC
    MOV Ax,0600h
    MOV BH,00001111b
    MOV CX,0000h  
    MOV DX,484Fh 
    INT 10H   
    RET              
                  
colorearNegro ENDP

;Tranforma las palabras mayusculas a minusculas
convertir PROC
    mov cx,0
    mov si,0
    mov cl,cadena[1]
    inicio:
        mov al, cadena[si+2]
        cmp si,cx
        je FinPalabra
        
        ;Se compara con el espacio,Si es igual salta a espacio
        cmp al,20h
        je espacio     
        
        ;Se hace la comparacion 'A' 
        cmp al,41h
        jb guardar
        
        ;Se compara con 'Z'
        cmp al,5ah
        ja guardar
        
        ;Si la letra esta en el rango de las mayusculas le suma 20h para que 
        ;se convierta en minuscula
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

end