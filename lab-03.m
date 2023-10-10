% projektowanie filtra - transformata Z
clc;clear;pkg load signal;
% butterworth S domain low pass for normalized frequency
H_2S = @(s) (1/((s*s)+sqrt(2)*s+1));
s=-0.1:0.01:10
y=arrayfun(H_2S, s);
plot(s,y)

