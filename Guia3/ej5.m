#tenemos que encontrar el numero de telefono que se disco. Se digitalizo con una fm de 11025hz
#se sabe que cada numero del telefono esta codificado mediante la suma de dos senales senoidales cuya
#frecuencia indica la posicion en el teclado. De arriba hacia abajo las frecuencias son 697,770,852 y 941
#de izquierda a derecha son 1209,1336,1477. Por ej: para el nro 2 se codifica con la suma de dos senos de 
#frecuencias 697 y 1336. El numero 7 se codifica con 852 y 1209. Se necesita determinar el numero que se ha discado.

#para cargar senales se usa el comando try
try
    x=load('te.txt');
catch
    error('no se pudo cargar correctamente');
end

fm=11025;
N=length(x);
t=(0:N-1)'/fm; #vector tiempo transpuesto a columna

filas=[697.770,852,941];
col=[1209,1336,1477];

teclado=[
    '1', '2','3';
    '4','5','6';
    '7','8','9';
    '*','0','#'];

#busco la frec de la fila
energia_filas=zeros(1,length(filas));

for i=1:length(filas)
    f=filas(i)
    #generamos base ortogonal para la frecuencia f
    seno_ref=sin(2*pi*f*t);
    cos_ref=cos(2*pi*f*t);

    #calculo de prod interno
    pi_seno=sum(x.*seno_ref);
    pi_cos=sum(x.*cos_ref);

    #magn total para independizarnos de la fase:
    energia_filas(i)=sqrt(pi_seno^2+pi_cos^2);
end

#busqueda de la frec de la columa
energia_cols=zeros(1,length(col));
for i=1:length(col)
    f=col(i);
    #generamos base ortogonal para la frecuencia f
    seno_ref=sin(2*pi*f*t);
    cos_ref=cos(2*pi*f*t);

    #Producto interno
    pi_seno = sum(x .* seno_ref);
    pi_cos = sum(x .* cos_ref);

    % Magnitud total
    energia_cols(i) = sqrt(pi_seno^2 + pi_cos^2);
end

#ahora buscamos los maximos:
[max_val_fila, idx_fila]=max(energia_filas);
[max_val_col, idx_col]=max(energia_cols);

frec_fila_detectada=filas(idx_fila);
frec_col_detectada=col(idx_col);

#entonces sabiendo los indices ya podemos mostrar el codigo discado
numero_detectado=teclado(idx_fila,idx_col);
fprintf('\n--- Resultados de Detección ---\n');
fprintf('Frecuencia de fila detectada: %d Hz\n', frec_fila_detectada);
fprintf('Frecuencia de columna detectada: %d Hz\n', frec_col_detectada);
fprintf('===============================\n');
fprintf('El número discado es: -> %c <-\n', numero_detectado);
fprintf('===============================\n');
