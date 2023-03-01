function [ ypp ] = initSpline( knots, values, start_deriv, end_deriv)
    n= length(knots);
    ypp=knots*0;
    c_p=knots*0;
    
    %recycle these values in later routines
    new_x = knots(2);
    new_y = values(2);
    cj = knots(2)-knots(1);
    new_dj = (values(2)-values(1))/cj;
    
    % initialize the forward substitution
    if (start_deriv >0.99e30)
        c_p(1)=0;
        ypp(1)=0;
    else
        c_p(1)=0.5;
        ypp(1)=3*(new_dj-start_deriv)/cj;
    end
    % forward substitution portion
    j=2;
    while (j<n)
        %shuffle new values to old
        old_x=new_x;
        old_y = new_y;
        aj = cj;
        old_dj = new_dj;
        
        %generate new quantities
        new_x = knots(j+1);
        new_y = values(j+1);
        
        cj = new_x - old_x;
        new_dj = ( new_y - old_y ) / cj;
        bj = 2*( cj + aj );
        inv_denom = 1. / ( bj - aj * c_p (j-1));
        dj = 6*( new_dj - old_dj );
        ypp (j) = ( dj - aj * ypp ( j-1)) * inv_denom;
        c_p (j) = cj * inv_denom;
        j=j+1;
    end
    % handle the end derivative
    if end_deriv> 0.99e30
        c_p(j) =0;
        ypp(j) =0;
    else
        old_x = new_x;
        old_y = new_y;
        aj = cj;
        old_dj = new_dj;
        % this has the same effect as skipping c_n
        cj = 0;
        new_dj = end_deriv;
        bj=2*(cj+aj);
        inv_denom = 1. / ( bj - aj * c_p (j-1));
        dj = 6*( new_dj - old_dj );
        ypp (j) = ( dj - aj * ypp(j-1)) * inv_denom;
        c_p (j) = cj * inv_denom;
    end 
    % as we're storing d_j in y''_j , y''_n = d_n is a no-op
    % backward substitution portion
    while (j > 1)
        j = j-1;
        ypp(j) = ypp(j) - c_p (j)* ypp(j +1);
    end
end

