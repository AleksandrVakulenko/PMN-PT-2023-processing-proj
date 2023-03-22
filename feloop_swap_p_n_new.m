function feloop = feloop_swap_p_n_new(feloop)

temp = feloop.feloop.init.E.p;
feloop.feloop.init.E.p = feloop.feloop.init.E.n;
feloop.feloop.init.E.n = temp;

temp = feloop.feloop.init.P.p;
feloop.feloop.init.P.p = feloop.feloop.init.P.n;
feloop.feloop.init.P.n = temp;


temp = feloop.feloop.ref.E.p;
feloop.feloop.ref.E.p = feloop.feloop.ref.E.n;
feloop.feloop.ref.E.n = temp;

temp = feloop.feloop.ref.P.p;
feloop.feloop.ref.P.p = feloop.feloop.ref.P.n;
feloop.feloop.ref.P.n = temp;

end