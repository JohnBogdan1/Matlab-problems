function decrypt()

input = fopen('key1B', 'r');
%n este dimensiunea matricei
n = fscanf(input, '%f', 1);

%M este matricea
M = dlmread('key1B', ' ', 1, 0);

input = fopen('input1B', 'r');
text = fgetl(input);

lungime = length(text);

%convertesc textul in numere
for i = 1 : lungime
    if text(i) == ' '
        var(i) = double(lower(text(i))) - 32;
    elseif text(i) == '.'
        var(i) = double(lower(text(i))) - 19;
    elseif text(i) == ''''
        var(i) = double(lower(text(i))) - 11;
    else
        var(i) = double(lower(text(i))) + 1 - 'a';
    end
end

%adaug padding
if mod(lungime, n) ~= 0
    while mod(lungime, n) ~= 0
        var(lungime + 1) = 0;
        lungime = lungime + 1;
    end
end

%pun textul intr-o matrice
for i = 1 : (lungime/n)
		for j = 1 : n
			Old(i,j) = var(i * n - n + j);
        end
end
%calculez inversa modulo m a matricei M
inv_mat = GaussJordan(M);

New = Old';

%inmultesc cele doua matrici
C = inv_mat * New;
F = mod(C, 29);

%transform matricea rezultata in vector si il convertesc in sir de caractere
E = reshape(F,1,lungime);
for i= 1 : lungime
    if E(i) == 0
        asc(i) = char(E(i) + 32);
    elseif E(i) == 27
        asc(i) = char(E(i) + 19);
    elseif E(i) == 28
        asc(i) = char(E(i) + 11);
    else
        asc(i) = char(E(i) + 'a' - 1);
    end
end

%scriu rezultatul in fisier
out = fopen('output1B', 'w');
fprintf(out, '%s', asc);

fclose(input);
fclose(out);
end
