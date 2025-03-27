% test zrobimy dla funkcji, ktore jestesmy w stanie wyznaczyc w sposób
% dosyc prosty w wolframie, czyli dla raczej małych n 

int1 = integral(@(x) 3, 1, 2, 'ArrayValued', true);

A1 = [3];
trap11 =trap_method(A1, 1, 2, 1);
trap12= trap_method(A1, 1, 2, 10);
trap13 = trap_method(A1, 1, 2, 100);

exact_val1 = 3;

blad_integral1 = abs(exact_val1 - integral(@(x) 3, 1, 2, 'ArrayValued', true));

blad_trap_11 = abs(exact_val1 - trap_method(A1, 1, 2, 1));
blad_trap_12 = abs(exact_val1 - trap_method(A1, 1, 2, 10));
blad_trap_13 = abs(exact_val1 - trap_method(A1, 1, 2, 100));


%
int2 = integral(@(x) 2*x.^2 + 1, 1, 2, 'ArrayValued', true);
A2 = [1; 1];
trap21 = trap_method(A2, 1, 2, 1);
trap22 = trap_method(A2, 1, 2, 10);
trap23 = trap_method(A2, 1, 2, 100);
exact_val2 = 17/3; 

blad_integral2 = abs(exact_val2 - integral(@(x) 2*x.^2 + 1, 1, 2, 'ArrayValued', true));
blad_trap_21 = abs(exact_val2 - trap_method(A2, 1, 2, 1));
blad_trap_22 = abs(exact_val2 - trap_method(A2, 1, 2, 10));
blad_trap_23 = abs(exact_val2 - trap_method(A2, 1, 2, 100));

trap24 = trap_method(A2, 1, 2, 9999999);
blad_trap_24 = abs(exact_val2 - trap_method(A2, 1, 2, 9999999));

%zeby otrzymac calke z x^2 mozemy zrobic 
A3 = [0 ; 0.5];
int31 = integral(@(x) x.^2 , 1, 2, 'ArrayValued', true);
exact_val31 = 7/3;
trap31 = trap_method(A3, 1, 2, 100);
blad_integral31 = abs(exact_val31 - integral(@(x) x.^2 , 1, 2, 'ArrayValued', true));
blad_trap_31 = abs(exact_val31- trap_method(A2, 1, 2, 100));

int32 = integral(@(x) x.^2 , -1, 1, 'ArrayValued', true);
exact_val32 = 2/3;
trap32 = trap_method(A3, -1, 1, 100);
blad_integral32 = abs(exact_val32 - integral(@(x) x.^2 , -1, 1, 'ArrayValued', true));
blad_trap_32 = abs(exact_val32- trap_method(A2, -1, 1, 100));

%
A4 = [0; 0; 1];
int4 = integral(@(x) 8*x.^4 - 6*x.^2 + 1 , -1, 1, 'ArrayValued', true);
trap4 = trap_method(A4, -1, 1, 100);
exact_val4 = 1.2 ;
blad_integral4 = abs(exact_val4 - integral(@(x) 8*x.^4 - 6*x.^2 + 1 , -1, 1, 'ArrayValued', true));
blad_trap_4 = abs(exact_val4 - trap_method(A3, -1, 1, 100));


%Tworzenie tabeli
funkcja_1 = "3";
funkcja_2 = "2x^2 + 1";
funkcja_3 = "x^2";
funkcja_4 = "8x^4 - 6x^2 +1";
f_val = [funkcja_1, funkcja_1, funkcja_1, funkcja_2 ,funkcja_2, funkcja_2, funkcja_2, funkcja_3, funkcja_3, funkcja_4];

p1 = "a = 1, b = 2";
p2 = "a = -1, b = 1";
p_val = [p1, p1, p1, p1, p1, p1, p1 ,p1, p2, p2];

n1 = 1;
n2 = 10;
n3 = 100;
n4 = 9999999;
n_val = [n1, n2, n3, n1, n2, n3, n4, n3, n3, n3];

exact_val = [exact_val1, exact_val1, exact_val1, exact_val2, exact_val2, exact_val2, exact_val2, exact_val31, exact_val32, exact_val4];

int_val = [int1, int1, int1, int2, int2, int2,int2, int31, int32, int4];
trap_val = [trap11, trap12, trap13, trap21, trap22, trap23,trap24, trap31, trap32, trap4];

blad_int = [blad_integral1, blad_integral1, blad_integral1, blad_integral2, blad_integral2, blad_integral2, blad_integral2, blad_integral31, blad_integral32, blad_integral4];
blad_trap = [blad_trap_11, blad_trap_12, blad_trap_13, blad_trap_21, blad_trap_22, blad_trap_23, blad_trap_24, blad_trap_31, blad_trap_32, blad_trap_4];

T = table(f_val', p_val', n_val', exact_val', int_val', trap_val', blad_int', blad_trap', ...
    'VariableNames',{'Funkcja', 'Przedzial', 'LiczbaPrzedzialow', 'DokWartCalki', 'FIntegral', 'FTrap', 'BladInt', 'BladTrap'})
