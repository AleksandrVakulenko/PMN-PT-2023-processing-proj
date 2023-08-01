
function corrected_loop = feloop_processing(feloop, fig)


if ~isempty(fig) && class(fig) == "matlab.ui.Figure" && isvalid(fig)
    Draw = true;
else
    Draw = false;
end


% FIRST SAMPLE 001

%TODO: load sample struct from feloop

Sample.h = 85e-6; %m
Sample.s = 0.29/1000^2; %m^2


%SECOND SAMPLE 002
Sample.h = 100e-6; %m
Sample.s = (750e-6)*(1000e-6); %m^2


%SAMPLE PMN-20PT summer 2023 105um!!!!!!!!!!!!!!!!
Sample.h = 105e-6; %m
Sample.s = pi*(430e-6)^2; %m^2



%Первичная, вторичная и итоговая петли для положительной полупетли

Einit = feloop.init.E.p;
Pinit = feloop.init.P.p;
Eref = feloop.ref.E.p;
Pref = feloop.ref.P.p;
E.p = Einit;
P.p = Pinit - Pref;

LW_init = 2;
LW_ref = 1;
if Draw
    subplot(2,1,1)
    cla
    hold on
    plot(Einit, Pinit, '-b', 'linewidth', LW_init)
    plot(E.p, P.p, '-r', 'linewidth', LW_init)
    plot(Eref, Pref, '-k', 'linewidth', LW_ref)
    xlabel('v, V', 'fontsize', 12)
    ylabel('q, C', 'fontsize', 12)
    legend({'init', 'final', 'ref'}, 'location', 'northwest', 'AutoUpdate', 'off')
end

%Первичная, вторичная и итоговая петли для отрицательной полупетли
Einit = feloop.init.E.n;
Pinit = feloop.init.P.n;
Eref = feloop.ref.E.n;
Pref = feloop.ref.P.n;
E.n = Einit;
P.n = Pinit - Pref;

if Draw
    plot(Einit, Pinit, '-b', 'linewidth', LW_init)
    plot(E.n, P.n, '-r', 'linewidth', LW_init)
    plot(Eref, Pref, '-k', 'linewidth', LW_ref)
    grid on
end


%loop align
Bias = (P.p(end) - P.p(1))/2;
P.p = P.p - Bias;
Bias = (P.n(end) - P.n(1))/2;
P.n = P.n - Bias;

% units E[kV/cm] (was V[V])


% units E (was V)
% Перевод в кВ/см

E.p = (E.p/1000) / (Sample.h/0.01);
E.n = (E.n/1000) / (Sample.h/0.01);
% units P[uC/cm^2] (was Q[C])
P.p = (P.p*1e6)/(Sample.s*100*100); %P [uC/cm2]
P.n = (P.n*1e6)/(Sample.s*100*100); %P [uC/cm2]

% filtering
number_of_points = numel(E.p);
% filter_length = round(number_of_points*0.002);
filter_length = 20;
E.p = movmean(E.p, filter_length);
P.p = movmean(P.p, filter_length);
E.n = movmean(E.n, filter_length);
P.n = movmean(P.n, filter_length);

% FIXME: put all misc fields from input loop
% Привычная структура петли
corrected_loop.E = E;
corrected_loop.P = P;
% [n, p] = getting_percentile_3(corrected_loop, 0.5);


if Draw
    subplot(2,1,2)
    cla
    hold on
    set(gca, 'fontsize', 11)

    P.p(end+1) = P.p(end);
    E.p(end+1) = 0;
    P.n(end+1) = P.n(end);
    E.n(end+1) = 0;

    plot(E.p, P.p, '.r', 'linewidth', 2)
    plot(E.n, P.n, '.b', 'linewidth', 2)
    grid on
    
    x_lim = ceil(max(abs([E.p E.n])/10))*10;

    ylim([-30 30]) %FIXME: magic constants
    xlim([-x_lim x_lim])


    xlabel('E, kV/cm', 'fontsize', 12)
    ylabel('P, uC/cm^2', 'fontsize', 12)
    % title(num2str(1/freq_list(i)));
    % end
    drawnow
end

end
