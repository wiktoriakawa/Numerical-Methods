function x =   SolveBlockSystemCH(A1, A2, A3, A4, A5, b)
    % Rozwiązanie układu Ax = b, gdzie
    % A = [A1, 0,  0 ;
    %      A2, I,  0 ;
    %      A3, A4, A5];
    % A1, A5: trójdiagonalne, symetryczne, dodatnio określone
    % b: wektor prawej strony
    %Funkcja przyjmuje jako argumenty A1, A2, A3, A4, A5 oraz b, zwraca x.
    
    % Rozmiary macierzy i wektora b
    p = size(A1, 1);

    % Rozdzielenie wektora b na bloki
    b1 = b(1:p);
    b2 = b(p+1:2*p);
    b3 = b(2*p+1:3*p);

    
    % Rozwiązanie A1 * x1 = b1 
    x1 = cholesky_decomposition(A1, b1);
    
    %  Rozwiązanie x2 = b2 - A2 * x1
    x2 = b2 - A2 * x1;
    
    % Krok 3: Rozwiązanie A5 * x3 = b3 - A3 * x1 - A4 * x2 
    rhs = b3 - A3 * x1 - A4 * x2; % Prawa strona dla x3
    x3 = cholesky_decomposition(A5, rhs);
    % Połączenie wyników w x
    x = [x1; x2; x3];
end
