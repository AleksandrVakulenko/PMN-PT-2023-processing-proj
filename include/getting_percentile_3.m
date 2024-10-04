% FIXME: refactor
function [Prcn_right, Prcn_left]  = getting_percentile_3(feloop, Prcn)
%На вход прилетает петля и Prcn - процентиль от 0 до 1
%
%
%
if Prcn > 1 || Prcn < 0
    error(' 0 <= Prcn <= 1')
end

E.p = feloop.E.p;
P.p = feloop.P.p;

E.n = -feloop.E.n; %Переворачиваем отрицательную ветвь, чтобы получить верную процентиль
P.n = -feloop.P.n;

% number_of_points = numel(E.p);
% filter_length = round(number_of_points*0.05);
% E.p = movmean(E.p, filter_length);
% P.p = movmean(P.p, filter_length);
% 
% E.n = movmean(E.n, filter_length);
% P.n = movmean(P.n, filter_length);

Prcn_right = aprox(E.p, P.p, Prcn);
Prcn_left = -aprox(E.n, P.n, Prcn);

end

function [out] = aprox(E, P, Prcn)

Min_P = prctile(P, 1); %FIXME: magic constant
P_shift = P - Min_P; %Сдвигаем началом к нуля

Max_P_shift = prctile(P_shift,99); %Находим min и max значения %FIXME: magic constant
Min_P_shift = prctile(P_shift,1); %FIXME: magic constant

y_Prcn = Prcn * (Max_P_shift - Min_P_shift); %y_процентиль
P_shift_down = P_shift - y_Prcn; %Сдвигаем всё вниз, чтобы y_процентиль обнулилась

[~, ind] = min(abs(P_shift_down)); %Находим индекс околонулевого элемента

left_border = ind - 3;            %Отступаем от околонулевого элемента на 3 туда и обратно
right_border = ind + 3;

if left_border < 1              %Проверка условий выхода за границы массива слева и справа
    left_border = 1;
end

if right_border > numel(P_shift_down)
    right_border = numel(P_shift_down);
end

Part_of_loop = P_shift_down(left_border : right_border) ; %Часть точек петли
grid_x1 = E(left_border : right_border); %Сетка для построения апроксимации

fitting_line = polyfit(grid_x1, Part_of_loop, 1); %Фиттинг

out = -fitting_line(2)/fitting_line(1);  %Нахождение нуля 1
end

























