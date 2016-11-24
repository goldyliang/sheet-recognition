function [img_o, T, filled, mx] = fill_flood( img, loc, b, r, limit )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    img_orig = img;
    
    if ~ismember(img ( loc(2), loc(1) ), b) % ~= b
        img_o=img;
        T={};
        filled = 0;
        mx = loc(1);
        if img ( loc(2),loc(1) ) == r
            filled = 1; % IF the pixel already the same as target, 
                        % Then it was filled before, return filled>0
        end
        return
    end
    
    Q = {loc};
    i = 1;
    T = {};
    
    nofill = 0;
    mx = loc(1);
    minx = loc(1);
    maxx = loc(1);
    
  
    while (i <= size(Q,2))
        N = Q{i};
        w = N;
        e = N;
        while ( w(1) > 1 && N(1) - w(1) <= limit && ismember(img( w(2), w(1) -1 ), b) )
            w(1) = w(1) -1;
        end
        if w(1) <=1 || N(1) - w(1) > limit
            nofill = 1;
            break
        end
        
        while ( e(1) <= size(img,2) && e(1) - w(1) <= limit && ismember(img (e(2), e(1) + 1), b))
            e(1) = e(1) + 1;
        end
        if e(1) > size(img,2) || e(1) - w(1) > limit
            nofill = 1;
            break
        end
        
        if w(1) < minx
            minx = w(1);
        end
        if e(1) > maxx
            maxx = e(1);
        end
        
        if e(1) - w(1) > limit
            nofill = 1;
            break;
        end
        
        if (loc(2) == e(2) && e(1) > mx)
            mx = e(1);
        end
        
        for x = w(1) : e(1)
            if ~ ismember(img(N(2),x), b)
                continue
            end
            
            n = [x , N(2)];
            
            T{size(T,2) + 1} = n;
            img (n(2),n(1)) = r;
            
            if (ismember(img (n(2)-1,n(1)), b))
                Q{size(Q,2)+1} = [n(1),n(2)-1];
            end
            if (ismember(img (n(2)+1, n(1)), b))
                Q{size(Q,2)+1} = [n(1),n(2)+1];
            end
        end
        i = i + 1;
    end
    
    if nofill == 1
        img_o = img_orig;
        filled = 0;
    else
        img_o = img;
        filled = size(T,2);
    end

end

