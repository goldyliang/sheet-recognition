function [ output_args ] = contoursline( line_img, lw, fn, thn, odd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    img=im2bw(rgb2gray(imread(line_img)));
    W = size(img,2);
    H = size(img,1);
    M = H / 2;
    ca = zeros(W);
    cb = zeros(W);
    
    if odd == 1
        sublw = lw;
    else
        sublw = 0;
    end
    
    for x=1:W
        ca(x) = 0;
        cb(x) = 0;
        for y=max(1,sublw):M
            if (img(y,x) == 0)
                ca(x) = M - y;
                break
            end
        end
        
        for y=H-max(0,sublw):-1:M
            if (img(y,x) == 0)
                cb(x) = M - y;
                break
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
    
    dt = medfilt1(dt,fn);
    
    figure;
    subplot(4,1,1); plot(ca);xlim([1,W]);ylim( [0,10]);
    subplot(4,1,2); plot(cb);xlim([1,W]);ylim( [-10,0]);
    subplot(4,1,3); plot(dt);xlim([1,W]);ylim ([0,2]);
    subplot(4,1,4); imshow(img);
end

