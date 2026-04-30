% Vector de muestras discreto
n = 0:50; % De 0 a 50 muestras

% La señal rampa es igual al valor de la muestra
x_rampa = n;

% (Opcional) Graficar
stem(n, x_rampa); % Usamos stem para señales discretas
title('Señal Rampa');
xlabel('Muestra (n)');
ylabel('Amplitud');
pause(15);