% FIXME: try to delete this functions
function [Loop_temp_cut, switching_cut] = cutting(Loop_temp, switching, Amp, garbage_dots)
%Удаляет точки garbage_dots из массивов. Точки задаются через [] ПО УБЫВАНИЮ!
Loop_temp_cut =  Loop_temp;
switching_cut = switching;
Am = ['Amp_', num2str(Amp)];
for i = garbage_dots
   Loop_temp_cut(i) = [];
   switching_cut.(Am).n(i) = [];
   switching_cut.(Am).p(i) = [];
end

end