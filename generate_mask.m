function [cont_hist] = generate_mask( contf, learnf, H )

    
    W = round(H * 2);
    if mod(W,2) == 0
        W=W+1;
    end
    cont_hist = zeros (W,W);
    
    for f = 1:size(contf,2)
        contours = read_contours(contf{f});
        
        notes = dlmread(learnf{f});

        ln = 1;

        m = (W+1)/2;

        for i = 1 : 9
            conts = contours{i};

            for j = 1:size(conts,2)
                con = conts{j};

                for k = 1:size(notes,1)
                    if in_contour(con.pts, notes(k,1),notes(k,2))
                        % This contour is marked as note
                        contc = centered_cont (con.pts);
                        dx = (size(contc,2) - 1) / 2;
                        dy = (size(contc,1) - 1) / 2;
                        cont_hist ( m - dy: m + dy, m - dx: m + dx) = cont_hist ( m - dy: m + dy, m - dx: m + dx) + contc;
                        break;
                    end
                end
            end
        end
    end
    
    cont_hist

end

