function [ cont,  img_m, img_marked_m ] = trace_cont( img, img_marked, mid, H, lw ,ud )
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
    img_marked_m = img_marked;
    %end
    
    img_m = img;
    
    cur=[1 mid(1)];
    
    while cur(1)<=size(img,2) && img(cur(2),cur(1)) == 1
        cur=[cur(1)+1 mid(cur(1))];
    end
    
    cont = zeros(2,0);
    
    d = [1 0];
    
    while ( cur(1) <= size(img,2) )
        ub = mid(cur(1)) - H/2;
        lb = mid(cur(1)) + H/2;
        
        if cur(2) > ub && cur(2) < lb && img(cur(2),cur(1)) == 0
            % add the point, and turn away from middle
            % If x is going to negative, keep original dir
            cont(: , size(cont,2)+1) = transpose(cur);
            img_marked_m(cur(2),cur(1),:) = [255 0 0];
            
            if (ud<0)
                d1 = turn (d, 1);
            else
                d1 = turn (d, -1);
            end
            
            if d1(1) >= 0
                d = d1;
            end
        else
            % turn to the middle. 
            % If x is going to out-of-bound, keep original dir
            if (ud < 0)
                d1 = turn (d,-1);
            else
                d1 = turn (d,1);
            end
            
            if d1(1) >=0
                d = d1;
            end
        end
        cur = cur + d;
        
        if (ud<0 && cur(2) > lb || ud>0 && cur(2) < ub)
            %the end of current contour, find next
            cur(1) = cur(1) + 1;
            while (cur(1) <= size(img,2) && img(mid(cur(1)),cur(1)) == 1)
                cur(1) = cur(1) + 1;
            end
            if (cur(1)<=size(img,2))
                cur(2) = mid(cur(1));
            end
        end
    end
    
end

