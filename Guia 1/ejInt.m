######Parte 1:
A=5;
fs=10;
phi=pi/4;
fm=400;
paso=1/fm;
t=0:paso:0.5;

#hacer la senal
x_orig=A*sin(2*pi*fs*t+phi);

#para rectificar la hacemos ir de 0 a 5, podria usar la del ej 2 pero lo hago de nuevo
x_rect=abs(x_orig);

#Cuantizar en 16 niveles
niveles=16;
#seguimos la misma logica que el ej 2
minimo=min(x_rect);
x_pos=x_rect-minimo;
#buscamos el alto del escalon
H=max(x_pos)/(niveles-1);
rho=zeros(size(x_pos));#inicializamos el vector vacio
#hacemos las condiciones
rho(x_pos<0)=0; #caso del piso
rho(x_pos>=(niveles-1)*H)=(niveles-1)*H; #caso techo

mascara=(x_pos>=0) & (x_pos<(niveles-1)*H); #seria el cuerpo de la func.
rho(mascara)=H* round(x_pos(mascara)/H);#cuantizamos con el round p disminuir error

y_cuant=rho+minimo;#volvemos al desplazamiento original,como hicimos en ej2
#graficamos
figure(2); clf;
plot(t, x_orig, 'g--', 'linewidth', 1); hold on;
stairs(t, y_cuant, 'b', 'linewidth', 2);           #cuantizada
# Para que se noten los 16 niveles, podemos dibujar líneas horizontales tenues
niveles_y = linspace(min(y_cuant), max(y_cuant), 16);
hline = arrayfun(@(y) yline(y, 'color', [0.8 0.8 0.8], 'linestyle', ':'), niveles_y);
title('Señal Original vs. Rectificada y Cuantizada (16 niveles)');
xlabel('Tiempo (s)');
ylabel('Amplitud (V)');
legend('Original (Continua en amplitud)', 'Procesada (Discreta en amplitud)');
grid on;



#####Parte 2
#buscamos la potencia de la senal, como los ejs anteriores
ps=mean(y_cuant.^2);
#generamos el ruido
ruido_orig=randn(1,length(t));
pr_orig=mean(ruido_orig.^2);
y=y_cuant+ruido_orig;
SNR_1=ps/pr_orig;
SNR_db1=10*log10(SNR_1);

#procedo a mostrar los valores obtenidos
fprintf('Valores iniciales obtendos \n');
fprintf('Potencia senal (PS): %f\n',ps);
fprintf('Potencia ruido (PN): %f\n',pr_orig);
fprintf('SNR en db inicial: %f\n',SNR_db1);


#grafico la original
 figure(1); clf;
    subplot(3,1,1);
    plot(t, y_cuant, 'b', 'linewidth', 1.5);
    title('Señal Conocida Original');
    grid on;
#grafico con ruido
    subplot(3,1,2);
    plot(t, y, 'k');
    title(sprintf('Señal + Ruido (SNR = %.2f dB)', SNR_db1));
    grid on;

#la relacion senal ruido sea 6db (es parecido a lo de 0db del ej 8)\
SNR_6db=6;
k_6db=sqrt(ps/(pr_orig*10^(SNR_6db/10)));
ruido_k6=k_6db*ruido_orig;
y_6db=y_cuant+ruido_k6;
#aca ya tenemos la senal nueva, entonces procedemos a verificar como en ej 8
p_6db=mean(ruido_k6.^2);
SNR_f=10*log10(ps/p_6db);

#muestro los valores obtenidos
fprintf('--- FORZANDO SNR A 6 dB ---\n');
fprintf('Constante calculada (k): %f\n', k_6db);
fprintf('Potencia del Ruido resultante: %f\n', p_6db);
fprintf('SNR Final verificada: %f dB\n', SNR_f);

#grafico los valores de los 6db
    subplot(3,1,3);
    plot(t, y_6db, 'r');
    title(sprintf('Señal + Ruido forzado a 6 dB (k = %.2f)', k_6db));
    xlabel('Tiempo (s)');
    grid on;




