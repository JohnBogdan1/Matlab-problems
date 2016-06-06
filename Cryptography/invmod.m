function y = invmod(x,p)

k = 0;
m = 1;

%cat timp m ~= 0, incrementez k si calculez m, pana cand este 0
%cand am gasit ca m = 0, k este factorul care da inversul multiplicativ
while m
    k = k + 1;
    m = mod(k * p + 1, x);
end
%inversul modulo
y = (k * p + 1)./x;
