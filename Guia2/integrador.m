#la parte 1 esta hecha en la carpeta

#####################################
#parte 2
N=20;
x=zeros(1,N);
x(1)=1; #seria el delta[0]
h=zeros(1,N);
for n=1:N
    if n==1
        h(1)=x(1); #seria el caso de n=1 que hice en hoja
    else
        h(n)=x(n)+0.2*x(n-1)+0.6*h(n-1);
    end
end 

#figure;
#subplot(2,1,1);
#stem(h, 'filled', 'MarkerFaceColor', 'm');
#title('rta a los impulsos h[n]');
#subplot(2,1,2);
#stem(x, 'filled', 'MarkerFaceColor', 'c');
#title('entrada x[n]');
#pause(100);

###################################################################################
#parte 3
L=10;
x_nueva=zeros(1,L); #pulso de 10 muestras
M=length(h); #long de la rta anterior

#convolucion lineal 
y_lineal=conv(x_nueva,h);

#conv matricial
col_1=[h,zeros(1,L-1)]; #primera columna de la matriz de convolucion, rellena de 0 
fil_1=[h(1),zeros(1,L-1)]; #primera fila de la matriz de convolucion, rellena de 0

h_matriz=toeplitz(col_1,fil_1); #creo la matriz de convolucion usando la funcion de octave
y_matricial=h_matriz*x_nueva'; #multiplico la matriz por el vector de entrada
#ahora la transpongo
y_b=y_matricial';

#por ultimo me pide la circular pero que salga como lineal 
Ntot=L+M-1; #este seria el tamano necesario para q
#la circular q planteo tenga el mismo tamanio

x_relllena=[x_nueva,zeros(1,Ntot-L)]; #relleno la entrada con ceros
h_rellena=[h,zeros(1,Ntot-M)]; #relleno la rta con ceros.

#ahora procedo a hallar la circular usando la funcion que hice antes
y_circular=conv_circ(x_relllena,h_rellena);



# calculo el error entre la lineal y las otras dos
error_matricial = max(abs(y_lineal - y_b));
error_circular  = max(abs(y_lineal - y_circular));

disp(['Error máximo (Lineal vs Matricial): ', num2str(error_matricial)]);
disp(['Error máximo (Lineal vs Circular):  ', num2str(error_circular)]);

if error_matricial < 1e-10 && error_circular < 1e-10
    disp('los tres metodos dan el mismo resultado :D');
else
    disp('hay diferencias entre los metodos :c');
end

figure;
hold on;
# hago las 3 superpuestas a ver si coinciden o no
stem(y_lineal, 'b', 'LineWidth', 2, 'MarkerSize', 8);     # Lineal en azul (tallo)
stem(y_b, 'rx', 'LineWidth', 2, 'MarkerSize', 10);        # Matricial en cruces rojas
stem(y_circular, 'g.', 'LineWidth', 2, 'MarkerSize', 15); # Circular en puntos verdes

title('Comparación de Salidas y[n] (Parte 3)');
xlabel('Muestras (n)');
ylabel('Amplitud');
legend('Lineal (conv)', 'Matricial', 'Circular (conv\_circ)');
grid on;
hold off;
pause(100);