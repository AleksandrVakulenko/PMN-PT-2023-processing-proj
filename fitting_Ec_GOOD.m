%% FIT WITHOUT 1st freq

clc

model = @(v) model_func(v, Temp_out_cut, Coercive_mean_cut, 'fit');


Lower = [   0    0    0    0    0    0    0  0.1  0.1];
Start = [   1    1    1    1    1    1    1  3.5  3.8];
Upper = [ 200  200  200  200  200  200  200  5.0  5.0];


options = optimoptions('lsqnonlin', ...
    'FiniteDifferenceType','central', ...
    'MaxFunctionEvaluations', 800000, ...
    'FunctionTolerance', 1E-15, ...
    'Algorithm','trust-region-reflective', ... %levenberg-marquardt trust-region-reflective
    'MaxIterations', 5000, ...
    'StepTolerance', 1e-15, ...
    'PlotFcn', '', ... %optimplotresnorm optimplotstepsize OR ''  (for none)
    'Display', 'iter', ... %final off
    'FiniteDifferenceStepSize', 1e-10, ...
    'CheckGradients', true, ...
    'DiffMaxChange', 0.01);

% [vestimated,resnorm,residual,exitflag,output,lambda,jacobian] = lsqnonlin(ModelFunction, Start, Lower, Upper, options);
[vout,resnorm,residual,~,~,~,jacobian] = lsqnonlin(model, Start, Lower, Upper, options);



% гессиан и VarCovar матрица
Hess =jacobian'*jacobian;

DataSize = size(residual,2);
ParSize = size(vout,2);

sigmSqr = (residual*residual')/(DataSize-ParSize);

VarCovar = inv(Hess)*sigmSqr;

for i=1:ParSize
    for j=1:ParSize
        Correl(i,j) = VarCovar(i,j)./(VarCovar(i,i)*VarCovar(j,j))^0.5;
    end
end
imagesc(Correl);


for k=1:7
    error(k) = (full(VarCovar(k,k))).^0.5;
end

vout
error*3 %3 сигма




%% MAIN PLOT

% figure('position', [662.0000  295.5000  498.5000  536.5000])
figure('position', [773.0000  187.5000  498.5000  733.5000])

[~, model_data] = model_func(vout, Temp_out_cut, Coercive_mean_cut, 'fit');

col_array = [0.6350    0.0780    0.1840;
             0.8500    0.3250    0.0980;
             0.9290    0.6940    0.1250;
             0.4660    0.6740    0.1880;
             0.3010    0.7450    0.9330;
             0.0000    0.4470    0.7410;
             0.4940    0.1840    0.5560];

% subplot(2,1,1)
subplot('position', [0.1390    0.4001    0.7750    0.5430])
legend('AutoUpdate', 'off');
hold on
for freq_n = 1:7
    plot(Temp_out_cut(:, freq_n), model_data(:, freq_n), '-', 'color', col_array(freq_n,:), ...
        'linewidth', 1);
end
for freq_n = 1:7
    plot(Temp_out_cut(:, freq_n), Coercive_mean_cut(:, freq_n), '.',...
        'color', col_array(freq_n,:), 'markersize', 10)
end
legend('5 Hz','2 Hz','1 Hz', '0.5 Hz', '0.2 Hz', '0.1 Hz', '0.03 Hz')


xlim([140 270])
ylim([3 23])
set(gca, 'FontSize', 14)
xlabel('T, K', 'FontSize', 18)
ylabel('Ec, kV/cm', 'FontSize', 18)
grid on
box on



subplot('position', [0.1410    0.0838    0.7750    0.2086])
plot(1./Period, vout(1:end-2), '.-', 'markersize', 12, 'linewidth', 1)

xlim([0.03 6])
ylim([55 110])
set(gca, 'xscale', 'log')
set(gca, 'FontSize', 12)
set(gca, 'xtick', [0.05 0.1 0.2 0.5 1 2 5])
xlabel('f, Hz', 'FontSize', 14)
ylabel('Eh, kV/cm', 'FontSize', 14)
grid on
box on


%% MAIN PLOT

% figure('position', [662.0000  295.5000  498.5000  536.5000])
figure

Temp_model = [140:1:380]';
Temp_model = repmat(Temp_model, [1 7]);
[~, model_data] = model_func(vout, Temp_model, Coercive_mean_cut, 'm');

col_array = [0.6350    0.0780    0.1840;
             0.8500    0.3250    0.0980;
             0.9290    0.6940    0.1250;
             0.4660    0.6740    0.1880;
             0.3010    0.7450    0.9330;
             0.0000    0.4470    0.7410;
             0.4940    0.1840    0.5560];

legend('AutoUpdate', 'off');
hold on
for freq_n = 1:7
    plot(Temp_model(:, freq_n), model_data(:, freq_n), '-', 'color', col_array(freq_n,:), ...
        'linewidth', 1);
end
for freq_n = 1:7
    plot(Temp_out_cut(:, freq_n), Coercive_mean_cut(:, freq_n), '.',...
        'color', col_array(freq_n,:), 'markersize', 10)
end
legend('5 Hz','2 Hz','1 Hz', '0.5 Hz', '0.2 Hz', '0.1 Hz', '0.03 Hz')


xlim([140 380])
ylim([3 18.3])
set(gca, 'FontSize', 14)
xlabel('T, K', 'FontSize', 18)
ylabel('Ec, kV/cm', 'FontSize', 18)
grid on
box on




%%

% out = model_func(v, Temp_out_cut, Coercive_mean_cut)

function [out, model] = model_func(v, temp, coercive, cmd)
D = v(end);
p = v(end-1);
Eh = v(1:size(coercive, 2))';
model = (Eh.*(1-temp'/380).^p + D)';
% out = reshape(model, [1 numel(model)]);
if cmd == "m"
    out = 1;
else
    out = (coercive - model);
end
out = reshape(out, [1 numel(out)]);
end






















