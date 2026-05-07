
fm = 1000;
t = (0:fm-1)/fm; 
frecuencias = 1:10;

coeficientes = 0.1:0.1:1;  % item a: sin fase
fases = [pi/7, pi*2/7, pi/4, 3*pi/9, pi/2, pi, pi/3, pi/3.5, pi/6, 2*pi/1.5];  % item b: con fase

% ITEM A ----------------
f1 = zeros(1, fm);
for i = 1:length(frecuencias)
    % Señal senoidal "a pata"
    y = sin(2 * pi * frecuencias(i) * t); 
    f1 = f1 + coeficientes(i) .* y;
end

% Calculamos el parecido con cada senoidal (sin fase)
parecidos1 = zeros(1, length(frecuencias));
for i = 1:length(frecuencias)
    y = sin(2 * pi * frecuencias(i) * t);
    % Producto interno normalizado
    parecidos1(i) = sum(f1 .* y) / (norm(f1) * norm(y)); 
end

figure(1)
bar(frecuencias, parecidos1, 'FaceColor', [0.2 0.6 0.8])
title('ITEM A: Grado de parecido (Sin desfase)');
xlabel('Frecuencia (Hz)')
ylabel('Grado de parecido')
grid on;

%si  los coeficientes fueran los mismos, el grafico de barras mostraria
%que el parecido de nuestra señal es el mismo con todas las frecuencias

%el parecido aumenta segun el peso de la frecuencia comparada dentro de la señal

%esto resulta de saber que las senoidales de distintas frecuencias (enteros)
%son ortogonales entre si, luego es facil ver que el resultado del producto interno
%entre la senoidal y nuestra señal tiene cos(tita) = 1,y el parecido solo depende del alfa (los alfa si se desarrolla)


% ITEM B ----------------
f2 = zeros(1, fm);
for i = 1:length(frecuencias)
    % Señal senoidal con desfase "a pata"
    y = sin(2 * pi * frecuencias(i) * t + fases(i));
    f2 = f2 + coeficientes(i) .* y;
end

% Calculamos el parecido con cada senoidal base (las originales SIN fase)
parecidos2 = zeros(1, length(frecuencias));
for i = 1:length(frecuencias)
    y = sin(2 * pi * frecuencias(i) * t); 
    parecidos2(i) = sum(f2 .* y) / (norm(f2) * norm(y));
end

figure(2)
bar(frecuencias, parecidos2, 'FaceColor', [0.8 0.4 0.2])
title('ITEM B: Grado de parecido (Señal desfasada vs Bases)');
xlabel('Frecuencia (Hz)')
ylabel('Grado de parecido')
grid on;

%Ahora el parecido de la sinusoidal con la señal ya no sirve como referencia para saber su peso dentro de la misma.
% Esto se debe a que el producto interno entre dos sinusoidales de igual frecuencia
% pero distinta fase varia como cos(phi), por lo que una componente con mucho peso
% pero desfasada cerca de pi/2 puede dar un parecido cercano a cero, y una desfasada
% cerca de pi puede dar un valor negativo

% ITEM C --------------------
% Onda cuadrada de 5.5 Hz "a pata" usando la función signo
cuadrada = sign(sin(2 * pi * 5.5 * t)); 

parecidos3 = zeros(1, length(frecuencias));
for i = 1:length(frecuencias)
    y = sin(2 * pi * frecuencias(i) * t);
    parecidos3(i) = sum(cuadrada .* y) / (norm(cuadrada) * norm(y));
end

figure(3)
bar(frecuencias, parecidos3, 'FaceColor', [0.8 0.2 0.2])
title('ITEM C: Grado de parecido (Onda Cuadrada 5.5 Hz)');
xlabel('Frecuencia (Hz)')
ylabel('Grado de parecido')
grid on;
pause(15);

% La onda cuadrada de 5.5 Hz no puede ser representada exactamente por ninguna
% de las senoidales de la grilla de 1 a 10 Hz, ya que sus armonicos naturales
% (5.5, 16.5, 27.5 Hz...) no coinciden con ninguna frecuencia de dicha grilla.
% Esto se refleja en el grafico de barras: no hay un pico claro en ninguna
% frecuencia particular, sino que el parecido aparece distribuido entre varias. 

%consecuencia directa de la ortogonalidad de las senoidales:
% si la frecuencia necesaria no esta en la base de comparacion, la energia
% de la señal se "derrama" sobre las frecuencias disponibles sin concentrarse
% en ninguna.Tambien se puede pensar como una base no completa, ya q si el conjunto
%de senoidales no incluye frecuencias de la señal a representar, siempre existirá un error de aprox.



%el producto interno es excelente para extraer información y calcular el parecido, siempre y cuando la señal a buscar 
%pertenezca a tu base de frecuencias enteras y esté perfectamente alineada en fase. Si la señal se desfasa (Item B) 
%o su frecuencia cae en el medio de tus bases (Item C), el método falla por las propiedades geométricas de la ortogonalidad.