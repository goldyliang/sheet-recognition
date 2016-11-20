function [ lines ] = findlines( projection,height )
lines = [];
i = 1;
maxvalue = max(projection);
window_size = height*8;
while i<1192-window_size
    if projection(i)>(maxvalue*0.75)
        temp = projection(i:i+window_size);
        [num,position] = sort(temp,'descend');
        line = position(1:5);
        if (max(line)-min(line))<(4*height*1.1)
            lines = [lines line+i-1];
            i = i+window_size;
            continue
        end
    else
        i = i+1;
        continue
    end
    i = i+1;
end
end

