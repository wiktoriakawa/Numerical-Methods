function flag = is_tridiagonal(A)
    % Funkcja sprawdza, czy macierz jest trójdiagonalna
    [n, m] = size(A);
    if n ~= m
        flag = false;
        return;
    end

    % Macierz trójdiagonalna ma zerowe elementy poza główną, pod- i nadprzekątną
    for i = 1:n
        for j = 1:m
            if abs(i - j) > 1 && A(i, j) ~= 0
                flag = false;
                return;
            end
        end
    end

    flag = true;
end