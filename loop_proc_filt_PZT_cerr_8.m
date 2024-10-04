
addpath('./include')


% % ------ PMN-10PSN ------
folder = 'Results 2024/Output_2024_07_19_PZT_cer/';
% Sample.h = 0.295e-3; % m
% Sample.s = pi*(1.84e-3/2)^2; %m^2

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
Sample = Loops.sample;
Sample.s = NaN; %m^2

sz1 = size(feloop.init.E.p, 2);
sz2 = size(feloop.ref.E.p, 2);
if sz1 ~= sz2
    diff = sz1 - sz2;
    range = (diff+1):sz1;
    feloop.init.E.p = feloop.init.E.p(range);
    feloop.init.P.p = feloop.init.P.p(range);
end

% feloop = loop_pulses_filter(feloop); % filter single pulses in data
% corrected = feloop_processing(feloop, Sample, fig); %FIXME: WRONG SAMPLE SIZE

cla
hold on
LW_init = 4;
LW_ref = 1;

Einit = feloop.init.E.p;
Pinit = feloop.init.P.p;
Einit = movmean(Einit, 500);
Pinit = movmean(Pinit, 500);
Einit_p = Einit/1000/(Sample.h*100);
Pinit_p = Pinit*1e6;

Einit = feloop.init.E.n;
Pinit = feloop.init.P.n;
Einit = movmean(Einit, 500);
Pinit = movmean(Pinit, 500);
Einit_n = Einit/1000/(Sample.h*100);
Pinit_n = Pinit*1e6;

Shift_p = (Pinit_p(end)-Pinit_p(1))/2;
Pinit_p = Pinit_p - Shift_p;

Shift_n = (Pinit_n(end) - Pinit_n(1))/2;
Pinit_n = Pinit_n - Shift_n;

plot(Einit_p, Pinit_p, '-b', 'linewidth', LW_init)
plot(Einit_n, Pinit_n, '-b', 'linewidth', LW_init)


ylim([-60 60])
% xlim([-20 20])
grid on
set(gca, 'fontsize', 18, 'FontWeight', 'bold')
xlabel('E, kV/cm', 'fontsize', 18)
ylabel('Q, uC', 'fontsize', 18)

Sample_name = Sample.name;
title(['Sample N <' Sample_name '>'])

Pic_name = [folder 'pics/' num2str(i) '.png'];
saveas(fig, Pic_name);

drawnow
pause(0.5)
end


