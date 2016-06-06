function C = strassen_algorithm(A, B, nmin)

%nmin este conditia de oprire

n = length(A);

%adaug zerouri(padding), pentru ca matricile sa fie puterea lui 2
if log2(n) ~= floor(log2(n))
	%cea mai apropiata valoare de n, care este puterea lui 2
	n = 2^(ceil(log2(n)));
	A(n,n)=0;
	B(n,n)=0;
end

	%aplic Algoritmul lui Strassen
	if n <= nmin
		C = A * B;
	else
		m = n/2; i = 1 : m; j = m + 1 : n;
		P1 = strassen_algorithm( A(i, i) + A(j, j), B(i, i) + B(j, j), nmin);
		P2 = strassen_algorithm( A(j, i) + A(j, j), B(i, i), nmin);
		P3 = strassen_algorithm( A(i, i), B(i, j) - B(j, j), nmin);
		P4 = strassen_algorithm( A(j, j), B(j, i) - B(i, i), nmin);
		P5 = strassen_algorithm( A(i, i) + A(i,j), B(j,j), nmin);
		P6 = strassen_algorithm( A(j, i) - A(i, i), B(i, i) + B(i, j), nmin);
		P7 = strassen_algorithm( A(i, j) - A(j, j), B(j, i) + B(j, j), nmin);
		C = [ P1 + P4 - P5 + P7  P3 + P5;  P2 + P4  P1 + P3 - P2 + P6 ];
	end
end

