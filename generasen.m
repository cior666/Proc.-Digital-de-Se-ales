function [x, y] = generasen(fs, fm, phi, duracion)
    % Se define el paso temporal de acuerdo a la frecuencia de muestreo
    paso = 1 / fm;

    % Creación del vector de tiempo de forma vectorizada (sin for)
    y = 0:paso:duracion;

    % Cálculo de la señal aplicando la función trigonométrica a todo el vector
    x = sin(2 * pi * fs * y + phi);
endfunction

