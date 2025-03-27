rng(42); % Stałe "ziarno" generatora losowego

% Liczba testów
num_tests = 7;
p = 5; % Rozmiar bloku (można modyfikować)
cond_A_values = zeros(num_tests, 1);
e_rel_ch_values = zeros(num_tests, 1);
e_rel_t_values = zeros(num_tests, 1);
wsp_stab_ch_values = zeros(num_tests, 1);
wsp_stab_t_values = zeros(num_tests, 1);
wsp_popr_ch_values = zeros(num_tests, 1);
wsp_popr_t_values = zeros(num_tests, 1);
x_ch_values = cell(num_tests, 1);
x_t_values = cell(num_tests, 1);
x_exact_values = cell(num_tests, 1);
time_ch_values = zeros(num_tests, 1); % Czas działania SolveBlockSystemCH
time_t_values = zeros(num_tests, 1); % Czas działania SolveBlockSystemT

for test_num = 1:num_tests
    fprintf('Test %d/%d\n', test_num, num_tests);

    % Generowanie macierzy blokowych i wektora b
    switch test_num
        case 1
            % Przypadek: Symetryczna, dodatnio określona macierz o niskiej kondycji
            A1 = gallery('tridiag', p, 1, 4, 1);
            A5 = gallery('tridiag', p, 1, 3, 1);
            A2 = rand(p, p) * 0.1;
            A3 = rand(p, p) * 0.1;
            A4 = rand(p, p) * 0.1;
        case 2
            % Przypadek: Macierz o dużej kondycji
            A1 = gallery('tridiag', p, 1, 1e3, 1);
            A5 = gallery('tridiag', p, 2, 1e3, 2);
            A2 = rand(p, p) * 0.5;
            A3 = rand(p, p) * 0.5;
            A4 = rand(p, p) * 0.5;
        case 3
            % Przypadek: Macierz z perturbacją (bliskie liczby)
            perturbation = 1e-5;
            A1 = diag(4 * ones(p, 1)) + diag(-1 * ones(p-1, 1), 1) + diag(-1 * ones(p-1, 1), -1);
            A1 = A1 + perturbation * eye(p);
            A5 = diag(5 * ones(p, 1)) + diag(-2 * ones(p-1, 1), 1) + diag(-2 * ones(p-1, 1), -1);
            A5 = A5 + perturbation * eye(p);
            A2 = rand(p, p) * 0.2;
            A3 = rand(p, p) * 0.2;
            A4 = rand(p, p) * 0.2;
        case 4
            % Przypadek: Układ o bardzo małych wartościach
            A1 = gallery('tridiag', p, 1e-5, 1e-4, 1e-5);
            A5 = gallery('tridiag', p, 1e-5, 1e-3, 1e-5);
            A2 = rand(p, p) * 1e-6;
            A3 = rand(p, p) * 1e-6;
            A4 = rand(p, p) * 1e-6;
        case 5
            % Przypadek: Układ z macierzami rzadkimi
            A1 = gallery('poisson', p);
            A5 = gallery('poisson', p);
            A1 = sparse(A1(1:p, 1:p));
            A5 = sparse(A5(1:p, 1:p));
            A2 = sparse(rand(p, p) * 0.01);
            A3 = sparse(rand(p, p) * 0.01);
            A4 = sparse(rand(p, p) * 0.01);
        case 6
            % Przypadek: Układ o dużym bloku
            p = 10; % Zwiększenie rozmiaru bloku
            A1 = gallery('tridiag', p, 1, 2, 1);
            A5 = gallery('tridiag', p, 2, 4, 2);
            A2 = rand(p, p) * 0.1;
            A3 = rand(p, p) * 0.1;
            A4 = rand(p, p) * 0.1;
            
        case 7
            % Przypadek: Bardzo duża macierz
            p = 500; % Duży rozmiar bloku
            A1 = gallery('tridiag', p, 1, 2, 1);
            A5 = gallery('tridiag', p, 2, 4, 2);
            A2 = rand(p, p) * 0.1;
            A3 = rand(p, p) * 0.1;
            A4 = rand(p, p) * 0.1;
    end
    b = rand(3 * p, 1);

    % Tworzenie macierzy pełnej
    A_full = [A1, zeros(p, p), zeros(p, p); ...
              A2, eye(p), zeros(p, p); ...
              A3, A4, A5];

    % Upewnienie się, że macierz pełna ma odpowiednie wymiary
    A_full_dense = full(A_full);
    x_exact = A_full_dense \ b;

    % Rozwiązanie za pomocą SolveBlockSystemCH
    tic;
    x_ch = SolveBlockSystemCH(A1, A2, A3, A4, A5, b);
    time_ch = toc;

    % Rozwiązanie za pomocą SolveBlockSystemT
    tic;
    x_t = SolveBlockSystemT(A1, A2, A3, A4, A5, b);
    time_t = toc;

    % Obliczanie wskaźników
    cond_A = cond(A_full_dense);
    e_rel_ch = norm(x_ch - x_exact) / norm(x_exact);
    e_rel_t = norm(x_t - x_exact) / norm(x_exact);
    wsp_stab_ch = e_rel_ch / cond_A;
    wsp_stab_t = e_rel_t / cond_A;
    wsp_popr_ch = norm(b - A_full_dense * x_ch) / (norm(A_full_dense) * norm(x_ch));
    wsp_popr_t = norm(b - A_full_dense * x_t) / (norm(A_full_dense) * norm(x_t));

    % Zapis wyników
    cond_A_values(test_num) = cond_A;
    e_rel_ch_values(test_num) = e_rel_ch;
    e_rel_t_values(test_num) = e_rel_t;
    wsp_stab_ch_values(test_num) = wsp_stab_ch;
    wsp_stab_t_values(test_num) = wsp_stab_t;
    wsp_popr_ch_values(test_num) = wsp_popr_ch;
    wsp_popr_t_values(test_num) = wsp_popr_t;
    x_ch_values{test_num} = x_ch;
    x_t_values{test_num} = x_t;
    x_exact_values{test_num} = x_exact;
    time_ch_values(test_num) = time_ch;
    time_t_values(test_num) = time_t;

    % Wyświetlanie wyników dla danego testu
    fprintf('\nWyniki dla testu %d:\n', test_num);
    disp('x_ch:');
    disp(x_ch);
    disp('x_t:');
    disp(x_t);
    disp('x_exact:');
    disp(x_exact);
    fprintf('Czas działania SolveBlockSystemCH: %.6f s\n', time_ch);
    fprintf('Czas działania SolveBlockSystemT: %.6f s\n', time_t);
end

% Tabela z wynikami
T = table((1:num_tests)', cond_A_values, e_rel_ch_values, e_rel_t_values, wsp_stab_ch_values, wsp_stab_t_values, wsp_popr_ch_values, wsp_popr_t_values, time_ch_values, time_t_values, ...
    'VariableNames', {'TestNumber', 'Cond_A', 'ErrorRel_CH', 'ErrorRel_T', 'WspStab_CH', 'WspStab_T', 'WspPopr_CH', 'WspPopr_T', 'Time_CH', 'Time_T'});

% Wyświetlanie tabeli
fprintf('\n-- Miary dokładności, stabilności, poprawności oraz czasy działania --\n');
disp(T);

% Wykresy
figure;

subplot(2, 2, 1);
plot(1:num_tests, e_rel_ch_values, '-o', 'DisplayName', 'ErrorRel_CH');
hold on;
plot(1:num_tests, e_rel_t_values, '-x', 'DisplayName', 'ErrorRel_T');
xlabel('Test Number');
ylabel('Relative Error');
title('Błąd względny');
legend;

subplot(2, 2, 2);
plot(1:num_tests, wsp_stab_ch_values, '-o', 'DisplayName', 'WspStab_CH');
hold on;
plot(1:num_tests, wsp_stab_t_values, '-x', 'DisplayName', 'WspStab_T');
xlabel('Test Number');
ylabel('Stability Index');
title('Wskaźnik stabilności');
legend;

subplot(2, 2, 3);
plot(1:num_tests, time_ch_values, '-o', 'DisplayName', 'Time_CH');
hold on;
plot(1:num_tests, time_t_values, '-x', 'DisplayName', 'Time_T');
xlabel('Test Number');
ylabel('Time (s)');
title('Czas działania');
legend;

subplot(2, 2, 4);
plot(1:num_tests, wsp_popr_ch_values, '-o', 'DisplayName', 'WspPopr_CH');
hold on;
plot(1:num_tests, wsp_popr_t_values, '-x', 'DisplayName', 'WspPopr_T');
xlabel('Test Number');
ylabel('Correctness Index');
title('Wskaźnik poprawności');
legend;

% Tabela w nowej figurze
figure;
uitable('Data', T{:,:}, ...
        'ColumnName', T.Properties.VariableNames, ...
        'RowName', arrayfun(@num2str, (1:num_tests)', 'UniformOutput', false), ...
        'Units', 'normalized', ... % Normalizacja jednostek w obrębie figury
        'Position', [0 0 1 1]); % Tabela zajmuje całą przestrzeń figury
