function yy = naturalspline(x, y, xx)

%lungimea lui x
n = length(x);

%initializare vectori de lungime n - 1
h = zeros(1, n - 1);
b = zeros(1, n - 1);

%in h retin diferenta elementelor din x, iar in b derivatele in fiecare punct din h
for i = 1 : n - 1
    h(i) = x(i + 1) - x(i);
    b(i) = (y(i + 1) - y(i))/h(i);
end

%transpun vectorii pentru a putea inmulti
h = h';
b = b';

%initializez diagonala principala a matricei tridiagonale cu ajutorul careia voi calcula vectorul corespunzator derivatei a doua intr-un punct(sigma) a spline-ului, cu ajutorul caruia voi exprima coeficientii polinomului de grad 3
diagonala = zeros(1, n - 2);

%initializez vectorul liber(din rezolvarea sistemului tridiagonal A * sigma = u)
u = zeros(1, n - 2);

%daca h are un element, diagonala e chiar acel element, iar vectorul liber e chiar valoarea din b
if length(h) == 1
    diagonala = h;
    u = b;

%altfel, calculez valorile din vectori cu aceste formule
else
    for i = 1 : length(h) - 1
        diagonala(i)  = 2 * (h(i) + h(i + 1));
        u(i) = 6 * (b(i + 1) - b(i));
    end
end

%aici este cazul cand x si y au 3 elemente, atunci h si b au cate 2,
%deci u va avea un element si nu pot aplica Thomas
%cand vectorii au cate doua elemente nu se poate aplica algoritmul pentru
%spline curbe, deci vor fi spline-uri liniare (s2 = s3 = 0)
if numel(u) == 1 || numel(u) == 0
    sigma = u/diagonala;
else
    %altfel aplic Thomas pentru gasirea lui sigma
    sigma = Thomas(h(1 : length(h) - 1)', diagonala, h(1 : length(h) - 1)', u');
end

%pentru spline-uri naturale, derivatele de ordin doi la capete sunt 0
sigma = [ 0; sigma'; 0];

%calculez coeficientii
s0 = y;
s1 = b - h.*(2 * sigma(1 : length(sigma) - 1) + sigma(2 : length(sigma)))/6;
s2 = sigma/2;
s3 = (sigma(2 : length(sigma)) - sigma(1 : length(sigma) - 1))./(6 * h);

%calculez spline-ul
%retin numarul de elemente din vectorul care contine punctele echidistante de pe axa Ox din interval
m = length(xx);

%initializez vectorul yy de lungime m
%acesta o sa contina valorile corespunzatoare lui xx, pe axa Oy
yy = zeros(1, m);

for j = 1 : m

	%folosesc fiecare valoare din intervalele x(k), x(k+1)
    for k = 1 : length(x)

		%cat timp valorile din x_in sunt mai mari decat o valoare din x
        if xx(j) < x(k)
            break;
        end
    end

	%daca valoarea din x_in(j) se afla in primul interval x(1), x(2), atunci i devine 1(corespunzator primului interval)     
    i = k - 1;
    
	%calculez valoarea corespunzatoare lui x_in pe axa Oy
    yy(j) = s0(i) + s1(i) * (xx(j) - x(i)) + s2(i) * (xx(j) - x(i)).^2 + s3(i) * (xx(j) - x(i)).^3;
end

end
