function [ conto ] = centered_cont( cont, midy )

    %Find dim and center
    minx = min(cont(1,:));
    miny = min(cont(2,:));
    maxx = max(cont(1,:));
    maxy = max(cont(2,:));

    mx = round(sum(cont(1,:)) / size(cont,2));
    my = midy; %round(sum(cont(2,:)) / size(cont,2));
    
    w = max (mx-minx, maxx-mx) * 2 + 1;
    h = max (my-miny, maxy-my) * 2 + 1;
    
    cx = (w+1) / 2;
    cy = (h+1) / 2;
    conto = zeros(h,w);
    for i = 1 : size(cont,2)
        x = cont(1,i) - mx + cx;
        y = cont(2,i) - my + cy;
        conto(y,x) = 1;
    end
    
%     for y = 1 : size(conto,1)
%         x1 = 1;
%         while x1<=size(conto,2) && conto(y,x1)==0
%             x1=x1+1;
%         end
%         x2=size(conto,2);
%         while x2>=1 && conto(y,x2) == 0
%             x2=x2-1;
%         end
%         if x1<x2
%             for x=x1:x2
%                 conto(y,x)=1;
%             end
%         end
%     end
end

