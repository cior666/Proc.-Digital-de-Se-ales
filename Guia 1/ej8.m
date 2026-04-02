function ej8()
  #el primer paso es el de generar la senal para trabajar
  fm=1000;
  paso=1/fm;
  t=0:paso:1;
  fs=3;
  senal=sin(2*pi*fs*t);

  #para generar el ruido que pide la consigna usamos la func randn
  ruido=randn(1,length(t)); #genero ruido para todos los tiempos
  y=senal+ruido;

  #ahora calculo las potencias y el SNR
  #potenca senal
  ps=mean(senal.^2);
  #potencia ruido
  pr=mean(ruido.^2);

  #ahora el SNR, esta formula esta en el apunte y en mi drive desarrollada
  SNR=ps/pr;
  SNR_db=10*log10(SNR);

  #procedo a mostrar los valores obtenidos
  fprintf('Valores iniciales obtendos \n');
  fprintf('Potencia senal (PS): %f\n',ps);
  fprintf('Potencia ruido (PN): %f\n',pr);
  fprintf('SNR en db inicial: %f\n',SNR_db);

  #ahora viene la parte de multiplicar por una cte cualquiera
  #elijo 7 para hacerlo
  k=7;
  ruido_n=k*ruido;
  pn_nuevo=mean(ruido_n.^2);
  SNR_db_nuevo=10*log10(ps/pn_nuevo);

  #muestro resultados
  fprintf('Valores despues de multiplicar por cte \n');
  fprintf('Potencia senal (PS): %f\n',ps);
  fprintf('Potencia ruido (PN): %f\n',pn_nuevo);
  fprintf('SNR en db inicial: %f\n',SNR_db_nuevo);

  #ahora hacemos el despeje para el db=0;
  k_0db=sqrt(ps/pr); #buscamos el valor de k, esto esta explicado en el drive
  #obtenido el k, hacemos los calculos nuevos:
  ruido_kn=k_0db*ruido;#aca multiplicamos a los valores
  #del ruido por la cte que calculamos.
  y_0db=senal+ruido_kn; #nueva senal

  #hago la verificacion para ver que funcione
  pn_0db=mean(ruido_kn.^2);#eleveamos al cuadrado y hacemos prom
  #para verificar el resultado obtenido en la linea de k_0db
  SNR_final=10*log10(ps/pn_0db);

   fprintf('--- FORZANDO SNR A 0 dB ---\n');
   fprintf('Constante calculada (k): %f\n', k_0db);
   fprintf('Potencia del Ruido resultante: %f\n', pn_0db);
   fprintf('SNR Final verificada: %f dB\n', SNR_final);

   #graficar
   figure(1); clf;

    subplot(3,1,1);
    plot(t, senal, 'b', 'linewidth', 1.5);
    title('Señal Conocida Original');
    grid on;

    subplot(3,1,2);
    plot(t, y, 'k');
    title(sprintf('Señal + Ruido (SNR = %.2f dB)', SNR_db));
    grid on;

    subplot(3,1,3);
    plot(t, y_0db, 'r');
    title(sprintf('Señal + Ruido forzado a 0 dB (k = %.2f)', k_0db));
    xlabel('Tiempo (s)');
    grid on;
endfunction
