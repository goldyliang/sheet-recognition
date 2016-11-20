function [length,window_size] = Reference_Lengths( image )
counter = 0;
height = size(image,1);
length = size(image,2);
count_list = [];
for x = 1:length
    for y = 1:height-1
        counter = counter +1;
        if image(y,x)~=image(y+1,x)
            count_list = [count_list counter];
            counter = 0;
        end
        if y+1 == height
            if counter == 0;
                count_list = [count_list 1];
            else
                count_list = [count_list counter+1];
            end
        end
    end
    counter = 0;
end
consecutive_pair = [];
list_length = size(count_list,2);
for i = 1:list_length-1
    consecutive_pair = [consecutive_pair count_list(i)+count_list(i+1)];
end
length = mode(consecutive_pair);
window_size = length * 4*2;
end

