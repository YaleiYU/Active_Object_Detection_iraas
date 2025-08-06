function [pos_row pos_col] = updateCamGrid(pos_row, pos_col, ind)

if ind == 1
        if  (1 <= pos_row) && (pos_row < 11)
            pos_row = pos_row +1;
        elseif pos_row == 11
            pos_row = pos_row;
        end
    end

    if ind == 2

        if  (1 < pos_row) && (pos_row <= 11)
            pos_row = pos_row -1;
        elseif pos_row == 1
            pos_row = pos_row;
        end

    end

    if ind == 3
        if  (1 <= pos_col) && (pos_col < 20)
            pos_col = pos_col +1;
        elseif pos_col == 20
            pos_col = pos_col;
        end
    end

    if ind == 4
        if  (1 < pos_col) && (pos_col <= 20)
            pos_col = pos_col -1;
        elseif pos_col == 1
            pos_col = pos_col;
        end
    end

end