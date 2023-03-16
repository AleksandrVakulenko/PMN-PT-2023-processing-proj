

function output = PT1000(arg, unit)
R0 = 1000;
A = 3.9083e-3;
B = -5.7750e-7;

switch unit
    case "R2K"
        R_temp = arg;
        temp_out = (-R0*A + (R0^2*A^2 - 4*R0*B*(R0-R_temp)).^0.5)/(2*R0*B);
        output = temp_out + 273.15;
    case "R2C"
        R_temp = arg;
        temp_out = (-R0*A + (R0^2*A^2 - 4*R0*B*(R0-R_temp)).^0.5)/(2*R0*B);
        output = temp_out;
    case "K2R"
        temp_in = arg - 273.15;
        R_temp = R0*(1 + A*temp_in + B*temp_in.^2);
        output = R_temp;
    case "C2R"
        temp_in = arg;
        R_temp = R0*(1 + A*temp_in + B*temp_in.^2);
        output = R_temp;
    otherwise
        error('wrong unit value')

end

end
