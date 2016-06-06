function X = gauss(A)

[~,n] = size(A);
X = eye(n);

for j = 1 : n - 1
    for z = j + 1 : n
		%daca pivotul este 0, fac pivotare cu alta linie
        if A(j, j) == 0
            t = A(j, :); 
			A(j, :) = A(z, :);
            A(z, :) = t;

			s = X(j, :); 
			X(j, :) = X(z, :);
            X(z, :) = s;
        end
    end
    for i = j + 1 : n
		%calculez inversul modulo 29 al pivotului si inmultesc linia respectiva cu acesta
		%invmod este functia care calculeaza inversul modulo al pivotului
        t = A(i, j)/A(j, j);
		%calculez celelalte elemente si fac mod 29
		A(i, :) = A(i, :) - A(j, :) * t;
		%modific elementele si in matricea unitate
		X(i, 1 : n) = X(i, 1 : n) - t * X(j, 1 : n);
    end
end
for i = n : -1 : 1
    for k = 1 : n
		%substitutie inapoi in X
        suma = A(i, i + 1 : n) * X(i + 1 : n, k);
        X(i, k) = (X(i, k) - suma)/A(i, i);
    end
end
end
