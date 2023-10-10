% Generate sine wave, sample it
SR=10400*1000;
f=104*1000;
fs=SR;
duration=0.5/1000;

t = 0:1/fs:duration;
%t=linspace(0,2/f,1024);
sig = sin(2*pi*f*t);
sig2 = sin(2*pi*2000*t).+sin(2*pi*3000*t).+sin(2*pi*6600*t);
fs_full = 1000;
t_full = 0:1/fs_full:duration;
sig_full = sin(2*pi*f*t_full);
figure;
subplot(411); plot(t_full,sig_full,'b-','LineWidth',2); ylabel('Amplitude'); title('Signal to sample')
subplot(412); plot(t_full,sig_full,'b-',t,sig,'rx','LineWidth',2,'MarkerSize',1); ylabel('Amplitude'); title('Sampled points (carrier wave)')
subplot(413); plot(t,sig2,'rx','LineWidth',2,'MarkerSize',1); ylabel('Amplitude'); title('Modulating wave')
multiplier = 1/max(sig2);
sig2 = sig2.*multiplier;
subplot(414); plot(t,sig2.*sig,'rx','LineWidth',2,'MarkerSize',1); ylabel('Amplitude'); title('Modulated signal')



[h, w] = freqz (sig, 1, [], SR);
[h2, w2] = freqz (sig2, 1, [], SR);
[hm, wm] = freqz (sig.*sig2, 1, [], SR);

figure;
subplot(231); plot(w/pi,abs(h));
subplot(234); plot(w/pi, angle(h));

subplot(232); plot(w2/pi,abs(h2));
subplot(235); plot(w2/pi, angle(h2));

subplot(233); plot(wm/pi,abs(hm));
subplot(236); plot(wm/pi, angle(hm));
