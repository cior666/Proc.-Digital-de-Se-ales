#implementar la convolucion luineal mediante una sumatoria de convolucion
#tengo que probarla para convolucionar dos señales de cualquier longitud 
#comparar mediante la funcion con(x,y) y con la funcion filter
#La func Y=filter(B,A,X) implementa la ec en diferencias
#para los coef dados en los vectores A y B la senal de entrada X segun: 
#a(1)*y(n) = b(1)*x(n) + b(2)*x(n-1) + ...- a(2)*y(n-1)- ...
#usando esto tengo que encontrar los valores a ingresar en los vectores
#A y B para obtener la salida esperada

#defino dos senales de entrada aleatorias.
x=[1,2,3,4,5];
h=[0.5,1,0.5,0,0];

L=length(x);
M=length(h);
longitud_salida=L+M-1;

#necesito un vector de salida que de tamano tiene q ser longitud de salida (para tener todos)
#los resultados
y=zeros(1,longitud_salida);

#ahora hago la suma con el doble for 
for n=1:longitud_salida #este for itera sobre la salida es decir sobre y[n]
    k_min=max(1,n-M+1); #minimo
    k_max=min(n,L); #maximo
    for k=k_min:k_max #este for itera sobre k es decir la entrada.
        #como vimos en las otras guias 
        #octave arranca en 1 entonces tengo que sumar +1
        y(n)=y(n)+x(k)*h(n-k+1); #definicion de convolucion lineal 
    end
end

disp('Convolucion a pata: ');
disp(y);

#ahora me pide hacerla con la funcion conv(x,y)
y_nueva=conv(x,h);
disp('Convolucion con funcion conv: ');
disp(y_nueva);

#por ultimo la tengo que hacer con la filter.
#entocnes, tengo que definir a B=h y a A=1
#el por que esta explicado en el drive, como no hay retroalimentacion
#es del tipo FIR,, por lo q la salida solo depende de la entrada
#por lo que para que esto ocurra necesito que todos los coef A 
#sean 0 excepto el primero que debe tomar el valor de 1.
A=1;
B=h;
x_nuevo=[x,zeros(1,M-1)]; #tengo que agregar ceros a la senal de entrada para que 
#tenga el mismo tamano que la salida esperada
y_filter=filter(B,A,x_nuevo);
disp('convolucion con funcion filter: ');
disp(y_filter);

