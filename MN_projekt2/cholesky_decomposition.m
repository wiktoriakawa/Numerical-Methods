function x = cholesky_decomposition(A, b)
    % Funkcja ta przyjmuje jako argumenty macierz A oraz wektor b, stosuje
    % ona rozkład Choleskiego, zwraca x z układu równań Ax = b
    
    if size(A, 1) ~= size(A, 2)
        error('Macierz A musi być kwadratowa.');
    end
    if ~isequal(size(A, 1), length(b))
        error('Wektor b musi mieć zgodną liczbę elementów z wymiarami A.');
    end
    
    % Rozkład Choleskiego (macierz dolnotrójkątna)
    L = chol(A, 'lower');
    
    % Rozwiązanie układu Ly = b (eliminacja w przód)
    y = L \ b;
    
    % Rozwiązanie układu L'x = y (eliminacja wstecz)
    x = L' \ y;
end

