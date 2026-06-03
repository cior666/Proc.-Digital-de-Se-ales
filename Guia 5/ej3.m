%roots: Calcula las raíces de un polinomio.
%zplane dibuja: polos (X) y ceros (O) en el plano Z. 
pkg load signal;
%roots no trabaja con raices negativas entonces multiplicamos todo por z^3
%el numerado nos queda como: z^3-2z^2+2z-1
%el denominador como z^3-1.7z^2+0.8z-0.1

%numerador
b = [1 -2 2 -1];

%denominador: % (z-1)(z-0.5)(z-0.2)
a = conv([1 -1], [1 -0.5]);
a = conv(a, [1 -0.2]);
% Mostrar coeficientes
disp('Denominador:');
disp(a);


% calculo de ceros
ceros = roots(b);
disp("los ceros son: ");
disp(ceros);
% Calculo de polos
polos = roots(a);
disp("los polos son: ");
disp(polos);

% diagrama polos y ceros
figure;
zplane(b,a);
grid on;
title('Diagrama de polos y ceros');

% respuesta impulsiva
figure;
impz(b,a);
grid on;
title('Respuesta al impulso');