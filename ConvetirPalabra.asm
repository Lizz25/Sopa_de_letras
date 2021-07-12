.model small
.data
 cadena db 64h dup (?)

.code
.startup

call convertirM

.exit 
convertirM proc 
    lea si,cadena            
    
    Inicio:                    
    mov ah,01h
    int 21h
    
    ;Compara si es ENTER, si es igual se va a FinPalabra
    cmp al, 0dh                 
    je FinPalabra               
     
    ;Se compara con el espacio,Si es igual salta a espacio  
    cmp al,20h                   
    je espacio                  
     
    ;Se hace la comparacion 'A' 
    cmp al, 41h                 
    jb guardar                  
    
    ;Se compara con 'Z'
    cmp al, 5ah                 
    ja guardar                   
     
    ;Si la letra esta en el rango de las mayusculas le suma 20h para que 
    ;se convierta en minuscula                           
    add al,20h
    
    ;Se incrementa SI y regresa hasta encuentre el ENTER 
    guardar:                  
    mov [si],al                 
    inc si                       
    jmp Inicio                  
    
    espacio:
    inc si
    jmp Inicio
    
    FinPalabra:                
    mov cx, 0000h                
    cmp si,cx
    je Inicio              
    inc si                      
    mov al,'$'  
    mov [si],al
     
    ;Para imprimir y ya 
    mov ah, 09h
    lea dx, cadena
    int 21h
    
    
endp                 

end

