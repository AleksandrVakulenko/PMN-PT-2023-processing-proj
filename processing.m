

fig = figure('position', [466 129 759 846]);


switching = struct();
Prtc_10 = [];
Prtc_90 = [];
Span = [];
frequency = 10; %10, 3, 1, 0.5 Проверять соответствие в цикле с j!
fr_60 = (1:4);
fr_10 = (5:8);
fr_3 = (9:12);
fr_1 = (13:16);
fr_05 = (17:20);

for i = 1:37
    
for j = fr_60

Loops_loc = Loops{i};
feloop = Loops_loc(j);

name = strcat('Amp_', num2str(Loops_loc(j).amp), '%d');
fieldname = sprintf(name);

feloop = feloop_swap_p_n_new(feloop);
corrected = feloop_processing_new(feloop, true, fig);

% Span(i) = corrected.P.p(end) - corrected.P.p(1);

%Создаём поля структуры динамически для каждой амплитуды
[switching.(fieldname).n(i), switching.(fieldname).p(i)] = getting_percentile_3(corrected, 0.5); 
% [Prtc_10.n(i), Prtc_10.p(i) ] = getting_percentile_3(corrected, 0.1);
% [Prtc_90.n(i), Prtc_90.p(i) ] = getting_percentile_3(corrected, 0.9);
end

% xline(Coercive.n(i));
% xline(Coercive.p(i));

drawnow
title(num2str(Loop_temp(i)))

% pause(0.25)

end


%%
figure
hold on

if frequency == 60
% Loop_temp_cut = Loop_temp;
% Loop_temp_cut(32) = [];
% Loop_temp_cut(22) = [];
% 
% switching_cut = switching;
% switching_cut.Amp_300.n(32) = [];
% switching_cut.Amp_300.p(32) = [];
% 
% switching_cut.Amp_300.n(22) = [];
% switching_cut.Amp_300.p(22) = [];
end 

if frequency == 60
    [Loop_temp_cut1, switching_cut1] = cutting(Loop_temp, switching, 300, [32, 22]);
    [Loop_temp_cut2, switching_cut2] = cutting(Loop_temp, switching, 400, 2);
    switch_temp_dependce(Loop_temp, switching, 450, 1)
    switch_temp_dependce(Loop_temp_cut2, switching_cut2, 400, 2)
    switch_temp_dependce(Loop_temp, switching, 350, 3)
    switch_temp_dependce(Loop_temp_cut1, switching_cut1, 300, 4)
end

% if frequency == 10
%     [Loop_temp_cut, switching_cut] = cutting(Loop_temp, switching, 300, []);
% end

% if frequency == 3
%     [Loop_temp_cut, switching_cut] = cutting(Loop_temp, switching, 300, []);
% end

% if frequency == 05
%     [Loop_temp_cut, switching_cut] = cutting(Loop_temp, switching, 300, []);
% end

    switch_temp_dependce(Loop_temp, switching, 450, 1)
    switch_temp_dependce(Loop_temp, switching, 400, 2)
    switch_temp_dependce(Loop_temp, switching, 350, 3)
    switch_temp_dependce(Loop_temp, switching, 300, 4)





% figure
% plot(Loop_temp(range), Span(range))
% xlabel('T, K')
% ylabel('Ps, uC/cm^2')










