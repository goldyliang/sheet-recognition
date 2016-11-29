function [mask,notes_scores,nonnotes_scores] = generate_mask( contf, learnf, H, lines )

    
    W = round(H * 2);
    if mod(W,2) == 0
        W=W+1;
    end
    cont_hist = zeros (W,W);
    
    for f = 1:size(contf,2)
        contours = read_contours(contf{f});
        
        notes = dlmread(learnf{f});

        m = (W+1)/2;

        for ii = 1 : size(lines,2)
            i = lines(ii);
            conts = contours{i};

            for j = 1:size(conts,2)
                con = conts{j};

                for k = 1:size(notes,1)
                    if i==4 && j == 6
                        j=j
                    end
                    if notes(k,1) == i && in_contour(con.pts, notes(k,2),notes(k,3))
                        % This contour is marked as note
                        [f i j notes(k,2) notes(k,3) ]
                        contc = centered_cont (con.pts, con.mid);
                        dx = (size(contc,2) - 1) / 2;
                        dy = (size(contc,1) - 1) / 2;
                        [j k]
                        contc
                        cont_hist ( m - dy: m + dy, m - dx: m + dx) = cont_hist ( m - dy: m + dy, m - dx: m + dx) + contc;
                        break;
                    end
                end
            end
        end
    end
    
    mask = cont_hist;% > 5;
    
    h = fspecial('average',3);
    mask = imfilter(mask,h);
    
    th = ( max(mask(:)) - min(mask(:)) ) / 2;
    
    notes_score=zeros(1,4);
    nonnotes_score=zeros(1,4);
    
    n1=1;n2=1;
    
    for f = 1:size(contf,2)
        contours = read_contours(contf{f});
        
        notes = dlmread(learnf{f});

        for ii = 1 : size(lines,2)
            i = lines(ii);
            conts = contours{i};

            for j = 1:size(conts,2)
                con = conts{j};
                
                if i==4 && j == 9
                    i=i
                end
                [matched,missed,score, g] = evl_bin_mask (mask,con, th);
                
                in = 0;
                for k = 1:size(notes,1)
                    if notes(k,1) == i && in_contour(con.pts, notes(k,2),notes(k,3))
                        % This contour is marked as note
                        notes_scores(n1,:)=[f i j notes(k,2) notes(k,3) matched missed score];
                        n1=n1+1;
                        in = 1;
                        break
                    end
                end
                                
                if in == 0
                    nonnotes_scores(n2,:)=[f i j con.pts(1,1) con.pts(2,1) matched missed score];
                    n2=n2+1;
                end
            end
        end
    end
    
    contours = read_contours(contf{1});
    con = contours{1}{12};
    
    [matched,missed,score, g] = evl_bin_mask (mask,con,10);
    
    notes_scores
    nonnotes_scores

end

