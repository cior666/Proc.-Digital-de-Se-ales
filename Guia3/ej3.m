#lo que tengo que hacer en este ej es hallar el error cuadratico total de aproximacion el ejemplo con func
#de Legendre dependiendo de las siguientes condiciones:
#1) con los coeficientes calculados en el ejemplo del sibook.
#para ello:
dt = 0.001;               # Nuestro "diferencial" de tiempo
t = -1:dt:1;              # Vector de tiempo desde -1 hasta 1
N = length(t);            # Dimensión de nuestro espacio (R^N)

#la funcion a aproximar entonces, como dice el apunte, es:
y_orig = ones(1, N);      # Llenamos todo con unos
y_orig(t < 0) = -1;       # Forzamos a -1 la mitad izquierda (t < 0)

#armamos las bases de Legendre: para aproximar la señal, necesitamos un "molde" o sistema de referencia. 
#La teoría indica que una base ortonormal es ideal porque sus señales son totalmente independientes (ortogonales entre sí, producto interno = 0) 
#y su "tamaño" o energía es 1. Las primeras cuatro funciones ortonormales de Legendre en [−1,1] son:
phi0 = sqrt(1/2) * ones(1, N);
phi1 = sqrt(3/2) * t;
phi2 = sqrt(5/2) * (1.5 * t.^2 - 0.5);
phi3 = sqrt(7/2) * (2.5 * t.^3 - 1.5 * t);

#¿Cómo fabricamos nuestra señal aproximada  y~​? 
#Multiplicando cada función de la base por su respectivo "coeficiente de proyección" α y sumándolas. 
#La teoría demuestra que estos α (calculados previamente en tu apunte haciendo αi​=⟨y,ϕi⟩) son los que 
#garantizan el menor error posible en la aproximación.
#Entonces del apunte sacamos que:
alpha0 = 0;
alpha1 = sqrt(3/2);
alpha2 = 0;
alpha3 = -sqrt(7/32);

#armamos la senal aproximada:
y_aprox = alpha0*phi0 + alpha1*phi1 + alpha2*phi2 + alpha3*phi3;

#una vez que tenemos la senal y la aproximacion, calculamos el error cuadratico total de aproximacion
#este se calcula como la suma de las diferencias al cuadrado entre cada muestra de la señal original y la aproximada,
#dividido por el número total de muestras (N):
error_senal=y_orig-y_aprox;
ECT_opt=(sum(error_senal.^2))/N;
printf('El error cuadrático total de aproximación es: %f\n', ECT_opt);

figure;
plot(t, y_orig, 'b', 'LineWidth', 2); hold on;
plot(t, y_aprox, 'r', 'LineWidth', 2);
title('Aproximación de y(t) con Base de Legendre');
legend('Señal Original', 'Aproximación (4 términos)');
grid on;
%pause(10);

#2) con pequenas variaciones en torno a estos coeficientes a, construyendo una grafica 3D con la variacion de los coef, x,y,z
#y el error cuadratico total en z.

#La teoría matemática de señales establece que calcular los coeficientes α mediante el producto interno (proyección ortogonal) 
#garantiza el mínimo Error Cuadrático Total (ECT)

#si graficamos en 3 dimensiones vamos a obtener una especie de cuenco donde su base seria el menor error optimo
#para ello vamos a usar la funcion meshgrid

#entonces definimos las variaciones que le vamos a dar a los valores optimos:
variacion = -0.5 : 0.05 : 0.5;
# Creamos las grillas 2D para variar alpha1 y alpha3
[Alfa1_grid, Alfa3_grid] = meshgrid(alpha1 + variacion, alpha3 + variacion);

# Matriz vacía para guardar el error en el eje Z
ECT_3D = zeros(size(Alfa1_grid));
for i = 1:size(Alfa1_grid, 1)
    for j = 1:size(Alfa1_grid, 2)
        # Construimos una "mala" aproximación usando los alphas alterados
        # (Mantenemos alpha0 y alpha2 en 0)
        y_mala = 0*phi0 + Alfa1_grid(i,j)*phi1 + 0*phi2 + Alfa3_grid(i,j)*phi3;
        
        # Calculamos el ECT para esta mala aproximación
        error_malo = y_orig - y_mala;
        ECT_3D(i,j) = sum(error_malo.^2) * dt;
    end
end

% Gráfica 3D usando la función 'mesh' o 'surf'
figure;
mesh(Alfa1_grid, Alfa3_grid, ECT_3D);
hold on;
% Marcamos el punto óptimo teórico (el fondo del cuenco) en color rojo
plot3(alpha1, alpha3, ECT_opt, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
title('Superficie del Error Cuadrático Total (ECT)');
xlabel('Variación de \alpha_1');
ylabel('Variación de \alpha_3');
zlabel('ECT');
grid on;
%pause(15);

#3. con mas coeficientes α, para comprobar como se reduce el error cuadratico total al aumentar los coeficientes.
#La teoría indica que si aumentamos el número de funciones aproximantes (más dimensiones en nuestra base), 
#el error se irá reduciendo progresivamente

#amos a agregar la 5ta función de Legendre (ϕ5). Como la señal original es impar (antisimétrica), 
#las funciones pares de Legendre (ϕ0,ϕ2,ϕ4) siempre tendrán coeficientes α=0. Por eso saltamos directamente a ϕ5.

phi4 = sqrt(9/2) * (1/8) * (35*t.^4 - 30*t.^2 + 3);
phi5 = sqrt(11/2) * (1/8) * (63*t.^5 - 70*t.^3 + 15*t);

# Calculamos los nuevos coeficientes proyectando la señal original (Producto Interno)
# Teóricamente alpha4 dará 0 por simetría, pero alpha5 tendrá un valor.
alpha4 = sum(y_orig .* phi4) * dt;  
alpha5 = sum(y_orig .* phi5) * dt;

% Construimos la nueva aproximación sumando los términos nuevos
y_aprox_mejorada = y_aprox + alpha4*phi4 + alpha5*phi5;

% Calculamos el nuevo ECT
error_mejorado = y_orig - y_aprox_mejorada;
ECT_mejorado = sum(error_mejorado.^2) * dt;

printf('\nComparación de Errores:\n');
printf('ECT con 4 coeficientes: %f\n', ECT_opt);
printf('ECT con 6 coeficientes: %f\n', ECT_mejorado);

% Graficamos para ver cómo la onda se ajusta mejor al salto cuadrado
figure;
plot(t, y_orig, 'b', 'LineWidth', 2); hold on;
plot(t, y_aprox, 'r--', 'LineWidth', 1.5);
plot(t, y_aprox_mejorada, 'g', 'LineWidth', 2);
title('Aproximación de y(t) al aumentar coeficientes');
legend('Original', 'Aprox (4 términos)', 'Aprox Mejorada (6 términos)');
grid on;
%pause(15);

variacion = -0.5 : 0.05 : 0.5;

% Creamos las grillas 2D variando alpha1 y el NUEVO alpha5
[Alfa1_grid_new, Alfa5_grid_new] = meshgrid(alpha1 + variacion, alpha5 + variacion);

% Matriz vacía para guardar el nuevo error en el eje Z
ECT_3D_nuevo = zeros(size(Alfa1_grid_new));

% Doble bucle para evaluar la grilla
for i = 1:size(Alfa1_grid_new, 1)
    for j = 1:size(Alfa1_grid_new, 2)
        % Construimos la aproximación: 
        % Dejamos fijos alpha0, alpha2, alpha3 y alpha4 en sus valores óptimos
        % Solo alteramos los valores de alpha1 y alpha5 usando la grilla
        y_mala_nueva = alpha0*phi0 + Alfa1_grid_new(i,j)*phi1 + alpha2*phi2 + ...
                       alpha3*phi3 + alpha4*phi4 + Alfa5_grid_new(i,j)*phi5;
        
        % Calculamos el ECT para esta variación
        error_nuevo = y_orig - y_mala_nueva;
        ECT_3D_nuevo(i,j) = sum(error_nuevo.^2) * dt;
    end
end

% Generamos la nueva gráfica 3D
figure;
mesh(Alfa1_grid_new, Alfa5_grid_new, ECT_3D_nuevo);
hold on;

% Marcamos el nuevo mínimo global (que ahora está más abajo que en el Inciso 2)
plot3(alpha1, alpha5, ECT_mejorado, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
title('Superficie ECT al aumentar coeficientes (Base de 6 términos)');
xlabel('Variación de \alpha_1');
ylabel('Variación de \alpha_5');
zlabel('Error Cuadrático Total (ECT)');
grid on;
pause(25);