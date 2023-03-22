

fig = figure('position', [466 129 759 846]);

Coercive = [];
Prtc_10 = [];
Prtc_90 = [];
Span = [];
for i = 1:87

Loops_loc = Loops{i};


feloop = Loops_loc(1);

feloop = feloop_swap_p_n_new(feloop);
corrected = feloop_processing_new(feloop, true, fig);

% Span(i) = corrected.P.p(end) - corrected.P.p(1);

[Coercive.n(i), Coercive.p(i)] = getting_percentile_3(corrected, 0.5);
[Prtc_10.n(i), Prtc_10.p(i) ] = getting_percentile_3(corrected, 0.1);
[Prtc_90.n(i), Prtc_90.p(i) ] = getting_percentile_3(corrected, 0.8);

% xline(Coercive.n(i));
% xline(Coercive.p(i));
xline(Prtc_90.n(i))
drawnow
title(num2str(Loop_temp(i)))

% pause(0.25)

end


%%

range = Loop_temp > 130;

figure
hold on
% plot(Loop_temp(range), Coercive.n, '.')
plot(Loop_temp, abs(Coercive.p), '-or', 'linewidth', 2, 'markersize', 4)
plot(Loop_temp, abs(Prtc_10.p), '-or', 'linewidth', 2, 'markersize', 4)
plot(Loop_temp, abs(Prtc_90.p), '-og', 'linewidth', 2, 'markersize', 4)

plot(Loop_temp, abs(Coercive.n), '-ob', 'linewidth', 2, 'markersize', 4)
plot(Loop_temp, abs(Prtc_10.n), '-ob', 'linewidth', 2, 'markersize', 4)
plot(Loop_temp, abs(Prtc_90.n), '-ok', 'linewidth', 2, 'markersize', 4)
xlim([130 300])
ylim([0 40])
% plot(OLD(:,1), OLD(:,2),'.')
xlabel('T, K')
ylabel('Ec, kV/cm')


% figure
% plot(Loop_temp(range), Span(range))
% xlabel('T, K')
% ylabel('Ps, uC/cm^2')










