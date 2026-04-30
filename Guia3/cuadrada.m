% Reutilizamos el vector temporal (t) y la frecuencia (f) anterior
% Podemos generarla usando la función 'square' (si tienes el toolbox) 
% o simplemente usando el signo (sgn) de una senoidal pura:
fs = 1000;              % Frecuencia de muestreo (Hz)
t = 0:1/fs:1;           % Vector de tiempo de 0 a 1 segundo
f = 5;                  % Frecuencia de la señal (5 Hz)
A = 2;                  % Amplitud
x_cuadrada = sign(sin(2 * pi * f * t));

% (Opcional) Graficar
plot(t, x_cuadrada);
title('Onda Cuadrada');
xlabel('Tiempo (s)');
ylabel('Amplitud');
axis([0 1 -1.5 1.5]); % Ajuste de ejes para verla mejor
pause(15);