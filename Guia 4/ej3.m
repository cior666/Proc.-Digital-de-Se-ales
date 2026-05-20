% --- PARÁMETROS INICIALES ---
fs = 100;           #frec muestreo
t = 0:1/fs:0.99;    
N = length(t);
f = 10;             #frec senal
n0 = 10;            #retardo
#genero la senoidal
x = sin(2 * pi * f * t);
#calculo la trans de fourier
X_k = fft(x);
#aplico el retardo
#defino vector de indices k
k = 0:(N-1);
#multiplico por factor de fase
fase_retardo = exp(-1i * (2 * pi / N) * k * n0);
X_k_retardada = X_k .* fase_retardo;
#hago la anti transformada para llevarlo de nuevo a terminos de tiempo
x_retardada_calculada = ifft(X_k_retardada);
#como es una senal real, tomamos solo esa parte de la senal para graficarla.
x_retardada_calculada = real(x_retardada_calculada);

% 5. Verificación visual
figure(1);
subplot(2,1,1);
stem(t, x, 'b', 'LineWidth', 1.2);
title('Señal Original x[n]');
grid on;

subplot(2,1,2);
stem(t, x_retardada_calculada, 'r', 'LineWidth', 1.2);
title(['Señal con Retardo de ', num2str(n0), ' muestras (vía TDF)']);
grid on;
pause(10);

% Comprobación de valores
fprintf('Valor original en t=0 (n=1): %.4f\n', x(1));
fprintf('Valor retardado en n=11:    %.4f\n', x_retardada_calculada(11));