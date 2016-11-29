function [] = classfiy_notes (fcont, fresult,mask1, mask2, th_matched, th_missed, th1_binary, th2_binary)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    %th_binary = 3;
    
    contours = read_contours(fcont);
    
    r = zeros(1,5);
    
    line = 1;
    lns=[1 3 5 7 9 2 4 6 8];
    %lns = [4];

    for i = 1 : size(lns,2)
        ln = lns(i);
        
        
        conts = contours{ln};

        for j = 1:size(conts,2)
            con = conts{j};
            
            if ln==1 && j == 5
                ln=ln
            end
            
            if mod(ln,2) == 1
                mask = mask1;
                th_binary = th1_binary;
            else
                mask = mask2;
                th_binary = th2_binary;
            end
            
            [matched,missed,score, g] = evl_bin_mask (mask,con, th_binary);

            if matched>th_matched && missed<th_missed
                note = 1;
            else
                note = 0;
            end
%             if score > th_score
%                 note = 1;
%             else
%                note = 0;
%            end
            
            r (line,:) = [1 ln matched missed note];
            line = line + 1;
        end
    end
    
    dlmwrite(fresult, r);

end

