function [img_o, T, filled, mx] = fill_flood( img, loc, b, r, limit )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    img_orig = img;
    
    if img ( loc(2), loc(1) ) ~= b
        img_o=img;
        T={};
        filled = 0;
        mx = loc(1);
        return
    end
    
    Q = {loc};
    i = 1;
    T = {};
    
    filled = 0;
    mx = loc(1);
    minx = loc(1);
    maxx = loc(1);
   
    while (i <= size(Q,2))
        N = Q{i};
        w = N;
        e = N;
        while ( w(1) > 1 && img( w(2), w(1) -1 ) == b )
            w(1) = w(1) -1;
        end
        while ( e(1) < size(img,2) && img (e(2), e(1) + 1) == b)
            e(1) = e(1) + 1;
        end
        for x = w(1) : e(1)
            if img(N(2),x) ~= b
                continue
            end
            
            n = [x , N(2)];
            
            T{size(T,2) + 1} = n;
            img (n(2),n(1)) = r;
            
            if (loc(2) == n(2) && n(1) > mx)
                mx = n(1);
            end
            
            if (n(1) > maxx)
                maxx = n(1);
            end
            if (n(1) < minx)
                minx = n(1);
            end
            
            if (maxx - minx > limit)
                img_o = img_orig;
                filled = 0;
                return;
            end
            
            if (img (n(2)-1,n(1)) == b)
                Q{size(Q,2)+1} = [n(1),n(2)-1];
            end
            if (img (n(2)+1, n(1)) == b)
                Q{size(Q,2)+1} = [n(1),n(2)+1];
            end
        end
        i = i + 1;
    end
    

    img_o = img;
    filled = size(T,2);

end

