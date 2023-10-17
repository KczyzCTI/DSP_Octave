clear;clc
pkg load signal

f = 0.1;
q=10;
s=-pi*f/q + i*pi*f*sqrt(4-(1/q));
#s=1/(s*s+s*sqrt(2)+1);
[b, a] = bilinear([1, 0], [1, -(conj(s)+s),s*conj(s)], 1);
h = freqz(b,a);
xf = linspace(0,0.5, length(h));
plot(xf, abs(h));







return;
cb=cool(10);
s=tf('s');
L_array=5:5:50;

figure; hold on;
for i=1:length(L_array)
    L=L_array(i);
    G=((58.2+11.7*L)*s^2*25^2+(3996.8 + 815.7*L)*s*25+815.7*25^2)/(s^2*(s^2*25^2+126.9*s*25+(3996.8+1.9*25^2)));
    CL=feedback(G,1);
    pzmap(CL);

end

% lets do this in the end!

% you will have length(L_array)*2 +1 items in h
 h = findobj(gca,'type','line');
for jj=2:length(h)
        set(h(jj),'MarkerSize',12,'Color',cb(floor(jj/2),:));
end
grid;

colormap(cool);   % I am using cool, you can use cool, but I discourage it
c=colorbar;

hold off;
bode(G)
