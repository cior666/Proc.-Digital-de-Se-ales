function [t,x]=ej5()
  fs=4000;
  fm=129;
  paso=1/fm;
  t=0:paso:2;
  x=sin(2*pi*fs*t);
 endfunction

