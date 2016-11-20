function [ m ] = mark_group_notes( imgrgbf, imgrgbfout, contours, outf )

    oo = dlmread(outf);
    
    ln = 1;
    
    imgrgb = imread (imgrgbf);
    
    for i = 1 : 2: 9
        conts = contours{i};
        
        for j = 1:size(conts,2)
            con = conts{j};
            if oo(ln,5) == 1
                imgrgb = mark_note(imgrgb, con);
            end
            ln = ln + 1;
        end
    end
    
    for i = 2:2:8
        conts = contours{i};
        for j = 1:size(conts,2)
            con = conts{j};
            if oo(ln,5) == 1
                imgrgb = mark_note(imgrgb,con);
            end
            ln = ln + 1;
        end
    end
    
    imwrite (imgrgb, imgrgbfout);

end

