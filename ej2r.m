function [y,t]=ej2r(fs,fm)
  paso=1/fm;
  t=-1:paso:1;
  #para hacer la rectificacion es hacer el modulo de la funcion(en este caso)
  #para ello usamos el comando abs.
  y=abs(sin(2 * pi * fs * (t)));
endfunction

