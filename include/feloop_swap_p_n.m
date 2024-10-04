function feloop = feloop_swap_p_n(feloop)

temp = feloop.init.E.p;
feloop.init.E.p = feloop.init.E.n;
feloop.init.E.n = temp;

temp = feloop.init.P.p;
feloop.init.P.p = feloop.init.P.n;
feloop.init.P.n = temp;


temp = feloop.ref.E.p;
feloop.ref.E.p = feloop.ref.E.n;
feloop.ref.E.n = temp;

temp = feloop.ref.P.p;
feloop.ref.P.p = feloop.ref.P.n;
feloop.ref.P.n = temp;

end
