function [y_cuant,t,x_orig]=ej2cuant(fs,fm,N)
  #creamos de la señal original
  paso = 1/fm;
  t = 0:paso:1;
  x_orig = sin(2*pi*fs*t);
  #hago la señal positiva
  minimo = min(x_orig);
  x_pos = x_orig - minimo;
  # busco valor alto de H
  #divido el maximo valor positivo por los niveles -1
  H = max(x_pos)/(N-1);
  #inicializo el vector de salida
  rho = zeros(size(x_pos));
  #cond de piso
  rho(x_pos < 0) = 0;
  #cond de techo
  rho(x_pos >= (N-1)*H) = (N-1)*H;
  # aplico cuantizacion al cuerpo de la senal
  # para ello aplico una mascara a los valores del rango
  mascara = (x_pos >= 0) & (x_pos < (N-1)*H);
  # uso round para buscar el nivel más cercano en lugar de floor
  rho(mascara) = H * round(x_pos(mascara) / H);
  #restauro valor original
  y_cuant = rho + minimo;
  #graficamos
  figure(1); clf;
  plot(t, x_orig, 'r--', 'LineWidth', 1); hold on; % Señal original punteada
  stairs(t, y_cuant, 'b', 'LineWidth', 1.5);      % Señal cuantizada (tipo escalón)

  title(['Cuantización de Seno (N=', num2str(N), ', fs=', num2str(fs), 'Hz)']);
  xlabel('Tiempo (s)');
  ylabel('Amplitud');
  legend('Original (Continua)', 'Cuantizada (Discreta)');
  grid on;
endfunction


