% adaptation of  Fornberg, Bengt (1988), "Generation of Finite Difference Formulas on Arbitrarily Spaced Grid
% for the first derivative
% given a set of x values in alpha, function calculates
% finite difference coefficients at point x0 (for the first derivative).
% The x values in alpha not necessary should be equally spaced,
% but must be distinct from each other.

function [coeff] = finite_coef_deriv( alpha,x0 )

    N = length(alpha);
    delta = zeros(N,N,2);

    delta(1,1,1)=1;
    c1 = 1;
    for n=2:N
        c2=1;
        for v=1:(n-1)
            c3=alpha(n)-alpha(v);
            c2=c3*c2;

            delta(n,v,1)=(alpha(n)-x0)*delta(n-1,v,1)/c3;
            delta(n,v,2)=((alpha(n)-x0)*delta(n-1,v,2)-delta(n-1,v,1))/c3;

            delta(n,n,1)=(c1/c2)*((-1)*(alpha(n-1)-x0)*delta(n-1,n-1,1));
            delta(n,n,2)=(c1/c2)*(delta(n-1,n-1,1)-(alpha(n-1)-x0)*delta(n-1,n-1,2));
    
        end
        c1=c2;
    end
    coeff = zeros(N,1);
    for v=1:N
        coeff(v) = delta(N,v,2);
    end
end

