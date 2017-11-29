function data_array = Data_sorting(au_selected, path)

% initialize data_array
data_array = [];

% get all files in file directory
file_dir    = dir(path);
file_length = size(file_dir, 1);

% start from 3rd one as first and second are . and .. which means
% previous/present directories

for i = 3:file_length
    
    % read file name
    current_file = file_dir(i).name;
    
    % get catagory (norm or centroid) of file
    file_parts = regexp(current_file, '_', 'split');
    if(size(file_parts,2) == 2)
        au       = file_parts(1);
        catagory = file_parts(2);
    else
        au       = file_parts;
        catagory = file_parts;
    end
    
    % if file stores norm data achieve the data
    if(strcmp(catagory, 'norm')&& strcmp(au_selected, au))
        file_loc = strcat(path, '\', current_file);
        data_array = load(file_loc);
        break;
    end
    
end
end