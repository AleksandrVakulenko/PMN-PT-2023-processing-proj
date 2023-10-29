


% folder = 'Loops_processing/Output_2023_07_25_LT/'
% folder = 'Loops_processing/Output_results_24-Jul-2023_17_51_29/'
folder = 'Output_2023_fall_PZT_tests/';

names = dir(folder);
names = {names.name};
names(1:2) = [];
names = string(names)';

fig = figure;
Coercive = [];
Coercive_n = [];
temp = [];
Span = [];
k = 0;
for i = [3:180] %[3:57 120:180]
N = i;
load([folder char(names(N))])
k = k + 1;

temp(k) = Temp.temp; % K
sample = Loops.sample;
feloop = Loops.feloop;


corrected = feloop_processing(feloop, fig); %FIXME: WRONG SAMPLE SIZE

% Span(k) = max(corrected.P.p) - min(corrected.P.n);
Span(k) = corrected.P.n(end) - corrected.P.n(1);
[Coercive(k), Coercive_n(k)] = getting_percentile_3(corrected, 0.5);
xline(Coercive(k))
xline(Coercive_n(k))


title(num2str(i))
drawnow
% pause(0.1)
end


%%
Coercive(abs(Coercive) > 40) = 5;
Coercive_n(abs(Coercive_n) > 40) = 5;
temp_c = temp-273.15;

figure
hold on
plot(temp_c, Coercive, '-r')
plot(temp_c, -Coercive_n, '-b')

figure
plot(temp_c, Span)
ylim([0 40])






























