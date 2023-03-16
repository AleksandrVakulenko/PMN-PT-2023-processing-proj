function names = find_files(folder_name)

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
    filename = [folder_name '/' char(names(i))];
    matObj = matfile(filename);
    range(i) = isprop(matObj, 'Loops');
    names(i) = filename;
end
names = names(range);


end