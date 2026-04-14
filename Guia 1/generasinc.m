function [t,y]=generasinc(fs,fm)
  #definimos el paso que viene definido del ej anterior
  paso=1/fm;
  #defino t que la consigna dice que esta entre -1 y 1
  t=-1:paso:1;
  #busco el valor de x que esta definido:
  x=2*pi*fs*t;
  y=sin(x)./x;
  y(x==0)=1;
  % Gráfico
#figure(3); clf;
#plot(t, y, 'b', 'linewidth', 1.5);
#hold on;
#grid on;

# Estética del gráfico
#title('Gráfica de la Función Sinc (Seno Cardinal)');
#xlabel('Tiempo (s)');
#ylabel('Amplitud');
#yline(0, 'k'); % Eje horizontal para ver los cruces por cero
endfunction
