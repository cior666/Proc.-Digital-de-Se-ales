#defino parametros
N=25; #total de muestras
a=0.5; #tomo cualquier a entre 0 y 1.
n=0:(N-1); #vector de tiempo discreto que va de 0 a N-1

#rtas al impulso
hA=sin(8*n);
hB=a.^n;

#defino la entrada
#digamos que tengo q hacer x[n]=delta[n]-a*delta[n-1]
x=zeros(1,N); #vector de tamano N lleno de ceros 
x(1)=1; #seria delta[0] porq esta en indice 1
x(2)=-a; #seria -a*delta[1] que esta en indice 2

#ahora que tengo la senal y las salidas puedo hacer el camino original
#de la misma es decir que pase por el primer sistema y esa rta pase x el sdo

#PRIMERA FORMA (x -> hA -> hB)
v2=conv(x,hA); #salida luego del primer filtro
y=conv(v2,hB); #salida luego del sdo filtro

#SDA FORMA (x -> hB -> hA)
v1=conv(x,hB); #salida usando a hB como primer filtro
y_inv=conv(v1,hA); #salida usando a hA como sdo filtro

#podemos verificar la diferencia entre las mismas de manera que
diferencia=max(abs(y-y_inv));

disp(['la diferencia es ', num2str(diferencia)]);
if diferencia < 1e-10
    disp('salidas iguales :D');
else
    disp('salidas distintas :c');
end

# como comprobamos que son iguales podemos dibujar una sola salida final
figure;

# como comprobamos que son iguales podemos dibujar una sola salida final
subplot(3,1,1);
stem(y, 'filled', 'MarkerFaceColor', 'b');
title('Salida Final y[n] (Ambos órdenes dan esto)');
grid on;

#graficamos el paso intermedio que seria la conv de x con hB
subplot(3,1,2);
# CORRECCIÓN: Usamos v1 (que es x conv hB según tu SDA FORMA)
stem(v1, 'filled', 'MarkerFaceColor', 'r'); 
title('Señal intermedia v[n] = x[n] * hB[n] (El filtro inverso en acción)');
grid on;

#graficamos el otro intermedio q es la conv de x con hA
subplot(3,1,3);
# CORRECCIÓN: Usamos v2 (que es x conv hA según tu PRIMERA FORMA)
stem(v2, 'filled', 'MarkerFaceColor', 'g'); 
title('Señal intermedia v[n] = x[n] * hA[n]');
xlabel('Muestras');
grid on;

pause(100);