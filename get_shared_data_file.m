function file = get_shared_data_file()
% Interactively send a message to ANSWER using memmapfile class.
 
filename = fullfile('cummunication.dat');
 
% Create the communications file if it is not already there.
if ~exist(filename, 'file')
    [f, msg] = fopen(filename, 'wb');
    if f ~= -1
        fwrite(f, zeros(1,256), 'double');
        fclose(f);
    else
        error('MATLAB:demo:send:cannotOpenFile', ...
              'Cannot open file "%s": %s.', filename, msg);
    end
end
 
% Memory map the file.
file = memmapfile(filename, 'Writable', true, 'Format', 'double');
end
