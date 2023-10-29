% FIXME: try to delete this function
function switch_temp_dependce(Loop_temp, switching, Amp, n)
subplot(2,2,n);
hold on
xlim([130 300])
tit = ['Amp = ', num2str(Amp)];
title(tit)

if Amp == 450
    name = 'Amp_450';
elseif Amp == 400
    name = 'Amp_400';
elseif Amp == 350
    name = 'Amp_350';
elseif Amp == 300
    name = 'Amp_300';
end
    
plot(Loop_temp, abs(switching.(name).p), '-or', 'linewidth', 2, 'markersize', 4)
plot(Loop_temp, abs(switching.(name).n), '-ob', 'linewidth', 2, 'markersize', 4)
xlabel('T, K')
ylabel('Prtcn, kV/cm')
end