#una onda cuadrada que puede definirse como en el la consigna:
function [y, t] = ej3(fs, fm, phi, tinicial, tfinal)
    paso = 1 / fm;
    t = tinicial : paso : tfinal;
    x = mod(2 * pi * fs * t + phi, 2 * pi);
    #no debo definir fi como paso a paso porque la consigna dice que puede ser
  #cualquier valor entre -pi y pi, entonces lo paso como parametro de la funcion.
    y = zeros(size(t));
    y(x < pi) = 1;
    y(x >= pi) = -1;
endfunction
#Para plontear primero tiro el [t,y]=ej3(5,100,pi/4)
#y dsp plot(t,y,'b-o')

