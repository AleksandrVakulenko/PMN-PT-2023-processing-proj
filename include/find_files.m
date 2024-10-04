% TODO: add sample filter

function names_out = find_files(folder_name)

% find all *.mat files in folder
content = {dir(folder_name).name};
content(1:2) = [];
names = string(content);


is_mat = strfind(names, ".mat");
is_mat = ~cellfun(@isempty, is_mat);
names = names(is_mat);


% Check presense of Loops field in *.mat

range = false(size(names));
for i = 1:numel(names)
    full_path = [folder_name '/' char(names(i))];
    filename = names(i);
    matObj = matfile(full_path);
    range(i) = isprop(matObj, 'Loops');
    names_out(i).full_path = full_path;
    names_out(i).filename = filename;
end
names_out = names_out(range);


end