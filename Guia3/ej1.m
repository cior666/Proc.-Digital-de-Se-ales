#obtener los siguientes valores de una señal senoidal, una rampa y una onda cuadrada y una señal aleatoria.
#valor medio,maximo, minimo, amplitud, energia, accion
#potencia media y raiz del valor cuadratico medio rmse
fs = 1000;              # Frecuencia de muestreo (Hz)
t = 0:1/fs:1;           # Vector de tiempo de 0 a 1 segundo
f = 5;                  # Frecuencia de la señal (5 Hz)
A = 2;  
N = length(t); % Cantidad de muestras
n = 0:50; # De 0 a 50 muestras

x_rampa = n;
x_cuadrada = sign(sin(2 * pi * f * t));
x_senoidal = A * sin(2 * pi * f * t);
x_aleatoria = rand(1, N); 

#entonces valor medio
medio_sen=mean(x_senoidal);
medio_rampa=mean(x_rampa);
medio_cuadrada=mean(x_cuadrada);
medio_aleatoria=mean(x_aleatoria);


#ahora procedo a hallar maximos y minimos
max_sen=max(x_senoidal);
min_sen=min(x_senoidal);

max_rampa=max(x_rampa);
min_rampa=min(x_rampa);

max_cuadrada=max(x_cuadrada);
min_cuadrada=min(x_cuadrada);

max_aleatoria=max(x_aleatoria);
min_aleatoria=min(x_aleatoria);

#la amplitud puede hallarse como la resta del max-min dividido 2
#entonces
amplitud_sen=(max_sen-min_sen)/2;
amplitud_rampa=(max_rampa-min_rampa)/2;
amplitud_cuadrada=(max_cuadrada-min_cuadrada)/2;
amplitud_aleatoria=(max_aleatoria-min_aleatoria)/2;

#ahora calculamos el rms segun el apunte de la catedra
#el rms se puede calcular como la raiz cuadrada de la potencia
#de la senal. 
#la potencia de la senal puede calcularse como la media 
#de la misma al cuadrado. sabiendo esto,procedemos a hallar la pot
#potencia media de una señal discreta como la sumatoria de las muestras 
#al cuadrado dividida por la cantidad total de muestras
pot_sen=mean(x_senoidal.^2);
pot_rampa=mean(x_rampa.^2);
pot_cuadrada=mean(x_cuadrada.^2);
pot_aleatoria=mean(x_aleatoria.^2);

#teniendo la pot buscamos el RMS
rms_sen=sqrt(pot_sen);
rms_rampa=sqrt(pot_rampa);
rms_cuadrada=sqrt(pot_cuadrada);
rms_aleatoria=sqrt(pot_aleatoria);

#me falta calcular energia y accion
#podemos definir a la energia como la norma p=2, aunque
#esta no es directamente la energia, sino que hay q calcularle
#la raiz cuadrada. En senales discretas equivale a realizar la
#sumatoria de cada una de las muestras elevadas al cuadrado

#La accion equivale a la norma p=1, matematicamente representa
#la sumatoria simple de los valores absolutos de todas las muestras
#de la senal que quiero analizar

#sabiendo esto: calculo la accion
accion_sen=sum(abs(x_senoidal));
accion_rampa=sum(abs(x_rampa));
accion_cuadrada=sum(abs(x_cuadrada));
accion_aleatoria=sum(abs(x_aleatoria));

#la energia entonces puede calcularse de dos maneras
#con suma normal:
energia_sen=sum(x_senoidal.^2);
#o con norma
energy_sen=norm(x_senoidal,2)^2;

#sigo calculando con norma para practicar la logica
energia_rampa=norm(x_rampa,2)^2;
energia_cuadrada=norm(x_cuadrada,2)^2;
energia_aleatoria=norm(x_aleatoria,2)^2;

# --- IMPRESIÓN DE RESULTADOS ---

# Resultados para la señal senoidal
printf("\n--- SEÑAL SENOIDAL ---\n");
printf("Valor medio:   %.4f\n", medio_sen);
printf("Max: %.4f | Min: %.4f | Amplitud: %.4f\n", max_sen, min_sen, amplitud_sen);
printf("Potencia media: %.4f | RMS: %.4f\n", pot_sen, rms_sen);
printf("Acción: %.4f | Energía: %.4f\n", accion_sen, energia_sen);

# Resultados para la señal rampa
printf("\n--- SEÑAL RAMPA ---\n");
printf("Valor medio:   %.4f\n", medio_rampa);
printf("Max: %.4f | Min: %.4f | Amplitud: %.4f\n", max_rampa, min_rampa, amplitud_rampa);
printf("Potencia media: %.4f | RMS: %.4f\n", pot_rampa, rms_rampa);
printf("Acción: %.4f | Energía: %.4f\n", accion_rampa, energia_rampa);

# Resultados para la señal cuadrada
printf("\n--- SEÑAL CUADRADA ---\n");
printf("Valor medio:   %.4f\n", medio_cuadrada);
printf("Max: %.4f | Min: %.4f | Amplitud: %.4f\n", max_cuadrada, min_cuadrada, amplitud_cuadrada);
printf("Potencia media: %.4f | RMS: %.4f\n", pot_cuadrada, rms_cuadrada);
printf("Acción: %.4f | Energía: %.4f\n", accion_cuadrada, energia_cuadrada);

# Resultados para la señal aleatoria
printf("\n--- SEÑAL ALEATORIA ---\n");
printf("Valor medio:   %.4f\n", medio_aleatoria);
printf("Max: %.4f | Min: %.4f | Amplitud: %.4f\n", max_aleatoria, min_aleatoria, amplitud_aleatoria);
printf("Potencia media: %.4f | RMS: %.4f\n", pot_aleatoria, rms_aleatoria);
printf("Acción: %.4f | Energía: %.4f\n", accion_aleatoria, energia_aleatoria);