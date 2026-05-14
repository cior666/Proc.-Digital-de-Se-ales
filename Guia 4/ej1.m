#generar una señal s(t)=sin(2*pi*f1.*t)+4.*sin(2*pi*f2*t) con f1=10 f2=20
#obtener su version discreta s[n] con periodo de muestreo T=0.001s 
#en el intervalo de tiempo t=[0,.....1) a continuacion
%1) calcular la TDF s[k] de la senal s[n] y grafique el espectro de magnitud
#de S[k]
%Verificar la relacion de parseval para la TDF:

f1=10;
f2=20;

T=0.001; %periodo de muestreo
fs=1/T; #frec de muestreo
t=0:T:(1-T);
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
    x(k+1)=suma;
end

% Comprobamos la magnitud para graficar
magnitud_r=abs(xr);
