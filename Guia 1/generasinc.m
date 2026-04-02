function [t,y]=generasinc(fs,fm)
  #definimos el paso que viene definido del ej anterior
  paso=1/fm;
  #defino t que la consigna dice que esta entre -1 y 1
  t=-1:paso:1;
  #busco el valor de x que esta definido:
  x=2*pi*fs*t;
  y=sin(x)./x;
  y(x==0)=1;
endfunction
