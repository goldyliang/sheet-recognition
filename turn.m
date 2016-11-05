function [ newdir ] = turn( dir, t )
% t = 1, turn left
%  t = -1, turn right
    if t == 1
        if dir == [1 0]
            newdir = [0 -1];
        elseif dir == [0 -1]
            newdir = [-1 0];
        elseif dir == [-1 0];
            newdir = [0 1];
        else
            newdir = [1 0];
        end
    elseif t == -1
        if dir == [1 0]
            newdir = [0 1];
        elseif dir == [0 1]
            newdir = [-1 0];
        elseif dir == [-1 0];
            newdir = [0 -1];
        else
            newdir = [1 0];
        end
    end
end

