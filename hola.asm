.model tiny   ; Modo tiny (segmento único, ideal para .COM)
.code
org 100h      ; .COM siempre inicia en la dirección 100h

start:
    mov dx, msg      ; Dirección del mensaje
    mov ah, 09h      ; Función de DOS para imprimir
    int 21h          ; Llamada a DOS

    mov ah, 4Ch      ; Función de salida DOS
    int 21h          ; Terminar programa

msg db 'Hola, Mundo!$'  ; Mensaje con terminador '$' (necesario para DOS)

end start  ; Marca el punto de entrada
