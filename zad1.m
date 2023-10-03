clc
clear
pkg load signal

t = linspace(0,2*pi,64);
for i=1:64
  t(i) = 1*sin(t(i));
endfor
y = zeros(1, 64*2);
j = 1;
for i=1:63
  y(j) = 2*t(i);
  y(j+2) =  2*t(i+1);
  y(j+1) = 2*((t(i+1) - t(i)) /2);
  j+=3;
  endfor
subplot(2,1, 1);
stem(y)
subplot(2,1, 2);
stem(out)

