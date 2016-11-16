function m = med_value( v )

    v1 = sort (v (:));
    
    i = 1;
    while v(i) == 0
        i = i +1;
    end
    
    m = v1( round( (i + size(v1,1)) / 2));

end

