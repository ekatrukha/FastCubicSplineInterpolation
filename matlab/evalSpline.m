function [ fin ] = evalSpline( knots,values, ypp, x )

n = length(knots);

if(x<knots(1) | x>knots(end))
    fin = NaN;
    return;
end
%binary search
L=1;
R=n;
while(R>1+L)
    m=floor(0.5*(L+R));
    if knots(m)<x
        L=m;
    else
        R=m;
    end
end

ba = knots(R)-knots(L);
xa = x - knots(L);
bx = knots(R)-x;
ba2 = ba*ba; % 3 adds , 1 mult , 1 div
lower = xa*values(R)+bx*values(L);
C = (xa*xa - ba2)*xa*ypp(R);
D = (bx*bx - ba2)*bx*ypp(L);
fin= (lower+(.16666666666666666)*(C+D))/ba;

end

