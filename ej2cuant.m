function [y_cuant,t,x_orig]=ej2cuant(fs,fm,N)
  #primero creo la senal original q tomo la q venia usando entonces
  paso=1/fm;
  t=0:paso:1;
  x_orig=sin(2*pi*fs*t);
  #debo hacer a la senal positiva entonces le resto a la misma el
  #valor minimo, entonces lo tengo que encontrar:
  minimo=min(x_orig);
  x_pos=x_orig-minimo; #aca la hago toda positiva
  #ahora debemos encontrar el alto del escalon (H)
  #como lo tenemos que hacer encajar con el techo:
  H=max(x_pos)/(N-1);
  #Hacemos la vectorizacion o funcion por partes
  rho=zeros(size(x_pos)); #armamos el vector de 0 con tamanio xpos
  #vemos la primera condicion
  rho(x_pos<0)=0;
  #la tercera que seria el techo
  rho(x_pos>=(N-1)*H)=(N-1)*H;
  #ahora viene el escalon entonces lo que vamos a hacer
  #es crear una mascara que haga T o F dependiendo el retorno
  #de la condicion, esto es para evitar IFs y Fors anidados
  #entonces:
  mascara=(x_pos>=0)&(x_pos<(N-1)*H);
  #al obtener la mascara ya vamos a saber que valores cumplen con la cond
  #y vamos a aplicarle la formula a los que cumplen con ellos.
  #floor es equivalente a int
  rho(mascara)=H*floor(x_pos(mascara)/H);
  #Por ultimo le sumamos el minimo para dejarla en su lugar original
  y_cuant=rho+minimo;
endfunction



