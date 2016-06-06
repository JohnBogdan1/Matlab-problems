function strassen(fisier_in,fisier_out)
input = fopen(fisier_in, 'r');
N = fscanf(input, '%d', 1);
A = dlmread(fisier_in, ' ', 1, 0);
nr = length(A);

%elimin coloana de zerouri de la sfarsit
n = nr - 1;
A = A(:, 1 : n);


%conditia de oprire
nmin = 32;

%apelez functia de ridicare la puterea N
C = expos(A, N, nmin);

%elimin padding-ul
C = C(1 : n, 1 : n);

%calculez inversa
D = matinv(C);


%scriu rezultatul in fisier
dlmwrite(fisier_out, D, 'delimiter', ' ', 'precision', '%0.6f', 'newline', ' \r\n');

end
