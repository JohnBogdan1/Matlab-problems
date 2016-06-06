function r = IntervaleValProprii(d, s, m)
n=length(d);
[limita_inf, limita_sup] = LimiteValProprii(d, s);
r(1) = limita_inf;
if m > n
	m=n;
end
k = m : -1 : 1;
r(k+2) = limita_sup;
for k = m : -1 : 1
    mij = (r(k+2) + r(1))/2;
    h = (r(k+2) - r(1))/2;
    numvp = NrValProprii(d, s, mij);
    while numvp ~= k
        numvp = NrValProprii(d, s, mij);
        h=h/2;
        if numvp < k
            mij=mij+h;
        elseif numvp > k
            mij = mij - h;
        end
    end
    r(k+1) = mij;
end
    r=r(1:m+1);
end
