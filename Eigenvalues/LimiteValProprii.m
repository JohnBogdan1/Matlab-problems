function [limita_inf, limita_sup] = LimiteValProprii(d, s)
n = length(d);
suma = 0;
p=1000;
q=-1000;
for i = 1 : n
    if i == 1
        suma = suma + norm(s(i));
    elseif i == n
        suma = suma + norm(s(i - 1));
    else
        suma = suma + norm(s(i - 1)) + norm(s(i));
    end
    
    limita_inf = d(i) - suma;
    if p > limita_inf
        p = limita_inf;
    end
    
    limita_sup = d(i) + suma;
    if q < limita_sup
        q = limita_sup;
    end
    suma = 0;
end
limita_inf = p;
limita_sup = q;
end