fs = 2;
fm = 10;
fase = 0;
tini=0;
tfin=1;
t = tini : 1/fm : (tfin - 1/fm); 
y_sen = sin(2 * pi * fs * t + fase);
y_cuad = sign(sin(2 * pi * fs * t + fase)); 
y_rampa = t - tini; 
y_aleatoria = randn(1, length(t));

seniales = [y_sen; y_cuad; y_rampa; y_aleatoria];  % cada fila = una señal
nombres  = {'senoidal', 'cuadrada', 'rampa', 'aleatoria'};

for i = 1:size(seniales, 1)       % iterar filas
    y = seniales(i, :);           % tomar la fila i como vector fila
    fprintf('--- %s ---\n', nombres{i});
    fprintf('  Media:    %.4f\n', mean(y));
    fprintf('  Maximo:   %.4f\n', max(y));
    fprintf('  Minimo:   %.4f\n', min(y));
    fprintf('  Amplitud: %.4f\n', max(abs(y)));
    fprintf('  Energia:  %.4f\n', sum(y.^2)); % norma 2 al cuadrado
    fprintf('  Accion:   %.4f\n', sum(abs(y))); % norma 1
    fprintf('  Potencia: %.4f\n', mean(y.^2));
    fprintf('  RMS:      %.4f\n', sqrt(mean(y.^2)));
end