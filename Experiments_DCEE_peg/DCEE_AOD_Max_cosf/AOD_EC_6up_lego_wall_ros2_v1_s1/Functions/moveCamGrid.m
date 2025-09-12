function [Xneighbour Yneighbour Zneighbour] = moveCamGrid(pos_row, pos_col, x_coord, y_coord, z_coord)

if  (1 < pos_row) && (pos_row < 11)

        if ( 1 < pos_col ) && ( pos_col < 21 )

            Xneighbour = [x_coord(pos_row+1, pos_col), x_coord(pos_row-1, pos_col), ...
                x_coord(pos_row, pos_col+1), x_coord(pos_row, pos_col-1), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row+1, pos_col), y_coord(pos_row-1, pos_col), ...
                y_coord(pos_row, pos_col+1), y_coord(pos_row, pos_col-1), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row+1, pos_col), z_coord(pos_row-1, pos_col), ...
                z_coord(pos_row, pos_col+1), z_coord(pos_row, pos_col-1), z_coord(pos_row, pos_col)];
        end

        if pos_col ==1

            Xneighbour = [x_coord(pos_row+1, pos_col), x_coord(pos_row-1, pos_col), ...
                x_coord(pos_row, pos_col+1), x_coord(pos_row, 20), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row+1, pos_col), y_coord(pos_row-1, pos_col), ...
                y_coord(pos_row, pos_col+1), y_coord(pos_row, 20), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row+1, pos_col), z_coord(pos_row-1, pos_col), ...
                z_coord(pos_row, pos_col+1), z_coord(pos_row, 20), z_coord(pos_row, pos_col)];
        end

        if pos_col ==21
            Xneighbour = [x_coord(pos_row+1, pos_col), x_coord(pos_row-1, pos_col), ...
                x_coord(pos_row, 2), x_coord(pos_row, pos_col-1), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row+1, pos_col), y_coord(pos_row-1, pos_col), ...
                y_coord(pos_row, 2), y_coord(pos_row, pos_col-1), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row+1, pos_col), z_coord(pos_row-1, pos_col), ...
                z_coord(pos_row, 2), z_coord(pos_row, pos_col-1), z_coord(pos_row, pos_col)];
        end

    elseif pos_row == 1
        if ( 1 < pos_col ) && ( pos_col < 21 )

            Xneighbour = [x_coord(pos_row+1, pos_col), x_coord(pos_row, pos_col), ...
                x_coord(pos_row, pos_col+1), x_coord(pos_row, pos_col-1), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row+1, pos_col), y_coord(pos_row, pos_col), ...
                y_coord(pos_row, pos_col+1), y_coord(pos_row, pos_col-1), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row+1, pos_col), z_coord(pos_row, pos_col), ...
                z_coord(pos_row, pos_col+1), z_coord(pos_row, pos_col-1), z_coord(pos_row, pos_col)];
        end

        if pos_col ==1

            Xneighbour = [x_coord(pos_row+1, pos_col), x_coord(pos_row, pos_col), ...
                x_coord(pos_row, pos_col+1), x_coord(pos_row, 20), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row+1, pos_col), y_coord(pos_row, pos_col), ...
                y_coord(pos_row, pos_col+1), y_coord(pos_row, 20), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row+1, pos_col), z_coord(pos_row, pos_col), ...
                z_coord(pos_row, pos_col+1), z_coord(pos_row, 20), z_coord(pos_row, pos_col)];
        end

        if pos_col ==21
            Xneighbour = [x_coord(pos_row+1, pos_col), x_coord(pos_row, pos_col), ...
                x_coord(pos_row, 2), x_coord(pos_row, pos_col-1), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row+1, pos_col), y_coord(pos_row, pos_col), ...
                y_coord(pos_row, 2), y_coord(pos_row, pos_col-1), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row+1, pos_col), z_coord(pos_row, pos_col), ...
                z_coord(pos_row, 2), z_coord(pos_row, pos_col-1), z_coord(pos_row, pos_col)];
        end

    elseif pos_row == 11
        if ( 1 < pos_col ) && ( pos_col < 21 )

            Xneighbour = [x_coord(pos_row, pos_col), x_coord(pos_row-1, pos_col), ...
                x_coord(pos_row, pos_col+1), x_coord(pos_row, pos_col-1), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row, pos_col), y_coord(pos_row-1, pos_col), ...
                y_coord(pos_row, pos_col+1), y_coord(pos_row, pos_col-1), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row, pos_col), z_coord(pos_row-1, pos_col), ...
                z_coord(pos_row, pos_col+1), z_coord(pos_row, pos_col-1), z_coord(pos_row, pos_col)];
        end

        if pos_col ==1

            Xneighbour = [x_coord(pos_row, pos_col), x_coord(pos_row-1, pos_col), ...
                x_coord(pos_row, pos_col+1), x_coord(pos_row, 20), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row, pos_col), y_coord(pos_row-1, pos_col), ...
                y_coord(pos_row, pos_col+1), y_coord(pos_row, 20), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row, pos_col), z_coord(pos_row-1, pos_col), ...
                z_coord(pos_row, pos_col+1), z_coord(pos_row, 20), z_coord(pos_row, pos_col)];
        end

        if pos_col ==21
            Xneighbour = [x_coord(pos_row, pos_col), x_coord(pos_row-1, pos_col), ...
                x_coord(pos_row, 2), x_coord(pos_row, pos_col-1), x_coord(pos_row, pos_col)];
            Yneighbour = [y_coord(pos_row, pos_col), y_coord(pos_row-1, pos_col), ...
                y_coord(pos_row, 2), y_coord(pos_row, pos_col-1), y_coord(pos_row, pos_col)];
            Zneighbour = [z_coord(pos_row, pos_col), z_coord(pos_row-1, pos_col), ...
                z_coord(pos_row, 2), z_coord(pos_row, pos_col-1), z_coord(pos_row, pos_col)];
        end

    end

end