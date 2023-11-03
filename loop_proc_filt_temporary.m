
addpath('./include')

% Experiment = 'PMN33PT'; % 'PMN33PT' or 'PZT19'
Experiment = 'PZT19'; % 'PMN33PT' or 'PZT19'

if Experiment == "PMN33PT"
    % ------ PMN-33PT fall 2023 100um ------
    folder = 'Results 2023/Results_2023_10_11_PMN_33PT/';
    Sample.h = 100e-6; % m
    Sample.s = 0.003*0.003; % m^2
    loops_range = 1:14;
elseif Experiment == "PZT19"
    % % ------ PZT-19 ------
    folder = 'Results 2023/Results_2023_10_17_PZT_19/loops/';
    Sample.h = 100e-6; % m
    Sample.s = 880e-6*940e-6; %m^2
    loops_range = 3:4:720;
else
    error('wrong exp name')
end

names = dir(folder);
names = {names.name};
names(1:2) = [];
names = string(names)';

fig = figure('position', [416   272   785   739]);
Coercive = [];
Coercive_n = [];
temp = [];
Span = [];
Span_p = [];
Span_n = [];
k = 0;
for i = loops_range
    load([folder char(names(i))])
    k = k + 1;

    temp(k) = Loops.temp ; % K
    if Experiment == "PMN33PT"
        temp(k) = Loops.temp + 273.15; % K
    end

    sample = Loops.sample;
    feloop = Loops.feloop;

    if Experiment ~= "PMN33PT"
        feloop = loop_pulses_filter(feloop); % filter single pulses in data
    end

    corrected = feloop_processing(feloop, Sample, fig);

    % Span(k) = max(corrected.P.p) - min(corrected.P.n);
    Span_n(k) = corrected.P.n(end) - corrected.P.n(1);
    Span_p(k) = -corrected.P.p(end) + corrected.P.p(1);
    Span(k) = mean([Span_p(k), Span_n(k)]);
    [Coercive(k), Coercive_n(k)] = getting_percentile_3(corrected, 0.5);
    xline(Coercive(k));
    xline(Coercive_n(k));


    title([num2str(i) ' T = ' num2str(temp(k)) ' K'])
%     xlim([-50 50])
    drawnow
    % pause(0.5)
end


%%
% Coercive(abs(Coercive) > 40) = 5;
% Coercive_n(abs(Coercive_n) > 40) = 5;
temp_c = temp-273.15;
% temp_c = temp;

% range = temp_c < 56 & temp_c > 42;
% x = temp_c(range);
% y =  Span(range);
% range = 1:numel(temp_c);
range = [42:77 121:164];
% range = temp < 346;
% range(1:4) = [0 0 0 0];

x = temp(range);
y = Coercive(range);
C = 3.967;
Eh = 39.75;
p = 1.456;
x_n = linspace(50-273.15, 565-273.15, 100);
y_n = Eh*(1-(x_n+273.15)/565).^p+C
y_n2 = -0.07259*(x_n+273.15) + 39.16;

figure('position', [536 175 706 817])
subplot(2, 1, 1)
hold on
plot(temp_c(range), Coercive(range), '.r', 'markersize', 10)
plot(x_n, y_n)
plot(x_n, y_n2, '-b')
% plot(temp_c(range), -Coercive_n(range), '.-b')
xlabel('T, C')
ylabel('Ec, kV/cm')
ylim([0 40])
xlim([50 600]-273.15)
% xlim([-200 320])

subplot(2, 1, 2)
plot(temp_c(range), Span_n(range), '.b', 'linewidth', 1.5, 'markersize', 10)
ylim([0 80])
xlabel('T, C')
ylabel('2*Ps, uC/cm^2')
xlim([140 500]-273.15)
% xlim([-200 320])

% hold on
% y2 = -1.013*x + 73.36;
% plot(x, y2, '-r', 'linewidth', 1.2)


%% PMN33PT

temp_c = temp-273.15;

% range = temp_c < 56 & temp_c > 42;
% x = temp_c(range);
% y =  Span(range);
range = 1:numel(temp_c);
% range = [42:77 121:164];
% range = temp < 346;
% range(1:4) = [0 0 0 0];

x = temp(range);
y = Coercive(range);
C = 3.967;
Eh = 39.75;
p = 1.456;


figure('position', [536 175 706 817])
subplot(2, 1, 1)
hold on
plot(temp_c(range), -Coercive(range), '.r', 'markersize', 10)
xlabel('T, C')
ylabel('Ec, kV/cm')
ylim([0 4])
% xlim([50 600]-273.15)
% xlim([-200 320])

subplot(2, 1, 2)
plot(temp_c(range), -Span_n(range), '.b', 'linewidth', 1.5, 'markersize', 10)
ylim([0 80])
xlabel('T, C')
ylabel('2*Ps, uC/cm^2')
% xlim([140 500]-273.15)
% xlim([-200 320])

% hold on
% y2 = -1.013*x + 73.36;
% plot(x, y2, '-r', 'linewidth', 1.2)









