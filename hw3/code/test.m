x = categorical([[0, 1, 1] ;[1, 2,3]]);
x(:, 1)
h = histogram(x(1, :));
% hold on
h1 = histogram(x(2, :));