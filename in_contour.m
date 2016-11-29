function [ incont ] = in_contour( pts, x, y )

    max_bias = 1;
    
    minx=min(pts(1,:));
    maxx=max(pts(1,:));
    miny=min(pts(2,:));
    maxy=max(pts(2,:));
    
    incont = 0;
    if x>=minx && x<=maxx && y>=miny && y<=maxy
        
        dx = abs((maxx-x) - (x-minx));
        dy = abs((maxy-y) - (y-miny));
        if dx / (maxx-minx) < max_bias && dy / (maxy-miny) < max_bias
            incont=1;
        end
    end
end

