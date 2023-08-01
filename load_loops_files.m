addpath('include\')


folder_name = 'Output_results_14-Mar-2023_18_23_37';
% folder_name = 'Output_results_20-Mar-2023_14_44_33';

names = find_files(folder_name);



time = [];
temp = [];
heater = [];
res = [];
% set_point = [];
periods = {};
Loops = {};
Loop_temp = [];

for file_n = 1:numel(names)
    disp(['Loading file ' num2str(file_n) '/' num2str(numel(names))]);

    matObj = matfile(names(file_n));

    periods{file_n} = 1./matObj.freq_list;
    Loops{file_n} = matObj.Loops;
%     temp_setpoint = matObj.temp_actual;

    % append temp graph
    temp_graph = matObj.temp_graph;
    time = [time temp_graph.time];
    temp = [temp temp_graph.temp];
    heater = [heater temp_graph.heater];
    res = [res temp_graph.res];
%     set_point = [set_point repmat(temp_setpoint, size(temp_graph.time))];
    
    temp_by_res = PT1000(res, 'R2K');
    Loop_temp(file_n) = temp_by_res(end);
end

clearvars file_n temp_setpoint temp_graph matObj
clearvars names folder_name


%%

clc

figure
hold on
% plot(time, set_point, '-')
plot(time, temp, '-')
plot(time, heater, '-')

figure
plot(time, res, '-')

figure
hold on
plot(time, res, 'b-')
plot(time, PT1000(temp, 'K2R'), '-r')

figure
hold on
plot(time, temp, '-r')
plot(time, PT1000(res, 'R2K'), '-b')



%%

clc
clearvars time temp heater res set_point temp_by_res

%%





























