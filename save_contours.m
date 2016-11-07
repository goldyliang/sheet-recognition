function [ ] = save_contours( g_num, l_num, height, contours, file )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    f = fopen (file, 'a');
    
    for i = 1:size(contours,2)
        fprintf(f,'%d,%d,%d,%d',g_num,l_num,round(contours{i}.mid),height);
        
        for j = 1:size(contours{i}.pts,2)
            fprintf(f,',%d,%d',contours{i}.pts(1,j),contours{i}.pts(2,j));
        end
        
        fprintf(f,'\n');

    end
end

