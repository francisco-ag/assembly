.model tiny   ; Modo tiny (segmento único, ideal para .COM)
.code

org 100h    

start:
    ; Cambia a modo gráfico 320x200 con 256 colores (13h)
    mov ax, 13h   
    int 10h       

draw_line:
    mov al, 2     ; Color verde
    mov ah, 0Ch   
    int 10h       
    inc cx        ; Avanza en X
    cmp cx, 150   ; Límite de la línea (X = 150)
    jne draw_line ; Sigue dibujando  

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

end start  ; Marca el punto de entrada
