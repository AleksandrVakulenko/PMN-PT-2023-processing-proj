
% TODO: add version to feloop struct
%TODO: include sample struct into feloop 

clc
addpath('include\');

fig = figure('position', [443 80 620 685]);


Temp_range = find(Loop_temp > 140 & Loop_temp < 280);
% Temp_range = 1:87;
% Temp_range = 1:numel(Loops);

Temp_out = [];
Coercive_p = [];
Coercive_n = [];
Span_out = [];
Period = [];
for freq_N = 1:8
    freq_N
    j = 0;
    for i = Temp_range
    j = j + 1;

    Loops_loc = Loops{i};
%     Loops_loc = Loops(i);
    
    % HERE USE VERSION CONTROL
    feloop = Loops_loc(freq_N); % OLD CODE
%     feloop_full = Loops_loc(freq_N); % NEW CODE
%     feloop = feloop_full.feloop; % NEW CODE
    
    feloop = feloop_swap_p_n(feloop);
    corrected = feloop_processing(feloop, fig);
    
%     Span(i, freq_N) = corrected.P.p(end) - corrected.P.p(1);
%     Coercive(i, freq_N) = getting_percentile_3(corrected, 0.5);

    Temp_out(freq_N, j) = Loop_temp(i);
    [Coercive_p(freq_N, j), Coercive_n(freq_N, j)] = getting_percentile_3(corrected, 0.5);
    Span_out(freq_N, j) = corrected.P.p(end) - corrected.P.p(1);
    Period(freq_N) = numel(feloop.init.E.n)/1000;
    xline(Coercive_p(freq_N, j))
    xline(Coercive_n(freq_N, j))
    
    
    title(num2str(Loop_temp(i)))
    
%     pause(0.1)
    
    end

end

%%

Coercive_mean = (-Coercive_p + Coercive_n)/2;

range = 30:59;
Coercive_mean_cut = Coercive_mean(:, range)';
Temp_out_cut = Temp_out(:, range)';
Span_out_cut = Span_out(:, range)';

Temp_out_cut(:,1) = [];
Coercive_mean_cut(:, 1) = [];
Period(1) = [];
%%
for freq_N = 2:8

Temp = Temp_out_cut(:, freq_N);
Coercive = Coercive_mean_cut(:, freq_N);
hold on
plot(Temp, Coercive, '.r')

% D Eh p
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Lower = [0 0 1];
opts.StartPoint = [1 40 1];
opts.Upper = [10 100 5];
ft = fittype( 'Eh*(1-x/360)^p + D', 'independent', 'x', 'dependent', 'y' );
Fit_obj = fit(Temp, Coercive, ft, opts);

plot(Fit_obj, Temp, Coercive);

Fit_result.D = Fit_obj.D;
Fit_result.p = Fit_obj.p;
Fit_result.Eh = Fit_obj.Eh;
Fit_result.temp = Temp;
Fit_result.coercive = Coercive;
% Fit_result.freq = period;
Fitresults.fit_obj = Fit_obj;

% plot(Temp_out_cut, feval(Fit_obj, Temp_out_cut))
[Fit_result.D, Fit_result.p, Fit_result.Eh]

end

%%
figure
hold on
for freq_N = 8%1:20
    freq_N
    for i = Temp_range
    i

    Loops_loc = Loops{i};
%     Loops_loc = Loops(i);
    
    % HERE USE VERSION CONTROL
    feloop = Loops_loc(freq_N); % OLD CODE
%     feloop_full = Loops_loc(freq_N); % NEW CODE
%     feloop = feloop_full.feloop; % NEW CODE
    
    feloop = feloop_swap_p_n(feloop);
    corrected = feloop_processing(feloop, []);
    
    Span(i, freq_N) = corrected.P.p(end) - corrected.P.p(1);
    Coercive(i, freq_N) = getting_percentile_3(corrected, 0.5);
    
    time = (1:numel(corrected.E.p))/1000; %s

    Pn = corrected.P.n;
    Pn = movmean(Pn, round(numel(Pn)*0.05));
    current_n = diff(Pn)./diff(time);
    current_n(end+1) = current_n(end);

    Pp = corrected.P.p;
    Pp = movmean(Pp, round(numel(Pp)*0.05));
    current_p = diff(Pp)./diff(time);
    current_p(end+1) = current_p(end);

    cla
    plot(corrected.E.n, current_n, '-b')
    plot(corrected.E.p, current_p, '-r')
    drawnow
    pause(0.05);
    end

end


%%
load('OLD_data_2Hz.mat')

freq_N = 1;

range = Loop_temp > 130;
Temp_part = Loop_temp(range);
Coercive_part = Coercive(range, freq_N);


figure
hold on
plot(Temp_part, Coercive_part, '.')
% plot(OLD(:,1), OLD(:,2),'.')
xlabel('T, K')
ylabel('Ec, kV/cm')

p1 =  -3.341e-06;
p2 =    0.002694;
p3 =     -0.7612;
p4 =          79;
x = 20:0.1:300;
y = p1*x.^3 + p2*x.^2 + p3.*x + p4;
% plot(x, y)
% plot(x, 1.3*y)

yline(45)


% figure
% plot(Loop_temp(range), Span(range))
% xlabel('T, K')
% ylabel('Ps, uC/cm^2')






%% vs temp

figure
hold on

for freq_N = 1:8
    
range = Loop_temp > 130;
Temp_part = Loop_temp(range);
Coercive_part = Coercive(range, freq_N);

plot(Temp_part(1:end/2), Coercive_part(1:end/2), '-')
xlabel('T, K')
ylabel('Ec, kV/cm')


end

%% vs period


range = Loop_temp > 130;
Temp_part = Loop_temp(range);
Coercive_part = Coercive(range, :);

range = 1:round(numel(Temp_part)/2);
Coercive_part = Coercive_part(range, :);
Temp_part = Temp_part(range);

figure
% hold on
for temp_N = 1:numel(Temp_part)
    
    periods_loc = periods{1};
    Coercive_loc = Coercive_part(temp_N,:);

    plot(periods_loc, Coercive_loc, '-o')
    xlabel('period, s')
    ylabel('Ec, kV/cm')
    set(gca, 'xscale', 'log')

end


%%

























