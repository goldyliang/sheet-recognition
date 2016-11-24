function [ incont ] = in_contour( pts, x, y )

    minx=min(pts(1,:));
    maxx=max(pts(1,:));
    miny=min(pts(2,:));
    maxy=max(pts(2,:));
    
    if x>=minx && x<=maxx && y>=miny && y<=maxy
        incont=1;
    else
        incont=0;
    end
end

