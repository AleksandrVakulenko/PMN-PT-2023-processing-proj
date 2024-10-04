

hold on
% plot(Temp, Coercive, '.r')


for freq_N = 1:8

Temp = Temp_out_cut(:, freq_N);
Coercive = Coercive_mean_cut(:, freq_N);


% D Eh p
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Lower = [0 0 1];
opts.StartPoint = [1 40 1];
opts.Upper = [10 100 5];
ft = fittype( 'Eh*(1-x/360)^p + D', 'independent', 'x', 'dependent', 'y' );
Fit_obj = fit(Temp, Coercive, ft, opts);

plot(Fit_obj, Temp, Coercive);


% plot(Temp_out_cut, feval(Fit_obj, Temp_out_cut))
D(freq_N) = Fit_obj.D;
p(freq_N) = Fit_obj.p;
Eh(freq_N) = Fit_obj.Eh;
Freq(freq_N) = 1/Period(freq_N);

end


%%

figure
plot(Freq, D)
set(gca, 'xscale', 'log')

figure
plot(Freq, p)
set(gca, 'xscale', 'log')

figure
plot(Freq, Eh)
set(gca, 'xscale', 'log')









