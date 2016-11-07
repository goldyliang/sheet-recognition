function [ contours, img_m, img_marked_m, mid ] = contoursline2( img, imgrgb, c0, c1, H, lw, thn, blank )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    
    W = size(img,2);
%     ca = zeros(1,W); ca(:) = 1000000;
%     cb = zeros(1,W); cb(:) = -1000000;
    img_marked_m = imgrgb;
    img_m=img;
    
    mid = zeros(W,1);
%     for x=1:W
%         mid(x) = round (c0(2) + (x - c0(1)) / (c1(1)-c0(1)) * (c1(2)-c0(2)));
%         if blank > 0
%             img(mid(x),x) = 0;
%         end
%     end
    mid(c0(1)) = c0(2); %round (c0(2) + (1 - c0(1)) / (c1(1)-c0(1)) * (c1(2)-c0(2)));
    
    %remove the middle line and adjust mid(x)
    err_w = lw/3; % the possible mid(x) would be mid(x-1)-err_w ~ mid(x-1)+err_w
    for x=c0(1)+1:c1(1)
        
        m0 = floor(mid(x-1)-err_w-lw/2);
        m1 = ceil(mid(x-1)+err_w+lw/2);
        
        %find the shortest continous black with (x, m0-m1)
        
        m=m0;
        shortest=100000;
        while (m<=m1)
            %find next white
            while m<=m1 && img_m(m,x) == 0
                m=m+1;
            end
            
            if m>m1
                break;
            end
            
            %find next black
            while m<=m1 && img_m(m,x) == 1
                m=m+1;
            end
            if m>m1
                break;
            end
            
            
            %find continours black
            bs=m;
            while m<=m1 && img_m(m,x) == 0
                m=m+1;
            end
            
            if m>bs && m<=m1 && img_m(m,x)==1 && m-bs < shortest
                shortest = m-bs;
                shortest_y=bs;
            end
            m=m+1;
        end
        
        if shortest <= lw
            mid(x) = round(shortest_y + shortest/2);
            for y = shortest_y:shortest_y+shortest-1
                img_m(y,x)=1;
            end
        else
            mid(x)=mid(x-1);
        end
        
%         img_m(mid(x),x) = 0;
%         y1 = mid(x);
%         while img_m(y1,x) == 0 && mid(x) - y1 <= lw / 2
%             y1 = y1 -1;
%         end
%         y2 = mid(x);
%         while img_m(y2,x) == 0 && y2 - mid(x) <= lw /2
%             y2 = y2 + 1;
%         end
%         
%         if mid(x) - y1 <= lw / 2 && y2 - mid(x) <= lw / 2
%             for y = y1:y2
%                 img_m(y,x)=1;
%                 %img_marked_m(y,x,:)=[255 255 255];
%             end
%         end
    end
    
    %imwrite(img_m, 't.bmp');
    
    % Find the first black
%     c = c0;
%     while (c(1) < W)
%         c(1) = c(1) + 1;
%         c(2) = mid(c(1));
%         if (img(c(2),c(1)) == 0)
%             break;
%         end
%     end
    
    [contours, img_m, img_marked_m] = trace_cont(img_m, img_marked_m, mid, H);
    %figure; imshow(imgrgb);
    

    
end

