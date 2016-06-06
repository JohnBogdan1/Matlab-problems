function [l, vec] = ipmethod(d, s, u, y, maxIter)
for k = 1 : maxIter
    z = Thomas(s, d - u, s, y);
    y = z/norm(z);
    v = fun(d, y, s);
    l = v * y';
    vec=y;
    u = l;
end
end