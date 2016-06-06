function M = matinv(A)

%metoda partitionarii
n = length(A);

%conditia de oprire
nmin = 32;

if n <= nmin
	M = gauss(A);

else
 	m = round(n/2); i = 1 : m; j = m + 1 : n;

	A1 = A(i, i);
	A3 = A(i, j);
	A2 = A(j, i);
	A4 = A(j, j);

	%retin dimensiunile submatricilor
	[p,q] = size(A3);
	[r,s] = size(A1);
	[t,v] = size(A2);
	[u,w] = size(A4);
	
	%inversele celor doua submatrici A1 si A4
	B1 = matinv(A1);
	B4 = matinv(A4);

%fac inmultirile dintre submatrici cu strassen si elimin padding-ul de zerouri
	a = strassen_algorithm(A3, B4,nmin);
	a = a(1 : p, 1 : q);
	b = strassen_algorithm(a, A2, nmin);
	b = b(1 : r, 1 : s);
	X1 = matinv(A1 - b);


	c=strassen_algorithm(-B4, A2,nmin);
	c = c(1 : t, 1 : v);
	d = strassen_algorithm(c, X1, nmin);
	d = d(1 : t, 1 : v);
	X2 = d;


	m=strassen_algorithm(A2, B1,nmin);
	m = m(1 : t, 1 : v);
	f = strassen_algorithm(m, A3, nmin);
	f = f(1 : u, 1 : w);
	X4 = matinv(A4 - f);


	g=strassen_algorithm(-B1, A3,nmin);
	g = g(1 : p, 1 : q);
	h = strassen_algorithm(g, X4, nmin);
	h = h(1 : p, 1 : q);
	X3 = h;

	M = [X1, X3; X2, X4];
end
end
