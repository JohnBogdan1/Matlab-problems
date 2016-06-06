function multiply = expos(x, n, nmin)
[~,m] = size(x);
result = eye(m);
	while n ~= 0
		%verific daca n este par/impar
		%mai exact, daca cel mai din dreapta bit este 1 sau 0
		if bitget(n,1) ~= 0
			result = strassen_algorithm(result, x, nmin);
			%n devine par
			n = n-1;
		end
		%inmultesc pe x cu el insusi
		x = strassen_algorithm(x, x, nmin);
		n = n/2;
	end
	multiply = result;
end
