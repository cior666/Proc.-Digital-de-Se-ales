function ej7()
  #para aproximar al valor exacto voy a usar valores grandes:
  M=10000; #los objetos (realizaciones)
  N=10000; #las mediciones (muestras)
  #en el drive puse bien las definicones de realizaciones y muestras.
  #La cuestion a entender es que cuando hago (1,1) es primera medicion del objeto 1
  #digamos medicion en t=1, luego si hago (1,2) es segunda medicion del objeto 1,
  #digamos medicion en t=2.

  #procedo a generar la senal
  #usando el randn genero una matriz gaussiana con media 0 y varianza 1 como pide la consigna
  matriz_aleatoria=randn(M,N);

  #ahora vamos a verificar la estacionariedad, para ello debo comprobar que sus propiedades
  #estadisticas no varien con el tiempo, entonces verifco por columna
  media_x_estac=mean(matriz_aleatoria,1);
  varianza_x_estac=var(matriz_aleatoria,0,1);
  #usamos el 0 como varianza muestral para que divida por n-1, lo usamos porque tenemos
  #una cantidad finita de muestras.

  #verificamos la ergocidad
  media_x_ergo=mean(matriz_aleatoria,2);
  varianza_x_estac=var(matriz_aleatoria,0,2);

  figure(1); clf;

  % Grafico 1: Estacionariedad (Media a lo largo del tiempo)
  subplot(2,2,1);
  plot(1:N, media_x_estac, 'b');
  title('Estacionariedad: Media vs Tiempo');
  xlabel('Muestras de tiempo (n)');
  ylabel('Media del Ensamble');
  axis([1 N -0.5 0.5]);
  grid on;

  % Grafico 2: Estacionariedad (Varianza a lo largo del tiempo)
  subplot(2,2,2);
  plot(1:N, varianza_x_estac, 'r');
  title('Estacionariedad: Varianza vs Tiempo');
  xlabel('Muestras de tiempo (n)');
  ylabel('Varianza del Ensamble');
  axis([1 N 0.5 1.5]);
  grid on;

  % Grafico 3: Ergodicidad (Media de cada realización independiente)
  subplot(2,2,3);
  plot(1:M, media_x_ergo, 'b');
  title('Ergodicidad: Media vs Realizaciones');
  xlabel('Número de Realización (m)');
  ylabel('Media Temporal');
  axis([1 M -0.5 0.5]);
  grid on;

  % Grafico 4: Ergodicidad (Varianza de cada realización independiente)
  subplot(2,2,4);
  plot(1:M,varianza_x_estac, 'r');
  title('Ergodicidad: Varianza vs Realizaciones');
  xlabel('Número de Realización (m)');
  ylabel('Varianza Temporal');
  axis([1 M 0.5 1.5]);
  grid on;

endfunction
