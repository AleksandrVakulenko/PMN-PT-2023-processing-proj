
function corrected_loop = feloop_processing(feloop, fig)


if ~isempty(fig) && class(fig) == "matlab.ui.Figure" && isvalid(fig)
    Draw = true;
else
    Draw = false;
end

% <<<<<<< HEAD
% FIRST SAMPLE 001
% =======

%TODO: load sample struct from feloop
% >>>>>>> 7fd8134b2430c81a2ade8a9202ea0bfc966ef07d
Sample.h = 85e-6; %m
Sample.s = 0.29/1000^2; %m^2

%SECOND SAMPLE 002
Sample.h = 100e-6; %m
Sample.s = (750e-6)*(1000e-6); %m^2


Einit = feloop.init.E.p;
Pinit = feloop.init.P.p;
Eref = feloop.ref.E.p;
Pref = feloop.ref.P.p;
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

Einit = feloop.init.E.n;
Pinit = feloop.init.P.n;
Eref = feloop.ref.E.n;
Pref = feloop.ref.P.n;
E.n = Einit;
P.n = Pinit - Pref;

if Draw
    plot(Einit, Pinit, '-b')
    plot(Eref, Pref, '-r')
    plot(E.n, P.n, '-g')
    grid on
end

%loop align
Bias = (P.p(end) - P.p(1))/2;
P.p = P.p - Bias;
Bias = (P.n(end) - P.n(1))/2;
P.n = P.n - Bias;


% units E[kV/cm] (was V[V])
E.p = (E.p/1000) / (Sample.h/0.01);
E.n = (E.n/1000) / (Sample.h/0.01);
% units P[uC/cm^2] (was Q[C])
P.p = (P.p*1e6)/(Sample.s*100*100); %P [uC/cm2]
P.n = (P.n*1e6)/(Sample.s*100*100); %P [uC/cm2]

% FIXME: put all misc fields from input loop
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

    ylim([-40 40]) %FIXME: magic constants
    xlim([-50 50])

    xlabel('E, kV/cm', 'fontsize', 12)
    ylabel('P, uC/cm^2', 'fontsize', 12)
    % title(num2str(1/freq_list(i)));
    % end
    drawnow
end

end
