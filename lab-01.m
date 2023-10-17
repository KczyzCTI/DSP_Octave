clc;clear;
pkg load signal
% DSP lab - oversampling
% @Kordian Czyżewski,
% @Adrian Krakowski
%% Following script performs signal oversampling using Kaiser window.
%%
mult=100; % oversampling factor
SR = 8000; % sample rate

% Parks-McClellan filter design
cutoff = SR/(2*mult);
[n,f,a,w] = firpmord([cutoff cutoff+2],[1 0],[0.001 0.01],SR);
b = firpm(n,f,a,w);

% Kaiser window filter design
[n, w, beta, ftype] = kaiserord ([cutoff, cutoff+2], [1, 0], [0.05, 0.05], SR);
bk = fir1(n, w, kaiser (n+1, beta), ftype, "noscale");

% Plot frequency response of designed filters
figure;
[hk, wk] = freqz (bk, 1, [], SR);
figure;

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

% Generate sine wave, sample it
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

% select filter for interpolation
kern=bk; % bk || b
%kern= blackman(512);

% convolve filter & signal
sig2  =conv(kern,upsample(sig,mult));

sig2 =sig2(length(kern)/2:length(kern)/2+length(sig)*mult-1);
mult = 1/max(sig2);
sig2 = sig2.*mult;
% plot result
figure;
subplot(111);plot(t2,sig2,'-b',t2,sig_ideal,'rx','LineWidth',0.2,'MarkerSize',0.1); ylabel('Amplitude'); title('Signal upsampled by factor of 100')
legend('x100 resampling','ideal signal')
xlabel('Time / s')
length(sig2)

