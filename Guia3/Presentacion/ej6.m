[x, fs] = audioread('escala.wav');
t_segmento = 0.5;
L = round(t_segmento * fs);

% Creamos la referencia para LA (440 Hz)
n = 0:L-1;
referencia_LA = sin(2 * pi * 440 * n / fs);

% Detectamos en cada uno de los 8 tramos
for i = 1:8
    inicio = (i-1)*L + 1;
    fin = i*L;
    segmento = x(inicio:fin);

    % Producto interno (grado de parecido)
    parecido(i) = abs(dot(segmento, referencia_LA));
end

% Encontramos el max
[valor, posicion] = max(parecido);
fprintf('La nota LA se encuentra en el segmento: %d\n', posicion);
fprintf('Tiempo de inicio: %.2f segundos\n', (posicion-1)*t_segmento);