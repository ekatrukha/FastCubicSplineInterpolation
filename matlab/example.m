%let's generate some xy points

%sine function
%{
x=(0:(2*pi/6):2*pi)';
y=sin(x);
% resample
xe = (0:(2*pi/50):2*pi)';
%}

% or some arbitraty
% {
x=(0:5)';
y = [0;0;1;-1;0;2];
%resample
xe=(0:0.1:5)';
% }

figure
%natural spline (second deriv at ends = 0)
ys1 = cubicspline(x,y,xe);
%estimated derivatives at ends from the data (3 points)
ys2 = cubicspline(x,y,xe,3);
plot(x,y,'*',xe,[ys1,ys2]);
legend('points','natural','derivative estimate');

%build derivatives (slopes) at each interpolated point
% for the second spline
figure
plot(x,y,'*');
hold on
plot(xe,ys2,'--', 'LineWidth',3);
%calculate slopes
slopes = cubicspline_slope(x,y,xe,3);
dl=0.1;
dx=x*0;
dy=ys2*0;
%plot tangent lines at each location
for i=1:length(slopes)
    dx(i)=sqrt(dl*dl/(1+slopes(i)*slopes(i)));
    dy(i)=slopes(i)*dx(i);

end
quiver(xe,ys2,dx,dy)