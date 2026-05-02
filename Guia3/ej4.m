#Genere una senal como combinacion lineal del conjunto de senales
#senoidales con frecuencias de 1, 2, 3, 4, 5, 6, 7, 8, 9 y 10 Hz y luego:
#1. mida el grado de parecido con dichas senoidales representando el resultado en un grafico de barras,
#2. vuelva a medir el grado de parecido pero con una combinacion lineal en
#la que se varia la fase de las senoidales y
#3. realice el grafico de barras para el caso de una senal cuadrada de 5,5
#Hz

#procedo a definir y generar las senales.
fs=1000;
t=0:1/fs:1;
N=length(t);
x=zeros(10,N);
A=2;
fase=0;
for f=1:10
    x(f, :) = A * sin(2 * pi * f * t + fase);
end
#me pide armar una senal nueva como comb lineal de las q cree recien
y_nueva=zeros(1,N);
alfa = randi([0, 10], 1, 10);
for a=1:10
    y_nueva=y_nueva+alfa(a)*x(a, :);
end

#el grado de parecido lo habiamos hecho en ej 2 con el prod interno y 
#ahora vamos a hacer lo mismo, entonces
prod_interno=0;
norma_y = norm(y_nueva, 2);
valores_normalizados = zeros(1, 10);
for f = 1:10
    % Extraemos la señal actual para no ensuciar el código
    senal_actual = x(f, :);
    
    % Calculamos producto interno usando vectorización (sin bucle for interno)
    prod_interno = dot(senal_actual, y_nueva); 
    norma_x = norm(senal_actual, 2);
    
    % Producto interno normalizado
    if norma_y == 0
        prod_normalizado = 0;
    else
        prod_normalizado = prod_interno / (norma_x * norma_y);
    end
    valores_normalizados(f) = prod_normalizado;
    % Imprimimos mostrando a qué señal (frecuencia) corresponde
    printf('Señal %2d Hz | Crudo: %10.4f | Normalizado: %5.2f\n', f, prod_interno, prod_normalizado);
end
############################################################################################################
#Parte 2:
#vuelva a medir el grado de parecido pero con una combinacion lineal en
#la que se varia la fase de las senoidales y

printf('\n--- EVALUANDO GRADO DE PARECIDO CON DESFASE ---\n');
y_fase = zeros(1, N);
fases_modificadas = zeros(1, 10);

for f = 1:10
    % Inventamos una fase aleatoria para cada frecuencia (entre 0 y 2*pi radianes)
    fase_aleatoria = rand() * 2 * pi;
    fases_modificadas(f) = fase_aleatoria;
    
    % Armamos la nueva señal sumando la senoidal con su alfa original, pero DESFASADA
    y_fase = y_fase + alfa(f) * A * sin(2 * pi * f * t + fase_aleatoria);
end

valores_fase = zeros(1, 10);

for f = 1:10
    % Producto interno de la nueva señal contra las señales base ORIGINALES (fase 0)
    prod_interno = sum(x(f, :) .* y_fase);
    
    % Proyección Ortogonal (dividimos solo por la energía de la señal base)
    energia_x = norm(x(f, :), 2)^2;
    proyeccion = prod_interno / energia_x;
    
    valores_fase(f) = proyeccion;
    
    printf('Frec: %2d Hz | Alfa real: %2d | Proyección extraída: %6.2f\n', f, alfa(f), proyeccion);
end

% --- NUEVO GRÁFICO DE BARRAS ---
figure;
bar(1:10, valores_fase, 'FaceColor', [0.8 0.4 0.2]); % Color rojizo/naranja para diferenciarlo
title('Grado de parecido (Señal combinada DESFASADA vs Bases originales)');
xlabel('Frecuencia de la señal base original (Hz)');
ylabel('Valor extraído por el Producto Interno');
xticks(1:10);
grid on;





figure; % Abre ventana

% --- GRÁFICO SUPERIOR: LA RECETA (Dominio de la frecuencia) ---
subplot(2, 1, 1); 
bar(1:10, valores_normalizados, 'FaceColor', [0.2 0.6 0.8]);
title('1. La Receta (Espectro): Cuánto usamos de cada frecuencia');
xlabel('Frecuencia (Hz)');
ylabel('Coeficiente de amplitud');
xticks(1:10);
grid on;

% --- GRÁFICO INFERIOR: EL RESULTADO (Dominio del tiempo) ---
subplot(2, 1, 2);
plot(t, y_nueva, 'k-', 'LineWidth', 1.5);
title('2. El Resultado (Señal Temporal): La suma de todos los ingredientes');
xlabel('Tiempo (segundos)');
ylabel('Amplitud total');
grid on;

pause(15);