
% TODO: add version to feloop struct
%TODO: include sample struct into feloop 

clc
addpath('include\');

fig = figure('position', [443 80 620 685]);

Coercive = [];
Span = [];

for i = 1:87

Loops_loc = Loops{i};



% Temp_range = find(Loop_temp > 100 & Loop_temp < 140);
% Temp_range = 1:87;
Temp_range = 1:numel(Loops);


feloop = Loops_loc(3);

feloop = feloop_swap_p_n(feloop);
corrected = feloop_processing(feloop, fig);

Span(i) = corrected.P.p(end) - corrected.P.p(1);

Coercive(i) = getting_percentile_2(corrected, 0.5);
xline(Coercive(i))


title(num2str(Loop_temp(i)))

% pause(0.25)


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

























