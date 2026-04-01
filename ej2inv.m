#Realizar las siguientes ops basicas sobre una senal senoidal
#inversion
function [y, t] = ej2inv(fs, fm)
  paso = 1/fm;
  t = -1:paso:1;
  % Generamos la señal senoidal INVERTIDA en el tiempo (reversión)
  % Simplemente le ponemos un signo menos a la 't'
  y = sin(2 * pi * fs * (-t));
endfunction


