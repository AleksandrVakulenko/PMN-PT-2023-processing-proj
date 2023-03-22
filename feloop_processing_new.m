function corrected_loop = feloop_processing_new(feloop, Draw, fig)
%Вычитает второй проход из первого
if Draw
    if isempty(fig)
        figure('position', [466 129 759 846])
    end
end


Sample.h = 85e-6; %m
Sample.s = 0.29/1000^2; %m^2

%Первичная, вторичная и итоговая петли для положительной полупетли
Einit = feloop.feloop.init.E.p;
Pinit = feloop.feloop.init.P.p;
Eref = feloop.feloop.ref.E.p;
Pref = feloop.feloop.ref.P.p;
E.p = Einit;
P.p = Pinit - Pref;

if Draw
    subplot(2,1,1)
    cla
    hold on
    plot(Einit, Pinit, '-b')
    plot(Eref, Pref, '-r')
    plot(E.p, P.p, '-g')
end

%Первичная, вторичная и итоговая петли для отрицательной полупетли
Einit = feloop.feloop.init.E.n;
Pinit = feloop.feloop.init.P.n;
Eref = feloop.feloop.ref.E.n;
Pref = feloop.feloop.ref.P.n;
E.n = Einit;
P.n = Pinit - Pref;

if Draw
    plot(Einit, Pinit, '-b')
    plot(Eref, Pref, '-r')
    plot(E.n, P.n, '-g')
    grid on
end

P.p = P.p - P.p(end)/2; %Нафига????????
P.n = P.n - P.n(end)/2;

% units E (was V)
%Перевод в кВ/см
E.p = (E.p/1000) / (Sample.h/0.01);
E.n = (E.n/1000) / (Sample.h/0.01);

% units P (was Q)
cap = 100e-9; %F
P.p = (P.p*1e6)/(Sample.s*100*100); %P [uC/cm2]
P.n = (P.n*1e6)/(Sample.s*100*100); %P [uC/cm2]

%Привычная структура петли
corrected_loop.E = E;
corrected_loop.P = P;


if Draw
    subplot(2,1,2)
    cla
    hold on
    set(gca, 'fontsize', 11)
    plot(E.p, P.p, 'r', 'linewidth', 2)
    plot(E.n, P.n, 'b', 'linewidth', 2)
    
    grid on
    ylim([-80 80])
    xlim([-55 55])
  

    xlabel('E, kV/cm', 'fontsize', 12)
    ylabel('P, uC/cm^2', 'fontsize', 12)
    % title(num2str(1/freq_list(i)));
    % end
    drawnow
end

end
