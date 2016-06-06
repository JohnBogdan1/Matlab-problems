function numvp = NrValProprii(d, s, val_lambda)
numvp=0;
P = ValoriPolinoame(d, s, val_lambda);
n=length(d);
for i=1:n
    if P(i) == 0
		if -sign(P(i-1)) ~= sign(P(i+1))
			numvp=numvp+1;
		end
    elseif P(i) ~= 0
		if sign(P(i)) ~= sign(P(i+1))
        	numvp=numvp+1;
		end
    end
end
end