function [contours] = read_contours( file )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    contours=cell(0);
    m = dlmread(file);
    
    for i = 1:size(m,1)
        
        l_num = m(i,2);
        cont = zeros(2,1);
        k = 1;
        for j = 5 : 2 : size(m,2)
            if (m(i,j)>0 && m(i,j+1)>0)
                cont (1,k) = m(i,j);
                cont (2,k) = m(i,j+1);
            end
            k= k+1;
        end
        if l_num > size(contours,2)
            contours{l_num} = cell(0);
        end
        contours{l_num}{size(contours{l_num},2)+1} = struct('mid', m(i,3), 'pts', cont);
    end
end

