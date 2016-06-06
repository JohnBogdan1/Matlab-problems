function X = GaussJordan(A)

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
        t = mod(A(i, j) * invmod(A(j, j), 29), 29);
		%calculez celelalte elemente si fac mod 29
		A(i, :) = mod(A(i, :) - A(j, :) * t, 29);
		%modific elementele si in matricea unitate
		X(i, 1 : n) = mod(X(i, 1 : n) - t * X(j, 1 : n), 29);
    end
end
for i = n : -1 : 1
    for k = 1 : n
		%substitutie inapoi in X
        suma = A(i, i + 1 : n) * X(i + 1 : n, k);
        X(i, k) = mod((X(i, k) - suma) * invmod(A(i, i), 29), 29);
    end
end
end
