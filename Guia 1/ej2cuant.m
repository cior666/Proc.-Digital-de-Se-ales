function [y_cuant,t,x_orig]=ej2cuant(fs,fm,N)
  % 1. Creación de la señal original
  paso = 1/fm;
  t = 0:paso:1;
  x_orig = sin(2*pi*fs*t);
  % 2. Hacemos la señal positiva
  minimo = min(x_orig);
  x_pos = x_orig - minimo;
  % 3. Encontramos el alto del escalón (H)
  % Se divide el máximo valor positivo por los niveles - 1
  H = max(x_pos)/(N-1);
  % 4. Inicializamos el vector de salida
  rho = zeros(size(x_pos));
  % 5. Condición de Piso (Valores menores a 0)
  rho(x_pos < 0) = 0;
  % 6. Condición de Techo (Valores máximos)
  rho(x_pos >= (N-1)*H) = (N-1)*H;
  % 7. Aplicación de la cuantización en el cuerpo de la señal
  % Creamos la máscara para los valores dentro del rango útil
  mascara = (x_pos >= 0) & (x_pos < (N-1)*H);
  % Usamos round para buscar el nivel más cercano en lugar de floor
  rho(mascara) = H * round(x_pos(mascara) / H);
  % 8. Restauramos el nivel original de la señal
  y_cuant = rho + minimo;
endfunction


