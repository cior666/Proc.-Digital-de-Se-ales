% Definimos dos señales de longitud N=4
x = [1, 2, 3, 4];
h = [1, -1, 0, 0];

% Llamamos a nuestra función
y_circ = conv_circ(x, h);

% Mostramos el resultado
disp('Resultado de la Convolución Circular:');
disp(y_circ);