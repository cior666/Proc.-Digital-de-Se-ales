% Generamos un número aleatorio por cada punto de nuestro vector de tiempo
fs = 1000;              % Frecuencia de muestreo (Hz)
t = 0:1/fs:1;           % Vector de tiempo de 0 a 1 segundo
f = 5;                  % Frecuencia de la señal (5 Hz)
A = 2;
N = length(t); % Cantidad de muestras

% Usando la función del apunte: rand(1, N) genera valores entre 0 y 1
x_aleatoria = rand(1, N); 

% (Si quisieras ruido blanco gaussiano centrado en 0, usarías randn(1, N))

% (Opcional) Graficar
plot(t, x_aleatoria);
title('Señal Aleatoria (Distribución Uniforme)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
pause(15);