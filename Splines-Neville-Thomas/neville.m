function yy = neville(x, y, xx)
%x si y sunt vectorii cu punctele de pe axa Ox, respectiv Oy
%xx este vectorul care contine punctele ehidistante
n = length(x);

%initializez o matrice de zerouri
Table = zeros(n, n);

%initializez prima coloana din matrice cu y
Table(:, 1) = y';

%initializez vectorul yy
yy = zeros(1, length(xx));

%folosesc toate valorile din xx
for k = 1 : length(xx)
    for i = 2 : n
        for j = 3 : i + 1
			%valorile din matrice vor fi generate pe coloane, ultima valoare(Table(n, n)) fiind valoarea data de polinomul Neville
			%valorile de pe coloana urmatoare sunt calculate in functie de cele de pe coloana precedenta, restul de valori pana la n fiind 0
			%este generata o piramida de valori ale polinomului, celelalte valori nefolosite din matrice fiind 0 
            Table(i, j - 1) = ((xx(k) - x(i)) * Table(i - 1, j - 2) - (xx(k) - x(i - j + 2)) * Table(i, j - 2))/(x(i - j + 2) - x(i));
        end
    end

	%extrag ultima valoare din matrice
    yy(k) = Table(n, n);
end

end
