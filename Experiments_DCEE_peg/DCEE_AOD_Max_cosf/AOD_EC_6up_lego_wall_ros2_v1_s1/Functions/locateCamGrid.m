function   [Xneighbour Yneighbour Zneighbour pos_row pos_col] = locateCamGrid(pos, x_coord, y_coord, z_coord, Xneighbour, Yneighbour, Zneighbour, pos_row_store, pos_col_store)


% find out the location of the current position of camera
pos_x = pos.x;
pos_y = pos.y;


pos_x = round(pos_x, 4);
pos_y = round(pos_y, 4);


tolerance_coord = 1e-4;

[posx_row, posx_col ] = find(abs(x_coord - pos_x) < tolerance_coord);
[posy_row, posy_col ] = find(abs(y_coord - pos_y) < tolerance_coord);


leng_posx = length(posx_row);
leng_posy = length(posy_row);


for ii=1:leng_posx
    for j = 1: leng_posy
        if posx_row(ii)==posy_row(j)
            if  posx_col(ii) == posy_col(j)
                pos_row = posx_row(ii);
                pos_col = posx_col(ii);
            end
        end
    end
end


pos_row_store = [pos_row_store; pos_row];
pos_col_store = [pos_col_store; pos_col];


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