
% DISEÑO DE FILTRO FIR NOTCH MEDIANTE MÉTODO DE VENTANAS
% frecuencia de muestreo de la señal
fs = 300;
% cantidad de coeficientes del filtro FIR (longitud de la respuesta impulsiva)
N = 51;
% Vector temporal centrado en cero. Tengo q centrarlo porque la respuesta ideal del filtro es simétrica.
n = -(N-1)/2 : (N-1)/2;
% DEFINICIÓN DE LA BANDA A ELIMINAR
% ruido de linea: queremos eliminar componentes entre 45 y 55 Hz
f1 = 45;
f2 = 55;
% conversion de frecuencia (Hz) a frecuencia digital (rad/muestra)
w1 = 2*pi*f1/fs;
w2 = 2*pi*f2/fs;

% RESPUESTA IMPULSIVA IDEAL DEL PASABANDA
% Primero construimos un filtro pasabanda ideal entre 45 y 55 Hz. Luego se lo restaremos al pasatodo para obtener un filtro notch (rechaza banda).
hbp = zeros(size(n));%creo vector de zeros p almacenar

for k = 1:length(n)
    % Caso especial n=0
    % porque aparece una división por cero
    if n(k)==0
        % Límite de la función sinc
        hbp(k) = (w2-w1)/pi;
    else
        % Respuesta impulsiva ideal de un pasabanda
        hbp(k) = ( sin(w2*n(k)) - sin(w1*n(k)) ) /( pi*n(k) );

    end
end

% CONVERSIÓN A FILTRO NOTCH
%filtro notch: es un filtro diseñado para eliminar una frecuencia muy específica mientras deja pasar prácticamente todas las demás.
% Un filtro notch ideal puede verse como: Hnotch = 1 - Hpasabanda, es decir: deja pasar todo excepto la banda de 50 Hz.
hd = -hbp;
% En el centro aparece la delta de Dirac correspondiente al pasatodo.
hd((N+1)/2) = 1 - hbp((N+1)/2);
figure;
stem(n,hd,'filled');
grid on;
xlabel('n');
ylabel('h_d[n]');
title('Respuesta impulsiva ideal del filtro notch');
% VENTANA DE HAMMING
% Como la respuesta ideal es infinita,debemos truncarla.
w_hamm= 0.54- 0.46*cos(2*pi*(0:N-1)/(N-1)); %genero la ventana con la formula de hamming

% Ventana rectangular Simplemente corta la respuesta impulsiva.
w_rect = ones(1,N);

% Ventana Blackman
% Mayor atenuación de lóbulos secundarios.
w_black = 0.42 - 0.5*cos(2*pi*(0:N-1)/(N-1))+ 0.08*cos(4*pi*(0:N-1)/(N-1));

% APLICACIÓN DE LAS VENTANAS
% Multiplicación muestra a muestra. Esto genera los FIR finales.
h_rect  = hd .* w_rect;%aplico la ventana, uso el .* porq tengo q aplicar a cada muestra
h_hamm  = hd .* w_hamm;%aplico la ventana, uso el .* porq tengo q aplicar a cada muestra
h_black = hd .* w_black;%aplico la ventana, uso el .* porq tengo q aplicar a cada muestra

% RESPUESTAS IMPULSIVAS OBTENIDAS
figure;
subplot(3,1,1);
stem(n,h_rect,'filled');
grid on;
title('Respuesta impulsiva - Rectangular');
subplot(3,1,2);
stem(n,h_hamm,'filled');
grid on;
title('Respuesta impulsiva - Hamming');
subplot(3,1,3);
stem(n,h_black,'filled');
grid on;
title('Respuesta impulsiva - Blackman');

% RESPUESTA EN FRECUENCIA
% freqz calcula H(e^jw)
[Hrect,f]  = freqz(h_rect ,1,2048,fs);
[Hhamm,~]  = freqz(h_hamm ,1,2048,fs);
[Hblack,~] = freqz(h_black,1,2048,fs);
% COMPARACIÓN DE VENTANAS
figure;
plot(f,20*log10(abs(Hrect)+eps),'LineWidth',1.5);
hold on;
plot(f,20*log10(abs(Hhamm)+eps),'LineWidth',1.5);
plot(f,20*log10(abs(Hblack)+eps),'LineWidth',1.5);
grid on;
xlabel('Frecuencia [Hz]');
ylabel('Magnitud [dB]');
title('Comparación de ventanas');
legend('Rectangular','Hamming','Blackman');


