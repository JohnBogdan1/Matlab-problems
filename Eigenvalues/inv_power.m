function [lambda, v] = inv_power ( A, q, x, TOL, Nmax )
[r, c] = size ( A );
[rx, rc] = size ( x );
if ( rc == 1 ) x = x'; rc = rx; end;

if ( r ~= c )
   disp ( 'inv_power error: matrix must be square' );
   return;
elseif ( r ~= rc )
   disp ( 'inv_power error: dimensions of matrix and vector are not compatible' );
   return;
end;


p = min ( find ( abs(x)  == max(abs(x)) ) );
x = x / x(p);
mu_old = 0;

if ( nargout == 0 )
   s = sprintf ( '%3d \t %10f ', 0, x(1) );
   for j = 2 : rc
	   s = sprintf ( '%s%10f ', s, x(j) );
   end;
   disp ( s );
end;

lu = inv ( A - q*eye(rc) );

for i = 1 : Nmax
    xnew = lu*x;
	mu = xnew(p);
	p = min ( find ( abs(xnew)  == max(abs(xnew)) ) );
    xnew = xnew / xnew(p);
	
	if ( nargout == 0 )
	   s = sprintf ( '%3d \t %10f ', i, xnew(1) );
	   for j = 2 : rc 
	       s = sprintf ( '%s%10f ', s, xnew(j) );
	   end;
	   s = sprintf ( '%s \t %10f', s, 1/mu+q );
	   if ( i >= 2 ) s = sprintf ( '%s \t \t %10f', s, abs((mu-mu_old)/(mu_old-mu_older)) ); end;
	   disp ( s );
	end;
	
	err = max ( abs ( x - xnew ) );
	if ( err < TOL )
	   if ( nargout >= 1 ) lambda = 1/mu+q; end;
	   if ( nargout >= 2 ) v = xnew'; end;
	   return;
	else   
 	   x = xnew;
	   mu_older = mu_old;
	   mu_old = mu;
	end;
	
end;

disp ( 'inv_power error: Maximum number of iteration exceeded' );
if ( nargout >= 1 ) lambda = 1/mu+q; end;
if ( nargout >= 2 ) v = xnew; end;
end