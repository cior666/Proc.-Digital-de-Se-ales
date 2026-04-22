import numpy as np
import matplotlib.pyplot as plt

#Escribir funciones que permitan generar las siguientes señales:
#1 Una senoidal que responda a la ecuación y(n)== sen(2πfst+φ), donde t
#es la variable de tiempo discreto, con paso 1/fm, fm pertenece a los Reales
#es la frecuencai de muestreo y fs pertenece a los reales que es la frecuencia
#de la senoidal y φ pertenece al intervalo (-pi,pi) su fase.

def generar_senoidal(fs, fm, phi, duracion):
    # t es la variable de tiempo discreto, con paso 1/fm
    t = np.arange(0, duracion, 1/fm)
    
    # Ecuación de la señal senoidal
    y = np.sin(2 * np.pi * fs * t + phi)
    
    return t, y

# Generamos una señal de prueba (Ej: señal de 5 Hz, muestreada a 100 Hz, fase 0, durante 1 seg)
t, y = generar_senoidal(fs=5, fm=100, phi=0, duracion=1)

# Graficamos la señal (usamos plt.stem porque se trata de una señal de tiempo discreto)
plt.stem(t, y)
plt.title('Señal Senoidal Discreta')
plt.xlabel('Tiempo [s]')
plt.ylabel('Amplitud y(n)')
plt.grid(True)
plt.show()
