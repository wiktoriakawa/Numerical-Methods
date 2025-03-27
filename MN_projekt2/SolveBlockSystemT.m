function x = SolveBlockSystemT(A1, A2, A3, A4, A5, b)
%Funkcja przyjmuje jako argumenty A1, A2, A3, A4, A5 oraz b, i rozwiązuje
%układ równań Ax = b stosując metodę thomas_method.

%A jest macierza 
%   -           -
%   | A1 0  0   |
% A = A2 I  0   |
%   | A3 A4 A5  |   
%   -           -
%
%b jest wektorem pionowym
%       -    -
%       | b1 |
% b =   | b2 |
%       | b3 |
%       -    -

p = size(A1, 1);

b1 = b(1:p);
b2 = b(p+1:2*p);
b3 = b(2*p+1:3*p);

x1 = thomas_method(A1, b1);
x2 = b2 - A2*x1;
tmp = b3 - A3*x1 - A4*x2;
x3 = thomas_method(A5, tmp);

x = [x1; x2; x3];

end