% --- PARÁMETROS INICIALES ---
fs = 100;
t = 0:1/fs:0.99; % Genera exactamente 100 muestras [3, 4]
N = length(t);

fprintf('--- RESULTADOS EJERCICIO 2 ---\n');
fprintf('Frecuencia de muestreo: %d Hz | Muestras (N): %d\n\n', fs, N);

% --- ITEM 1: Ortogonalidad en el tiempo ---
% Generamos las señales base [4]
xa = sin(2*pi*2*t);            % Seno 2 Hz
xb = sign(sin(2*pi*2*t));      % Cuadrada 2 Hz
xc = sin(2*pi*4*t);            % Seno 4 Hz

% Cálculo de productos internos [5, 6]
prod1 = dot(xa, xb); 
prod2 = dot(xa, xc);
prod3 = dot(xb, xc);

fprintf('--- ITEM 1: Ortogonalidad en el Tiempo ---\n');
fprintf('Seno 2Hz vs Cuadrada 2Hz:  %10.4f (No es ortogonal)\n', prod1);
fprintf('Seno 2Hz vs Seno 4Hz:      %10.4f (SÍ es ortogonal)\n', prod2);
fprintf('Cuadrada 2Hz vs Seno 4Hz:  %10.4f (SÍ es ortogonal)\n\n', prod3);

% --- ITEM 2: Ortogonalidad en frecuencia ---
% Aplicamos la TDF [7]
Ta = fft(xa);
Tb = fft(xb);
Tc = fft(xc);

% Producto interno complejo: dot(A, B) = sum(A.*conj(B)) [8, 9]
% Esto verifica el Teorema de Parseval Generalizado: <X,Y> = N * <x,y> [10]
prod_f1 = dot(Ta, Tb);
prod_f2 = dot(Ta, Tc);
prod_f3 = dot(Tb, Tc);

fprintf('--- ITEM 2: Ortogonalidad en Frecuencia (DFT) ---\n');
fprintf('Ta vs Tb (Magnitud):  %10.2f (Proporcional a N * prod1)\n', abs(prod_f1));
fprintf('Ta vs Tc (Magnitud):  %10.2f (Sigue siendo ortogonal)\n', abs(prod_f2));
fprintf('Tb vs Tc (Magnitud):  %10.2f (Sigue siendo ortogonal)\n\n', abs(prod_f3));

% --- ITEM 3: Caso especial 3.5 Hz ---
xc2 = sin(2*pi*3.5*t); 
prod4 = dot(xa, xc2);
Tc2 = fft(xc2);
prod_f4 = dot(Ta, Tc2);

fprintf('--- ITEM 3: Caso Especial (Seno 3.5 Hz) ---\n');
fprintf('Tiempo (2Hz vs 3.5Hz):      %10.4f (Ortogonal en ventana de 1s)\n', prod4);
fprintf('Frecuencia (Ta vs Tc2):     %10.4f (Ortogonal en frecuencia)\n', abs(prod_f4));