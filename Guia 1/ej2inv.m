#Realizar las siguientes ops basicas sobre una senal senoidal
#inversion
function [y, t] = ej2inv(fs, fm)
  paso = 1/fm;
  t = -1:paso:1;
  # genero la señal senoidal INVERTIDA en el tiempo (reversión)
  #solo le pongo un signo menos a la 't'
  y = sin(2 * pi * fs * (-t));
endfunction


