function feloop = loop_pulses_filter(feloop)

feloop.init.E.n = loop_d_filt(feloop.init.E.n);
feloop.init.E.p = loop_d_filt(feloop.init.E.p);
feloop.init.P.n = loop_d_filt(feloop.init.P.n);
feloop.init.P.p = loop_d_filt(feloop.init.P.p);
feloop.ref.E.n = loop_d_filt(feloop.ref.E.n);
feloop.ref.E.p = loop_d_filt(feloop.ref.E.p);
feloop.ref.P.n = loop_d_filt(feloop.ref.P.n);
feloop.ref.P.p = loop_d_filt(feloop.ref.P.p);

end

function x = loop_d_filt(x)


% number_of_points = numel(x);
% filter_length = round(number_of_points*0.05); BAD
% x_f = movmean(x, filter_length);


value = 6*mean(abs(diff(x)));
% range = abs( diff( x_f ) ) > value;
range = abs( diff( x ) ) > value;
% plot(diff(x_f))

% numel(find(range));

dx = diff(x);

% error('asfd')
dx_f = medfilt1(diff(x), 5);
dx(range) = dx_f(range);

x_new = cumsum(dx);

x_new = x_new + x(1);
x_new(2:end+1) = x_new(1:end);
x_new(1) = x(1);

x = x_new;

end