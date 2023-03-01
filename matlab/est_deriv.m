% function estimates first derivatives at the ends of
% function y (tabulated at x values)
% using first (or last) n_est points
function [ start_deriv, end_deriv ] = est_deriv( x,y,n_est )

    n=length(x);
    % get finite difference coefficients
    coeff = finite_coef_deriv(x(1:n_est),x(1));
    start_deriv = 0;
    for i=1:n_est
        start_deriv  = start_deriv+coeff(i)*y(i);
    end
    %same for another end point
    coeff = finite_coef_deriv(x((n-n_est+1):n),x(n));
    end_deriv = 0;
    for i=(n-n_est+1):n
        end_deriv  = end_deriv+coeff(i-n+n_est)*y(i);
    end
end

