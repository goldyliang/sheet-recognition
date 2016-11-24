function [ conto ] = centered_cont( cont )

    %Find dim and center
    minx = min(cont(1,:));
    miny = min(cont(2,:));
    maxx = max(cont(1,:));
    maxy = max(cont(2,:));

    mx = round(sum(cont(1,:)) / size(cont,2));
    my = round(sum(cont(2,:)) / size(cont,2));
    
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
end

