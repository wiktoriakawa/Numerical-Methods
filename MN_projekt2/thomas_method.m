function x = thomas_method(A, b)
    % Funkcja ta przyjmuje jako argument macierz A oraz b, wyznacza
    % rozwiązanie równania Ax = b stosując algorytm Thomasa.

    if ~is_tridiagonal(A)
        error('Macierz musi być trójdiagonalna!');
    end

    % Pobierz rozmiar macierzy
    n = length(b);

    gamma = zeros(n, 1);
    beta = zeros(n, 1);

    % Wektory macierzy trójdiagonalnej
    c = [diag(A, 1); 0];   % Nadprzekątna
    a = [0; diag(A, -1)];  % Podprzekątna
    d = diag(A);           % Przekątna główna


    % Faza eliminacji wprzód
    for i = 1:n
        denom = d(i) + a(i) * gamma(i);
        gamma(i+1) = -c(i) / denom;
        beta(i+1) = (b(i) - a(i) * beta(i)) / denom;
    end

    % Przygotowanie rozwiązania
    x = zeros(n, 1);

    % Faza eliminacji wstecz
    x(n) = beta(n+1);
    for i = n-1:-1:1
        x(i) = gamma(i+1) * x(i+1) + beta(i+1);
    end
end

