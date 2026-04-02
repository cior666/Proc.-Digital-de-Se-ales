function [t,x]=ej6()
  fm=10; #frecuencia original
  fs=0.5; #frec de senal orig
  Tm=1/fm; #periodo original
  t_orig=-1:T:1; #paso
  #como me pide sobremuestrear a 4 veces la frec de muestreo
  #me pide hacerlo usando interpolacion, es decir,
  #llevar a fm a 40.

   [t_orig,x_orig]=generasinc(fs,fm);



   #Ahora debo crear los parametros de interpolacion
   factor=4;
   fmi=fm*factor;
   ti=1/fmi;
   t_nuevo=-1:ti:1;

   N=length(x_orig); #aca veo mi cantidad de muestras originales
   M=length(t_nuevo); #aca las nuevas, las que tengo que tener

   #creo vector para guardar el resultado de la interpolacon
   xi_sinc=zeros(1,M);

   #procedemos a hacer la sumatoria
   for m=1:M
     suma_sinc=0;
     for n=1:N
          #como ya tenemos armado los dos vectores de tiempo solo los recorremos, restamos
          #y normalizamos
       u=(t_nuevo(m)-t_orig(n))/Tm; #es la div que hablo en Drive

       Isinc=sinc(u);
       suma_sinc= suma_sinc+x_orig(n)*Isinc;
     endfor
     xi_sinc(m)=suma_sinc;
   endfor
   figure(1); clf;

  subplot(2,1,1);
  stem(t_orig, x_orig, 'k', 'filled', 'linewidth', 2);
  title('Señal Original Submuestreada (10 Hz)');
  grid on;

  subplot(2,1,2);
  stem(t_nuevo, xi_sinc, 'r', 'filled');
  title('Señal Reconstruida: Interpolación Sinc Ideal (40 Hz)');
  grid on;
endfunction

