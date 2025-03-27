function U = czebyszew_U(X, n)
% Ta funkcja służy do implementacji Wielomianu Czebyszewa Drugiego Rodzaju w MATLABIE
% Funkcja ta zwraca nam macierz U będącą macierzą length(X) x n, gdzie
% X oraz n są argumentami tej funkcji.
% Funkcja ta przyjmuje argument X będącym wektorem poziomym wartości
% argumentów, dla których chcemy mieć policzoną wartość f(X). 
% Drugim argumentem jaki przyjmuje funkcja jest n - jest to liczba mowiaca
% o tym ile kolejnych Wielomianów Czebyszewa d. rodzaju chcemy utworzyć.
% Zwrocona macierz U to macierz, gdzie dla m - tego wiersza i n - tej
% kolumny mamy wartość U_n(x_m).

N = length(X);

U = ones(N, n);

if n > 1
    U(:, 2) = 2 .* X;

for i = 3:n

    U(:, i) = 2 .* (X') .* U(:, i-1) - U(:, i-2);

end

end
