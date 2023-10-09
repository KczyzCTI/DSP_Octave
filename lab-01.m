clc;clear;
pkg load signal
% DSP lab - oversampling
% @Kordian Czyżewski,
% @Adrian Krakowski
%% Following script performs signal oversampling using Kaiser window.
%%
mult=100;
SR = 8000;
cutoff = SR/(2*mult);
[n,f,a,w] = firpmord([cutoff cutoff+2],[1 0],[0.001 0.01],SR);
b = firpm(n,f,a,w);

%kaiser
[n, w, beta, ftype] = kaiserord ([cutoff, cutoff+2], [1, 0], [0.05, 0.05], SR);
bk = fir1(n, w, kaiser (n+1, beta), ftype, "noscale");
[hk, wk] = freqz (bk, 1, [], SR);

[h,w] = freqz(b,1,[],SR);
figure;
subplot(211);
plot(f,a,w/pi,abs(h));
legend('Ideal','kaiser Design')
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude'
subplot(212);
plot(f,a,wk/pi,abs(hk));
legend('Ideal','firpm Design')
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude'

% sine
f=140;
fs=SR;
duration=0.5;

t = 0:1/fs:duration;
t=linspace(0,2/f,1024);
sig = sin(2*pi*f*t);
fs_full = 1000;
t_full = 0:1/fs_full:duration;
sig_full = sin(2*pi*f*t_full);
figure;
subplot(311); plot(t_full,sig_full,'b-','LineWidth',2); ylabel('Amplitude'); title('Signal to sample')
subplot(312); plot(t_full,sig_full,'b-',t,sig,'rx','LineWidth',2,'MarkerSize',1); ylabel('Amplitude'); title('Sampled points')
subplot(313); plot(t,sig,'rx','LineWidth',2,'MarkerSize',1); ylabel('Amplitude'); title('Discrete time points kept')
t2 = linspace(0, 2/(f*mult),1024*mult);
sig_ideal = interp(sig,mult);
kern=bk;

sig2  =conv(kern,upsample(sig,mult));
%sig2 = upsample(sig,mult);
%sig2 = conv(kern, [1 zeros(1,1023)]);
sig2 =sig2(length(kern)/2:length(kern)/2+length(sig)*mult-1).*mult;
figure;
subplot(111);plot(t2,sig2,'-b',t2,sig_ideal,'rx','LineWidth',0.2,'MarkerSize',0.1); ylabel('Amplitude'); title('Signal upsampled by factor of 2')
%subplot(111);plot(sig2, 'rx','LineWidth',0.1,'MarkerSize',0.1); ylabel('Amplitude'); title('Signal upsampled by factor of 2')
xlabel('Time / s')
length(sig2)

