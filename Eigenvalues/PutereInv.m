function [valp, vecp] = PutereInv(d, s, h, y, maxIter, eps)
[valp, vecp] = ipmethod(d, s, h, y, maxIter);
end