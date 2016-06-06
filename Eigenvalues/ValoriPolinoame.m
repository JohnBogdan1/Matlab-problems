function P = ValoriPolinoame(d, s, val_lambda)
P(1)=1;
P(2)=d(1)-val_lambda;
n=length(d) + 1;
for i=3:n
    P(i)=(d(i-1)-val_lambda)*P(i-1)-s(i-2)^2*P(i-2);
end
end