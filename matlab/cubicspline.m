% cubic spline interpolation
% Matlab implementation of the code described in the paper
% Haysn Hornbeck "Fast Cubic Spline Interpolation"
% https://arxiv.org/abs/2001.09253
% Author: Eugene Katrukha email:katpyxa@gmail.com
%CUBICSPLINE
%   YS = CUBICSPLINE(X,Y,XS) performs natural cubic splines interpolation
%   using X as knots and Y as function values. 
%   Calculates and returns interpolated function values YS at locations XS.
%   X must be array containing increasing ordered values
%   XS should be withing the range of X
%
%
%   YS = CUBICSPLINE(X,Y,XS,START_DERIV,END_DERIV) performs cubic splines interpolation
%   where the slopes (derivatives) at the first and last endpoints
%   are provided in START_DERIV,END_DERIV variables
%
%
%   YS = CUBICSPLINE(X,Y,XS,N_EST) performs cubic splines interpolation
%   where the slopes (derivatives) at the first and last endpoints
%   are estimated using N_EST first(last) points. 
%   N_EST can be in the range from 2 to the number of points (usually 2-3
%   already gives good result)


function [ ys ] = cubicspline(varargin)

% Check number of arguments
narginchk(3,5);
%knots
x = varargin{1};
%function values
y = varargin{2};
%interpolation points
xs = varargin{3};

%some basic error check
n = length(x);
if(n<3)
    error('we need at least 3 knots/points');
end
switch nargin
    case 3
        start_deriv = Inf;
        end_deriv = Inf;
    case 4
        n_est = varargin{4};
        [start_deriv, end_deriv] = est_deriv(x,y,n_est);        
    case 5
        start_deriv = varargin{4};
        end_deriv = varargin{5};
end
%function [ ys ] = cubicspline( x,y,xs )varargin
    ypp = initSpline(x,y,start_deriv,end_deriv);
    ys = xs*0;
    for i=1:length(xs)
        ys(i)=evalSpline(x,y, ypp, xs(i));
    end
end

