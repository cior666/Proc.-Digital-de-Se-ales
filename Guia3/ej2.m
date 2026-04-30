#comprobar que el producto interno mide el grado de parecido
#entre dos senales dadas, para eso generar dos senales 
#senoidales y realizar el producto interno entre ellas.
#luego evaluar el efecto que producen los distintos
#parametros (A,f,tita) sobre el calculo del producto interno

fs = 1000;              #Frecuencia de muestreo (Hz) compartida
t = 0:1/fs:1;

#Señal 1
f= 5;                 # Frecuencia 1
A = 2;                 # Amplitud 1
fase = 0;              # Fase 1
x_1 = A * sin(2 * pi * f * t + fase);


#en el material se indica que el producto interno de 
#un vector consigo mismo es igual al cuadrado de su norma 2
#es decir la energia

#en este caso como son distintos esta def no nos sirve pero 
#podemos asociar tambien al producto interno entre dos vectores
#como la proyeccion de uno sobre el otro y de esta manera
#calcular el prod como: |x|2.|y|2.cos(tita)
#donde tita es el angulo que forman los vectores.
#entonces procedemos a calcular.

#Al tratarse de senales discretas podemos plantear que el 
#producto interno es la suma de la multiplicacion muestra a muestra
#que quiere decir esto? que vamos a multiplicar x1[[i]].x2[i] 
#y sumarlos.

N=length(x_1);

prod_interno=0;

#for i=1:N
#    prod_interno=prod_interno+(x_1(i)*x_2(i));
#end
printf('el producto interno es %f\n',prod_interno);

#Como ya tengo la manera de calcular el producto interno por definicion lo que voy a hacer es armar iteraciones para ver
#como afecta el cambio de la Amplitud, Frecuencia o el angulo de fase. Para ello voy a armar los lazos:

%for f=0:0.5:5 #en este bucle hago iterar la frecuencia de 1 hasta 5 de 0.5 en 0.5hz
%    x_2 = A * sin(2 * pi * f* t + fase);
%    prod_interno=0;
%    for i=1:N %hago prod interno por def.
%            prod_interno=prod_interno+(x_1(i)*x_2(i));
%    end
%    printf('Frecuencia : %.1f Hz | Producto Interno: %f\n', f, prod_interno);
%end

norma_x1 = norm(x_1, 2);
#Ahora voy a variar la amplitud, entonces:
%for A=0:0.5:4 #en este bucle hago iterar la amplitud de 1 hasta 4 saltando de 0.5 en 0.5
%    x_2=A*sin(2*pi*f*t+fase);
%    prod_interno=0;
%    for i=1:N
%        prod_interno=prod_interno+(x_1(i)*x_2(i));
%        end
%        norma_x2 = norm(x_2, 2);
    # Calculamos el producto interno normalizado (Parecido puro)
    # Usamos un condicional para evitar dividir por cero cuando A = 0
%    if norma_x2 == 0
%        prod_normalizado = 0;
%    else
%        prod_normalizado = prod_interno / (norma_x1 * norma_x2);
%    end
    
%    printf('Amplitud: %4.1f | Crudo: %10.4f | Normalizado: %5.2f\n', A, prod_interno, prod_normalizado);
%end

#Ahora voy a hacer variar la fase:
for fase=0:pi/6:pi
    x_2=A*sin(2*pi*f*t+fase);
    prod_interno=0;
    for i=1:N
        prod_interno=prod_interno+(x_1(i)*x_2(i));
    end
    norma_x2=norm(x_2,2);
    #ahora calculamos el prod interno normalizado
    if norma_x2==0
        prod_normalizado=0;
        else
        prod_normalizado=prod_interno/(norma_x1*norma_x2);
    end
    printf('Fase: %4.1f | Crudo: %10.4f | Normalizado: %5.2f\n',fase,prod_interno,prod_normalizado);
end

