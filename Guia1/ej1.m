function [t,x] =generasen(tini,tfin,fm,fs,fase)
    T=1/fm;
  t=tini:T:tfin-T;
  x=sin(2*pi*fs*t+fase)
