#Dado que hay 8 notas de 0.5 segundos cada una, dividimos la señal total en 8 bloques o utilizamos una ventana móvil.
#Luego creamos un vector local y[n] que sea una senoidal pura de 440 Hz con la misma duración que los segmentos analizados.
#Finalemente: Para cada segmento de la señal original x_i[n]:
#- Calcula el producto interno: <x_i, y> = sum x_i[n] * y[n].
#- Nota: Es recomendable usar el valor absoluto o la magnitud de la proyección para evitar problemas con la fase.
#- Conclusion: El segmento i que presente el mayor valor del producto interno es el que corresponde a la nota LA.
[x,fs]=audioread('escala.wav');

t_seg=0.5;
L=round(t_seg*fs);

#hacemos la referencia para LA(440hz)
n=0:L-1;
refe_LA=sin(2*pi*440*n/fs);

#detecamos cada uno de los 8 tramos
for i=1:8
    inicio=(i-1)*L+1;
    fin=i*L;
    segmento=x(inicio:fin);

    #prod interno q representa el grado de parecido
    parecido(i)=abs(dot(segmento, refe_LA));
end

#encontramos el valor maximo
[valor,posicion]=max(parecido);
fprintf('La nota LA se encuentra en el segmento: %d\n', posicion);
fprintf('Tiempo de inicio: %.2f segundos\n', (posicion-1)*t_seg);
