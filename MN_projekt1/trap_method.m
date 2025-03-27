function calka = trap_method(A, a, b, N)
% funkcja ta przyjmuje argumenty A - wspolczynniki funkcji, A jest pionowym
% wektorem; a, b - odpowiednio początek oraz koniec przedziału całkowania
% naszej funkcji. N - liczba podpodziałow naszego przedziału całkowania.
% Podana funkcja zwraca przybliżoną wartość całki liczoną za pomocą metody
% trapezów.

h = (b - a)/N;

X = a:h:b;

Y = eval_poly(X, A);

calka = h * (sum(Y) - (Y(1) + Y(N+1))/2) ;

end

