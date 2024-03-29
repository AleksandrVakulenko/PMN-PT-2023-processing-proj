% FIXME: refactor
% FIXME: derivative-noise problem
%Создаёт данные для токовых петель(берёт производную)
function [Current] = current_from_charge(feloop) 

E = feloop.E.p(1:end/2);
P = feloop.P.p(1:end/2);


time = (1:numel(E))/1000;



Current.I = diff(P)./diff(time);
Current.I(end+1) = Current.I(end);
Current.E.p = E; %Только E.p
Current.P.p = P; %Только P.p
Current.time = time;

%FIXME: do smooth on current values

figure
hold on
plot(E, P)
plot(E, Current.I)
pause(10)



end 