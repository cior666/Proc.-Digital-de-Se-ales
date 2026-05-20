#generar una señal s(t)=sin(2*pi*f1.*t)+4.*sin(2*pi*f2*t) con f1=10 f2=20
#obtener su version discreta s[n] con periodo de muestreo T=0.001s 
#en el intervalo de tiempo t=[0,.....1) a continuacion
%1) calcular la TDF s[k] de la senal s[n] y grafique el espectro de magnitud
#de S[k]
%Verificar la relacion de parseval para la TDF:

f1=10;
f2=20;

fs=1000; #frec de muestreo
t=0:1/fs:2;
N=length(t);

%defino la senal
s=sin(2*pi*f1*t)+4*sin(2*pi*f2*t);

%calculo usando la funcion de octave
%s_k=fft(s);
%calculo el espectro de magnitud usando abs
%magnitud_s=abs(s_k);
% Creamos un vector de índice 'k' para el eje X (de 0 a N-1)
%k = 0:(N-1); 
%stem(k, magnitud_s, 'b', 'MarkerFaceColor', 'b');
%title('Espectro de Magnitud de S[k]');
%xlabel('Índice de frecuencia (k)');
%ylabel('Magnitud |S[k]|');
%grid on;
%pause(10);

%entiendo el objetivo del curso vamos a calcularla a pata.
xr=zeros(1,N); #es donde guardare mi resultado.
for k=0:(N-1)
    suma=0;
    %ahora debo recorrer cada n q representa cada instante de tiempo de 0 a N-1
    for n=0:(N-1)
    %ahora genero el elemento de la base de fourier exponencial compleja
    expo=exp(-1i*2*pi*k*n/N);
    %luego multiplicamos  al muestra de la senal por la exponencial y acumulo
    suma=suma+s(n+1)*expo; %debo sumar uno por los indices de octave.
    end 
    xr(k+1)=suma;
end

% Comprobamos la magnitud para graficar
magnitud_r=abs(xr);

% 1. Armamos el vector de frecuencias COMPLETO para el eje X
% fs es la frecuencia de muestreo (1000 Hz) y N es el nuevo total de muestras (2000)
frecuencias_x = (0:(N-1)) * (fs / N);

% 2. Graficamos usando 'plot' todo el vector de magnitudes sin recortar
figure(1);
% Nota: Dejé 'b-o', pero al ser 2000 puntos los círculos se verán muy juntos. 
% Si se ve empastado, puedes cambiarlo a 'b-'
plot(frecuencias_x, magnitud_r, 'b-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
title('Espectro de Magnitud Completo |S[k]|');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud |S[k]|');
grid on;
pause(10);

#ahora procedemos a la parte de verificar el teorema de parseval.
#para ello debemos encontrar la energia de cada muestra de la senal
#y luego sumar todos esos valores para encontrar la energia total
energia_t=sum(s.^2);

#calculo la energia en el dom de frec
energia_f=sum(magnitud_r.^2)/N;

fprintf('\n--- Teorema de Parseval ---\n');
fprintf('Energía en el Tiempo:       %.4f\n', energia_t);
fprintf('Energía en la Frecuencia:   %.4f\n', energia_f);


########################################################################
%PARTE 2 EJ 1
s2=sin(2*pi*f1*t)+4*sin(2*pi*f2*t)+4;
#analizar los cambios en el espectro de magnitud respecto de s[k]
s2_k=fft(s2);
magnitud_s2=abs(s2_k);
% 5. Preparación de los datos para graficar (Zoom de 0 a 100 Hz)
% Como N=1000 y fs=1000, la resolución es exactamente 1 Hz por índice.
frecuencias_x = 0:100; 
magnitud_cortada = magnitud_s2(1:101); % Extraemos los primeros 101 valores

% 6. Gráfica del espectro
%figure(1);
%stem(frecuencias_x, magnitud_cortada, 'b', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
%title('Espectro de Magnitud |S_2[k]| (con nivel continua)');
%xlabel('Frecuencia (Hz)');
%ylabel('Magnitud |S[k]|');
%grid on;
%pause(10);

#lo nuevo que observamos es un nuevo pico pegado al eje y, esto es propio del factor
#que se agrego sumando (+4), esto es el resultado de que la funcion fft, osea la transf
#de fourier a detectado la cte +4 y acumulado su energia a lo largo de mil muestras
#con resultado 4x1000 osea 4000.

