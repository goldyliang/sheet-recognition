function [ output_args ] = contours_line( line_img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    img=imread(line_img);
    W = size(img,1);
    H = size(img,2);
    M = H / 2;
    ca = zeros(W);
    cb = zeros(W);
    
    for (x=1:W)
        ca(x) = 0;
        cb(x) = 0;
        for (y=1:M)
            if (img(x,y) == 0)
                ca(x) = M - y;
                break
            end
        end
        
        for (y=H:M)
            if (img(x,y) == 0)
                cb(x) = y - M;
            end
        end
    end
    
    figure;
    subplot(2,1,1); plot(ca);
    subplot(2,1,2); plot(cb);
end

