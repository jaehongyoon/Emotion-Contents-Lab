function [X Y] = trans_cp(data)

Radius  = data(:, 1);
Angle   = data(:, 2);

X       = Radius.*cos(Angle);
Y       = Radius.*sin(Angle);


