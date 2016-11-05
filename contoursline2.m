function [ img_m, img_marked_m ] = contoursline2( img, imgrgb, c0, c1, H, lw, thn, blank )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    W = size(img,2);
    ca = zeros(1,W);
    cb = zeros(1,W);
    img_marked_m = imgrgb;
    img_m=img;
    
    mid = zeros(W,1);
    for x=1:W
        mid(x) = round (c0(2) + (x - c0(1)) / (c1(1)-c0(1)) * (c1(2)-c0(2)));
        if blank > 0
            img(mid(x),x) = 0;
        end
    end
    
    c = c0;
    while (c(1) < W)
        c(1) = c(1) + 1;
        c(2) = mid(c(1));
        if (img(c(2),c(1)) == 0)
            break;
        end
    end
    
    [cont_up, img_m, img_marked_m] = trace_cont(img_m, img_marked_m, mid, H, lw, -1);
    [cont_dn, img_m, img_marked_m] = trace_cont(img_m, img_marked_m, mid, H, lw, 1);
    %figure; imshow(imgrgb);
    
    
    for i=1:size(cont_up,2)
        x = cont_up(1,i);
        y = cont_up(2,i);
        ca(x) = mid(x) - y;
    end
    
    for i=1:size(cont_dn,2)
        x = cont_dn(1,i);
        y = cont_dn(2,i);
        cb(x) = mid(x) - y;
    end
    
    %remove the middle line
    %and get all contours except of middle line as a output pattern
    for x=1:W
        if ca(x) < lw/2 && cb(x) > -lw/2
            for dy = -ca(x):1:-cb(x)
                y=mid(x) + dy;
                img_m(y,x)=1;
                img_marked_m(y,x,:)=[255 255 255];
            end
        end
    end
    
    wsize = lw;
    b = 1/wsize * ones (1,wsize);
    
    %ca = filter( b, 1 , ca);
    %cb = filter( b, 1 , cb);
    %ca = medfilt1(ca, fn);
    %cb = medfilt1(cb, fn);
    
    dt = zeros(W);
    for (x=1:W)
        if (ca(x) >= H/thn && cb(x) <= -H/thn)
            dt(x) = 1;
        end
    end
    
    %dt = medfilt1(dt,fn);
    
end

