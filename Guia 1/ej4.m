function [t,x]=ej4(fm)
  paso=1/fm;
  t=0:paso:1;
  fs=5;
  x=sin(2*pi*fs*t);
endfunction


