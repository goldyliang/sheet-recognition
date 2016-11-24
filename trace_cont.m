function [ contours,  img_m, img_marked_m ] = trace_cont( img, img_marked, mid, H, asblack)
%ud = -1 (up)
%ud = 1 (down)

   % if img_marked == zeros(0,0)
   %     img_marked_m = uint8(zeros(size(img,1),size(img,2),3));
   %     for y=1:size(img,1)
   %         for x = 1:size(img,2)
   %             if img(y,x) == 1
   %                 img_marked_m(y,x,:)=[255 255 255];
   %             end
   %         end
   %     end
    %else
    contours=cell(0);
    img_marked_m = img_marked;
    %end
    W=size(img,2);
    img_m = img;
    
    cur=[1 mid(1)];
    
    while cur(1)<=W && cur(2) == 0
        cur(1)=cur(1)+1;
        cur(2)=mid(cur(1));
    end
    
    ex = W;
    while mid(ex)==0
        ex = ex -1;
    end
    
    
    while (cur(1) <= ex && mid(cur(1))>0 )
        
        % Find the start of a contour
        while cur(1) <= ex && ~ ismember(img(round(mid(cur(1))),cur(1)), asblack)
            cur(1) = cur(1) + 1;
        end
        
        if cur(1)> ex
            break
        end
        
        if mid(cur(1))==0
            break
        end
        
        if (cur(1)<=ex)
            cur(2) = round(mid(cur(1)));
        else
            break
        end
        
        cross_x = cur(1);  % largest crossing to x
        cont = zeros(2,0);
        %cont(:,1)=transpose(cur);
        d = [1 0];
        orig=cur;
        d_orig = d; %[0 1];
        %cur = cur + d;

        %while ~ isequal(transpose(cur),cont(:,1)) % || ~ isequal(d,d_orig)
        ub = round(mid(cur(1)) - H/2 );
        lb = round(mid(cur(1)) + H/2);
        
        while 1
            %ub = round(mid(cur(1)) - H/2 );
            %lb = round(mid(cur(1)) + H/2);

            if cur(2) > ub && cur(2) < lb && ismember(img(cur(2),cur(1)), asblack)
                % add the point, and turn left
                cont(: , size(cont,2)+1) = transpose(cur);
                if cur(2) == round(mid(cur(1))) && cur(1) > cross_x
                    cross_x = cur(1);
                end

                img_marked_m(cur(2),cur(1),:) = [255 0 0];

                d = turn (d, 1);
            else
                % turn right 
                d = turn (d,-1);
            end

            cur = cur + d;
            
            if isequal(cur,orig) && isequal(d,d_orig)
                break
            end

        end
        
        mid_cont_y = (mid(cont(1,1)) + mid(cross_x)) / 2;
        contours {size(contours,2)+1} = struct('mid', round(mid_cont_y), 'pts', cont);
    
        cur(1) = cross_x + 1;

    end
    
end

