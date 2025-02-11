.model tiny  
.code

org 100h    

start:
    ; Cambia a modo gráfico 320x200 con 256 colores (13h)
    mov ax, 13h   
    int 10h       

    mov cx, 50    ; Posición inicial en X
    mov dx, 100   ; Posición en Y

animate:
    ; Dibuja píxel amarillo en la posición (CX,DX)
    mov al, 14    ; Color amarillo
    mov ah, 0Ch   ; Función de escribir píxel
    mov bh, 0     ; Página 0
    int 10h       

    ; Pequeña pausa (bucle de retardo)
    mov si, 5000  
delay:
    dec si
    jnz delay  

    ; Borra píxel anterior (pone color negro)
    mov al, 0     ; Color negro
    mov ah, 0Ch   ; Función de escribir píxel
    mov bh, 0     ; Página 0
    int 10h       

    ; Mueve el píxel a la derecha
    inc cx       

    ; Si llega al borde derecho (X=319), reinicia en 50
    cmp cx, 319  
    jne animate  
    mov cx, 50   ; Reinicia posición X
    
    jmp animate  ; Repite la animación

exit:
    ; Espera una tecla para salir
    mov ah, 00h
    int 16h

    ; Regresa a modo texto (03h)
    mov ax, 03h
    int 10h

    ; Salida limpia
    mov ax, 4C00h
    int 21h

end start  
