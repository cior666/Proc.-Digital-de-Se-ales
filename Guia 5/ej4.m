pkg load signal;
which c2d;
num=[12500 0];
den=[44 60625 625e4];
Hs=tf(num,den);
% Bode del sistema continuo
figure
bode(Hs)
grid on

%ahora buscamos fc
[w,mag]=bode(Hs);
w=squeeze(w);
mag=squeeze(mag);
% máximo
mag_max = max(mag);
% nivel -3 dB
nivel = mag_max/sqrt(2);%busco donde vale la frecuencia de corte
% índice más cercano
[~,idx] = min(abs(mag-nivel));
wc = w(idx);
fc = wc/(2*pi);
disp(fc);

%ahora que sabemos cuanto vale fc, podemos hallar fs
fs=4*fc;
T=1/fs;
%ahora hacemos Euler:
Hz_euler=c2d(Hs,T,'backward');
%y Bilineal
Hz_bilin=c2d(Hs,T,'tustin');
%c2d hace continuo a discreto, es decir que realiza automaticamente el pasaje de H(s) a H(z) usando el metodo que yo elija 
disp('Euler');
tfdata(Hz_euler);

disp('Bilineal');
tfdata(Hz_bilin);
%comparacion frecuencial
figure;
bode(Hs);
hold on;
bode(Hz_euler);
bode(Hz_bilin);
grid on;
legend('Continuo','Euler','Bilineal');

disp(fc);
disp(fs);
disp(T);