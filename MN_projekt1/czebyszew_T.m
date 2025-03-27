function T = czebyszew_T(X, n)
% Ta funkcja służy do implementacji Wielomianu Czebyszewa Pierwszego Rodzadju w MATLABIE
% Funkcja ta zwraca nam macierz T będącą macierzą length(X) x n, gdzie
% X oraz n są argumentami tej funkcji.
% Funkcja ta przyjmuje argument X będącym wektorem poziomym wartości
% argumentów, dla których chcemy mieć policzoną wartość f(X). 
% Drugim argumentem jaki przyjmuje funkcja jest n - jest to liczba mowiaca
% o tym ile kolejnych Wielomianów Czebyszewa p. rodzaju chcemy utworzyć.
% Zwrocona macierz T to macierz, gdzie dla m - tego wiersza i n - tej
% kolumny mamy wartość T_n(x_m).

N = length(X);

T = ones(N, n);

if n > 1
    T(:, 2) = X;

for i = 3:n

    T(:, i) = 2 .*(X') .* T(:, i-1) - T(:, i-2);

end
end
