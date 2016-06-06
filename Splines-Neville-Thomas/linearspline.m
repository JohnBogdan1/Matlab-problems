function y_out = linearspline(x, y, x_in)

%retin numarul de elemente din vectorul care contine punctele echidistante de pe axa Ox din interval
L = length(x_in);

%initializez vectorul y_out de lungime L
%acesta o sa contina valorile corespunzatoare lui x_in, pe axa Oy
y_out = zeros(1, L);

for j = 1 : L

	%folosesc fiecare valoare din intervalele x(k), x(k+1)
    for k = 1 : length(x)
		%cat timp valorile din x_in sunt mai mari decat o valoare din x
        if x_in(j) < x(k)
            break;
        end
    end
	%daca valoarea din x_in(j) se afla in primul interval x(1), x(2), atunci i devine 1(corespunzator primului interval) 
    i = k - 1;

	%calculez valoarea corespunzatoare lui x_in pe axa Oy
    y_out(j) = x_in(j) * (y(i + 1) - y(i))/(x(i + 1) - x(i)) + ( x(i + 1) * y(i) - x(i) * y(i + 1) )/(x(i + 1) - x(i));
end

end
