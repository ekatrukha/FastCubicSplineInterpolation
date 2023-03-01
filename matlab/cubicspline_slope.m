% cubic spline interpolation + derivative slope) calculation
% Matlab implementation of the code described in the paper
% Haysn Hornbeck "Fast Cubic Spline Interpolation"
% https://arxiv.org/abs/2001.09253
% Author: Eugene Katrukha email:katpyxa@gmail.com
%CUBICSPLINE_DERIV
%   the input is the same as CUBICSPLINE function,
%   but it returns YS slope (derivatives) of cubic spline
%   in the interpolated points XS 


function [ ys ] = cubicspline_slope(varargin)

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
    %calculate secon derivatives
    ypp = initSpline(x,y,start_deriv,end_deriv);
    %evaluate splines
    ys = xs*0;
    for i=1:length(xs)
        ys(i)=evalSlope(x,y, ypp, xs(i));
    end
end

