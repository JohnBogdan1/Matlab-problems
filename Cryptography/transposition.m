function transposition()

input = fopen('input1C','r');

%citesc cheia k si numarul n de caractere codificate la fiecare pas
k = fscanf(input, '%d', 1);
n = fscanf(input, '%d', [2,inf]);

%modific pozitia indicatorului in fisier, pentru a putea citi textul
pozitie = ftell(input);
fseek(input, pozitie, 'bof');
text = fgetl(input);

%declar o matrice cu zerouri de dimensiune n+1
A = zeros(n + 1);
%pe ultima coloana a matricei, dar pana la linia n, pun cheia k
A(1 : n, n + 1) = k;
%adun matricea A cu matricea unitate
M = eye(n + 1) + A;

%scriu matricea in fisier
key = fopen('key1C', 'w');
dlmwrite(key,M,'delimiter',' ');

lungime = length(text);

%retin lungimea initiala a sirului, fara padding
original = lungime;

%convertesc textul
for i = 1 : lungime
    if text(i) == ' '
        var(i) = double(text(i)) - 32;
    elseif text(i) == '.'
        var(i) = double(text(i)) - 19;
    elseif text(i) == ''''
        var(i) = double(text(i)) - 11;
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

B = [];

loopVar = 1;
contor = 0;
alfa = 1;

for i = 1 : (lungime/n)
    M(1 : n, n + 1) = k;
	%voi imparti textul in vectori de dimensiune n si voi inmulti matricea de transpozitie cu fiecare
    for j = 1 : n
			v(j) = var(i * n - n + j);

			%numar caracterele parcurse
            contor = contor + 1;

			%daca am ajuns la caracterul cu numarul multiplu de 1000, retin numarul, incrementez cheia k
            if mod(contor, 1000) == 0
                k = k + 1;
                alfa = contor;
            end
    end

	%cand am ajuns la caracterul cu numarul multiplu de 1000, caracterele aflate inainte le transpun cu k, iar cele dupa 1000 cu k + 1
    if mod(alfa, 1000) == 0
        c = contor - alfa;
        g = n - c;
        M(g + 1 : n, n + 1) = k;
        V = v';

		%adaug un 1 la vector pentru a putea inmulti matricea cu acesta
        V(n + 1) = 1;
        Z = M * V;
        X = mod(Z, 29);
        W = X';

		%elimin elementul 1 adaugat
        W(n + 1) = [];
		
		%adaug vectorul la o matrice
        B(loopVar, :) = W;
        loopVar = loopVar + 1;
	%in rest, caracterele le transpun la fel
    else
        V = v';
        V(n + 1) = 1;
        Z = M * V;
        X = mod(Z, 29);
        W = X';
        W(n + 1) = [];

		%adaug vectorul la o matrice
        B(loopVar, :) = W;
        loopVar = loopVar + 1;
    end
	%dupa 1000 sau un multiplu al acestuia, reinitializez pe alfa
    alfa = 1;
end

%transform matricea in sir(vector) de numere
b = reshape(B', 1, []);

%elimin padding-ul din sir
for i = 1 : original
    G(i) = b(i);
end

%transform vectorul in sir de caractere
for i = 1 : original
    if G(i) == 0
        asc(i) = char(G(i) + 32);
    elseif G(i) == 27
        asc(i) = char(G(i) + 19);
    elseif G(i) == 28
        asc(i) = char(G(i) + 11);
    else
        asc(i) = char(G(i) + 'a' - 1);
    end
end
%scriu rezultatul in fisier
out = fopen('output1C','w');
fprintf(out,'%s',asc);

fclose(input);
fclose(out);
fclose(key);
end
