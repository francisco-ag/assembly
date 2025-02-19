.model tiny
.code
org 100h    

start:
    mov ax, 13h   ; Cambia a modo gráfico 320x200 (256 colores)
    int 10h       

rain:
    mov ah, 01h   ; Verifica si se presionó una tecla
    int 16h       
    jnz exit      ; Si hay una tecla, salir

    mov si, 20    ; Cantidad de gotas activas

next_drop:
    ; Genera coordenada X aleatoria entre 0-319
    mov ah, 2Ch   
    int 21h       
    and dl, 01111111b   ; Asegura que X esté dentro de 0-127
    shl dl, 1           ; Multiplica X por 2 para alcanzar 0-319
    mov cx, dx  

    mov dx, 0     ; Comienza en la fila Y = 0

fall:
    ; Acceso directo a memoria de video (segmento 0xA000)
    mov ax, 0A000h
    mov es, ax
    mov di, cx
    add di, dx
    shl di, 6     ; Multiplica por 64
    shl di, 2     ; Multiplica por 4 (para ajustar a 320 pixeles de ancho)

    ; Dibuja la gota en color azul (color 9)
    mov al, 9
    stosb         

    ; Delay para hacer visible la gota
    mov ah, 86h
    mov cx, 0
    mov dx, 5000   ; Aumentamos la espera
    int 15h

    ; Borra la gota anterior (color negro)
    mov al, 0
    stosb         

    ; Mueve la gota hacia abajo
    inc dx        
    cmp dx, 199   ; Si llega al fondo, detener
    jbe fall      

    dec si
    jnz next_drop ; Si hay gotas restantes, hacer otra

    jmp rain      ; Repetir ciclo de lluvia

exit:
    mov ax, 03h   ; Regresa a modo texto
    int 10h       
    mov ax, 4C00h ; Salida limpia
    int 21h       

end start
