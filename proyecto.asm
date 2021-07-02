.model small
.data
    LF equ 10 ; salto de linea
    CR equ 13 ; Retorno de carro
    TB equ 09 ; tab
    var1 db ?
    msg1 db "-----------** Sopa de letras **----------- $",0
    msg2    db "Escriba la palabra que encuentre, o escriba exit para salir$",0
.code
.start up  

