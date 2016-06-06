function FB()

%deschid fisierul de input
fileID = fopen('totti.txt', 'r');

%citesc primele doua valori de pe prima linie
valori = fscanf(fileID, '%f', [1, 2]);

%retin decat prima valoare
m = valori(1);

%citesc prima linie, deoarece nu imi trebuie
tline = fgetl(fileID);

while 1

    %citesc urmatoarea linie
    tline = fgetl(fileID);

    %ies, daca intalnesc end of file
    if ~ischar(tline)
        break
    end

    %desenarea mai multor grafice in acelasi spatiu
    hold on;

	%convertesc stringul in numeric
    data = str2num(tline);

	%retin vectorii x si y(cum este si in fisier, x este pana la jumatate, y dupa)
    x = data(1 : numel(data)/2);
    y = data(numel(data)/2 + 1 : numel(data));

	%generarea unor puncte echidistante dintr-un interval in numar de m de pe Ox
    xx = linspace(x(1), x(length(x)), m);

	%calculez valorile corespunzatoare de pe Oy
    yy = clampedspline(x', y', xx);

	%fac plot-ul
    plot(xx, yy);
end

hold off;
fclose(fileID);

end
