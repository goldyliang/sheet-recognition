function [ contours, img_m, img_marked_m, mid ] = contoursline2( img, imgrgb, c0, c1, H, lw, blank, mid )
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
    %             img(mid(x),x) = 0;img
    %         end
    %     end
        mid(c0(1)) = 0; %c0(2); %round (c0(2) + (1 - c0(1)) / (c1(1)-c0(1)) * (c1(2)-c0(2)));
        last_mid = c0(2);

        %remove the middle line and adjust mid(x)
        err_w = lw; %H / 2; % the possible mid(x) would be mid(x-1)-err_w ~ mid(x-1)+err_w
        
        %ue = c0(1); % the extended upper x until where last flood was attempted
        %de = c0(1);
        ue = W; % disable hole filling
        de = W;
        
        uf = 0; % if 1, then the uppder part is a small hole until ue
        df = 0; % if 1, then the down part is a small hole until ue
                
        limit = H * 0.8;
        
        minLen = round(H * 0.8);
        
        running = zeros(0, 3); % x, y1, y2
        
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
                while m<=m1 && img_m(m,x) > 0
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

                if m>bs && m<=m1 && img_m(m,x)>0 && m-bs < shortest
                    shortest = m-bs;
                    shortest_y=bs;
                end
                m=m+1;
            end

            isline = 0;
            
            if shortest <= lw
                % found a possible line location
                % filter by looking at small filles north and south
                
                if x > ue
                    [img_m, Tu, uf, ue] = fill_flood (img_m, [x shortest_y-1], [1], 2, limit);
                end
                
                if x > de
                    [img_m, Td, df, de] = fill_flood (img_m, [x shortest_y + shortest], [1], 2, limit);
                end                
                                    
                if uf == 0 && df == 0
                    tomark = 1;
                else
                    tomark = 2;
                end
                
                mid(x) = shortest_y + (shortest-1)/2;
                last_mid = med_value ( mid( max(1,x-H):x));
                
                % store the running line first
                nn = size(running,1) + 1;
                running(nn,:) = [x shortest_y shortest_y+shortest-1];
%                 this is a line remove it

%                 for y = shortest_y:shortest_y+shortest-1
%                     img_m(y,x)=tomark;
%                 end
                

            else
                % not a line
                mid(x) = last_mid;
                
                % Remove the last running line if it is long enough
                if size(running,1) > minLen
                    tomark = 1;
                else
                    tomark = 2;
                end
                
                for i = 1 : size(running,1)
                    xx = running(i,1);
                    for y = running(i,2):running(i,3)
                        img_m( y, xx) = tomark;
                    end
                end
                
                % Clear the running line
                running = zeros(0,3);
            end
            

            if (mid(x) > 0)
                img_marked_m (round(mid(x)),x,1) = 0;
                img_marked_m (round(mid(x)),x,2) = 0;
                img_marked_m (round(mid(x)),x,3) = 255;
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
    
    if blank == 0
        % For lines, treat only 0 as black
        asblack=[0];
    else
        % For space, treat 0 and 2 as black. (2 is the lines removed when
        % tracking lines, but want to keep for tracing the blank)
        asblack=[0 2];
    end
    
    if blank == 0
        ch = H;
    else
        ch = H;% - lw;
    end
    [contours, img_m, img_marked_m] = trace_cont(img_m, img_marked_m, mid, ch, asblack );
    %figure; imshow(imgrgb);
    

    
end

