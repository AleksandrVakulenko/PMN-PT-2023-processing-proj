
addpath('./include')


% % ------ PMN-10PSN ------
folder = 'Results 2024/Results_2024_04_17_PMN_10PSN_225K/';
Sample.h = 0.295e-3; % m
Sample.s = pi*(1.84e-3/2)^2; %m^2


names = dir(folder);
names([names.isdir]) = [];
names = {names.name};
names = string(names)';

fig = figure('position', [416   312   845   699]);
Coercive = [];
Coercive_n = [];
Span = [];
Span_p = [];
Span_n = [];
k = 0;
for i = 1:numel(names)%3:4:720 %[3:4:720]
N = i;
load([folder char(names(N))])
k = k + 1;

% temp(k) = Temp.temp; % K
% sample = Loops.sample;
feloop = Loops.feloop;

% feloop = loop_pulses_filter(feloop); % filter single pulses in data
% corrected = feloop_processing(feloop, Sample, fig); %FIXME: WRONG SAMPLE SIZE

cla
hold on
LW_init = 1;
LW_ref = 1;

Einit = feloop.init.E.p;
Pinit = feloop.init.P.p;
Einit_p = Einit/1000/(Sample.h*100);
Pinit_p = Pinit*1e6/(Sample.s*100^2);

Einit = feloop.init.E.n;
Pinit = feloop.init.P.n;
Einit_n = Einit/1000/(Sample.h*100);
Pinit_n = Pinit*1e6/(Sample.s*100^2);

Shift_p = (Pinit_p(end)-Pinit_p(1))/2;
Pinit_p = Pinit_p - Shift_p;

Shift_n = (Pinit_n(end) - Pinit_n(1))/2;
Pinit_n = Pinit_n - Shift_n;

plot(Einit_p, Pinit_p, '-b', 'linewidth', LW_init)
plot(Einit_n, Pinit_n, '-b', 'linewidth', LW_init)


ylim([-45 45])
xlim([-20 20])
grid on
set(gca, 'fontsize', 18, 'FontWeight', 'bold')
xlabel('E, kV/cm', 'fontsize', 18)
ylabel('P, uC/cm^2', 'fontsize', 18)

title(['N = ' num2str(k)])

% Pic_name = [folder 'pics/' num2str(i) '.png'];
% saveas(fig, Pic_name);

drawnow
% pause(0.05)
if i == 2
    pause(1.0)
end
end


