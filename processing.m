

fig = figure('position', [466 129 759 846]);

Coercive = [];
Span = [];
for i = 1:87

Loops_loc = Loops{i};



feloop = Loops_loc(1);

feloop = feloop_swap_p_n(feloop);
corrected = feloop_processing(feloop, true, fig);

Span(i) = corrected.P.p(end) - corrected.P.p(1);

Coercive(i) = getting_percentile_2(corrected, 0.5);
xline(Coercive(i))


title(num2str(Loop_temp(i)))

% pause(0.25)

end



%%

range = Loop_temp > 130;

figure
hold on
plot(Loop_temp(range), Coercive(range), '.')
plot(OLD(:,1), OLD(:,2),'.')
xlabel('T, K')
ylabel('Ec, kV/cm')


figure
plot(Loop_temp(range), Span(range))
xlabel('T, K')
ylabel('Ps, uC/cm^2')










