
load('PMN-PT_last.mat')
loops_loc = Loops{1};

feloop = loops_loc(8);

E = feloop.init.E.p;
P = feloop.init.P.p;

figure
plot(E)

figure
plot(P)


%%
E = E(1:end/2);
line_x = 1:numel(E);
line_y = -0.01542*line_x + 0.5839;
E = E - line_y;



%%
clc

[amp, f] = fft_amp(E, 1000);

figure('position', [269 203 948 476])
plot(f, amp, '-b', 'linewidth', 1.5)
set(gca, 'xscale', 'log')
set(gca, 'yscale', 'log')
xlabel('f, Hz')
ylabel('amp')


xline(50)
% xline(100)
xline(150)
% xline(200)
xline(250)
% xline(300)
xline(350)
xline(450)

%%

clc

Fd = design_filter(40);
freq = 50;

t = 0:1/1000:1;
x = sin(2*pi*freq*t);

y = filter(Fd, x);

hold on
plot(t, x)
plot(t, y)

%%

Fd = design_filter_2;
Ef = filter(Fd, E);

figure
hold on
plot(E, '-b')
plot(Ef, 'r')

%%


Ef = movmean(E, 6);
Ef = movmean(Ef, 4);

Pf = movmean(P, 6);
Pf = movmean(Pf, 4);

Der = diff(Pf)./diff(Ef);

figure
plot(Der)

figure
hold on
plot(E, '-b')
plot(Ef, 'r')


















