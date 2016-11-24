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
            val= sort(line,'descend')
            flag = true;
            for l = 1:4
                if ((val(l)-val(l+1))<8)||((val(l)-val(l+1))>10)
                    val(l)
                    val(l+1)
                    projection(val(l+1)+i-1) = 0;
                    %delete = find(temp == val(l+1))
                    flag = false;
                    break
                end   
            end
            if flag == false
                continue
            end
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
