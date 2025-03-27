function Y = eval_poly(X, A)
% funkcja ta zwraca nam macierz Y o wymiarach length(A) x 1, gdzie A jest
% argumentem przyjmowanym przez daną funkcję.Argument A to wektor pionowy,
% którego wartości są współczynnikami dla danego k = 0, 1, 2, ..., length(A)
% dla funckji danej w treści zadania. X to natomiast punkty z naszego
% podziału przedziału całkowania.
% Podana funkcja zwraca nam macierz Y, gdzie dla m - tego wiersza
% otrzymujemy w_n(x_m).

n = length(A);

Y = czebyszew_U(X, n) .* czebyszew_T(X, n) * A;

end
