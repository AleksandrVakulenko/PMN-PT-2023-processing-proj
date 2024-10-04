
clc

v = [1 2 3 4 5 6 7 8 9 0];





%%

clc

model = @(v) model_func(v, Temp_out_cut, Coercive_mean_cut);


Lower = [  0     1     0    0    0    0    0    0    0    0 ];
Start = [  1     2     1    1    1    1    1    1    1    1 ];
Upper = [ 10     5   100  100  100  100  100  100  100  100 ];


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


for k=1:10
    error(k) = (full(VarCovar(k,k))).^0.5;
end

vout
error*3 %3 сигма




%%


[~, model_data] = model_func(vout, Temp_out_cut, Coercive_mean_cut);

hold on
for freq_n = 1:8

plot(Temp_out_cut, model_data(:, freq_n), '-b')
plot(Temp_out_cut, Coercive_mean_cut(:, freq_n), '.r')

end






%%

% out = model_func(v, Temp_out_cut, Coercive_mean_cut)

function [out, model] = model_func(v, temp, coercive)
D = repmat(v(1), [8 1]);
p = repmat(v(2), [8 1]);
Eh = v(3:10)';
model = (Eh.*(1-temp'/360).^p + D)';
% out = reshape(model, [1 numel(model)]);
out = (coercive - model);
out = reshape(out, [1 numel(out)]);
end






















