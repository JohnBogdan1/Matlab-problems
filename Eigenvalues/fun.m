function v = fun(d,y,s)
for i = 1 : length(d)
        if i == 1
            v(i) = y(i) * d(i) + y(i+1) * s(i);
        else
            if i == length(d);
                v(i) = y(i) * d(i) + y(i-1) * s(i - 1);
            else
                v(i) = y(i) * d(i) + y(i - 1) * s(i - 1) + y(i + 1) * s(i);
            end
        end
end
end