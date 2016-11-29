function [ matched, missed, score, g ] = evl_bin_mask( mask, cont, th )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    ct = centered_cont(cont.pts, cont.mid);

    mx = (size(ct,2)+1)/2;
    my = (size(ct,1)+1)/2;
    cx = (size(mask,2) + 1) / 2;
    cy = (size(mask,1) + 1) / 2;
    
    g = uint8(mask);
    
    matched = 0;
    missed = 0;
    score = 0;
    for dx = 1 : size(ct,2)
        for dy = 1 : size(ct,1)
            if ct(dy,dx) > 0
                x = dx - mx + cx;
                y = dy - my + cy;
                if x>0 && x<=size(mask,2) && y>0 && y<=size(mask,1)
                    g(y,x)=2;
                    if mask(y,x) > th
                        matched = matched+1;
                    else
                        missed = missed + 1;
                    end
                    score = score + mask(y,x);
                else
                    missed = missed + 1;
                end
            end
        end
    end
    
    return

end

