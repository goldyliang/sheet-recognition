function [ contours, img_m, img_marked_m, mid ] = contoursline2( img, imgrgb, c0, c1, H, lw, thn, blank, mid )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    
    W = size(img,2);
%     ca = zeros(1,W); ca(:) = 1000000;
%     cb = zeros(1,W); cb(:) = -1000000;
    img_marked_m = imgrgb;
    img_m=img;
    
    %For notes on lines get the mid from the line and remove the line
    %otherwise, the mid is passed in
    if blank == 0
        mid = zeros(W,1);
    %     for x=1:W
    %         mid(x) = round (c0(2) + (x - c0(1)) / (c1(1)-c0(1)) * (c1(2)-c0(2)));
    %         if blank > 0
    %             img(mid(x),x) = 0;
    %         end
    %     end
        mid(c0(1)) = 0; %c0(2); %round (c0(2) + (1 - c0(1)) / (c1(1)-c0(1)) * (c1(2)-c0(2)));
        last_mid = c0(2);

        %remove the middle line and adjust mid(x)
        err_w = H / 2; % the possible mid(x) would be mid(x-1)-err_w ~ mid(x-1)+err_w
        
        ue = c0(1); % the extended upper x until where last flood was attempted
        de = c0(1);
        
        limit = H * 0.8;
        
        for x=c0(1)+1:c1(1)
            
            if x == 314
                x=x;
            end

            m0 = floor(last_mid - err_w-lw/2);
            m1 = ceil(last_mid + err_w+lw/2);

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

            isline = 0;
            
            if shortest <= lw
                % found a possible line location
                % filter by looking at small filles north and south
                
                if (x > max(ue,de))
                    % find small fills north and south
                    [img_m, Tu, f1, ue] = fill_flood (img_m, [x shortest_y-1], 1, 0, limit);
                    
                    [img_m, Td, f2, de] = fill_flood (img_m, [x shortest_y + shortest], 1, 0, limit);
                    
                    if f1 == 0 && f2 == 0
                        isline = 1;
                    else
                        isline = 0;
                    end
                else
                    isline = 1;
                end
            end
            
            if isline == 1
                % this is a line, remove the line
                mid(x) = round(shortest_y + shortest/2);
                last_mid = med_value ( mid( max(1,x-H):x));
                for y = shortest_y:shortest_y+shortest-1
                    img_m(y,x)=1;
                end
            else
                % not a line
                mid(x)= last_mid; %mid(x-1);      
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

