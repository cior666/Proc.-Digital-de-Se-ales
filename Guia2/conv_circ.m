#en este ej me piden hacer la convolucion circular discreta entre dos senales
#x[n] y h[n], de caualq longitud usando ciclos for.
#debo considerar a x[n] periodica pero h[n]debe ser nula fuera de su rango de definicion
function y=conv_circ(x,h)
N=length(x);
M=length(h);
#hacemos la verificacion como buena practica
if N~=M
    error('las senales tienen que tener el mismo tamanio');
end

#como hicimos antes tengo que inicializar el vector de salida con ceros
y=zeros(1,N);

#ahora hago la suma con el doble for usando la ayuda que nos da la guia
#entonces mi bucle externo se va a mover por las posiciones k de la salida (1 a N)
for k=1:N
    suma=0;
    #y el bucle interno se va a mover por las posiciones n de la entrada (1 a N)
    for n=1:N
        indicex=mod((N+k-n),N)+1; #esto es para que x[n] sea periodica, el +1 es porque octave arranca en 1
        #ahora multiplico y acumulo siguiendo la formula del apunte
        suma=suma+x(indicex)*(h(n)); #h[n] es nula fuera de su rango de definicion
        end
        y(k)=suma; #guardo el valor en la pos de salida =k
    end
end
