% Parámetros comunes de muestreo
t_inicial = 0;
t_final = 5;
fm = 1000;

% Señal Base
phi_0 = 0;
fs_0 = 5;
[y_base, t] = generar_senoidal(fs_0, fm, phi_0, t_inicial, t_final);

%         Caso 1 (Base) | Caso 2 (Frec) | Caso 3 (Fase) | Caso 4 (Amp)
f_vec   = [5,             12,             5,              5];
phi_vec = [0,             0,              pi/2,           0];
A_vec   = [1,             1,              1,              5];

descripciones = {
    '1. Señales identicas (Máximo parecido)',
    '2. Distinta frecuencia (f = 12 Hz)',
    '3. Distinta fase (Ortogonales, phi = 90 deg)',
    '4. Distinta amplitud (Misma forma, A = 5)'
};

for i = 1:length(f_vec)
    % Generamos la 21señal de prueba para la iteración actual
    [y_test, t] = generar_senoidal(f_vec(i), fm, phi_vec(i), t_inicial, t_final);
    y_test = A_vec(i) * y_test;

    prod_interno = sum(y_base .* y_test);

    fprintf('%s\n', descripciones{i});
    fprintf('   Parametros: f = %d Hz | phi = %.2f rad | A = %d\n', f_vec(i), phi_vec(i), A_vec(i));
    fprintf('   Producto Interno = %.4f\n\n', prod_interno);
end

#Efecto de la Frecuencia (f): Al cambiar la frecuencia de 5 Hz a 12 Hz, el producto interno cayó abruptamente a 0.
#Señales con diferentes frecuencias enteras en un mismo período de análisis son ortogonales. La proyección de una sobre la otra es nula.

#Efecto de la Fase : Al aplicar un desfase de 90° el resultado volvió a ser 0.
#La alineación temporal es crítica. Un seno y un coseno de la misma frecuencia son geométricamente ortogonales.

#Efecto de la Amplitud (A): Al aumentar la amplitud de 1 a 5, el producto interno pasó de 2500 a 12500 (exactamente 5 veces más).
#Modificar la amplitud actúa como un simple factor de escala numérico. Amplifica el resultado final, pero la "forma" o el grado fundamental de parecido entre las señales sigue siendo exactamente el mismo.