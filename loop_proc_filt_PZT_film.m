
addpath('./include')
clc

% % ------ PZT film ------
% folder = '../PMN-PT 2023 measuring/Output_2024_09_18_PZT_film/';
folder = '../PMN-PT 2023 measuring/Output_2024_10_03_PZT_film/';

names = find_files(folder);

fig = figure('position', [416   272   785   739]);
Coercive = [];
Coercive_n = [];
temp = [];
Span = [];
Span_p = [];
Span_n = [];
k = 0;
% del_range = [1:5, 14, 16:18];
% names(del_range') = [];
for i = 1:numel(names)

load(names(i).full_path)
k = k + 1;

sample = Loops.sample;
feloop = Loops.feloop;

% feloop = loop_pulses_filter(feloop); % filter single pulses in data
corrected = feloop_processing(feloop, Sample, fig);

Span_n(k) = corrected.P.n(end) - corrected.P.n(1);
Span_p(k) = -corrected.P.p(end) + corrected.P.p(1);
Span(k) = mean([Span_p(k), Span_n(k)]);
[Coercive(k), Coercive_n(k)] = getting_percentile_3(corrected, 0.5);
xline(Coercive(k));
xline(Coercive_n(k));
title([num2str(i) ' / ' char(names(i).filename)])

% xlim([-50 50])
drawnow
pause(0.5)
end

%%

figure
hold on
plot(Coercive)
plot(-Coercive_n)

ylim([0 1000])


figure
hold on
Mean_coer = (abs(Coercive) + abs(Coercive_n))/2;
Diff_coer = abs(Coercive) - abs(Coercive_n);
plot(Mean_coer)
plot(Diff_coer)



















