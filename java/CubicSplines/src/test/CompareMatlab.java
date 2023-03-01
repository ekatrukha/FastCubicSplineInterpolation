package test;

import cubicspline.CubicSpline;


public class CompareMatlab {
	
	public static void main(String[] args) {
		
		int i;
		
		//let's make some x and y points
		// x should be ascending
		float [] xf = {0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f};
		// y  can be anything
		float [] yf = {0.0f, 0.0f, 1.0f, -1.0f, 0.0f, 2.0f};
		
		//new implementation
		
		CubicSpline new_spline_natural = new CubicSpline(xf, yf);
		CubicSpline new_spline_deriv = new CubicSpline(xf, yf, 0.5, 0.5);
		CubicSpline new_spline_deriv_est = new CubicSpline(xf, yf, 3);
		
		
		//evaluation points
		//step in dx
		double nStep = 0.1;
		//total number of points
		int nArraySize = (int)Math.round(5.0/nStep)+1;
		
		double [] yeval_natural = new double [nArraySize];
		double [] yeval_deriv = new double [nArraySize];
		double [] yeval_deriv_est = new double [nArraySize];
		
		double [] ysl_natural = new double [nArraySize];
		double [] ysl_deriv = new double [nArraySize];
		double [] ysl_deriv_est = new double [nArraySize];
		
		double nX = 0.0;
		
		for (i=0;i<nArraySize; i++)
		{
			yeval_natural[i]=new_spline_natural.evalSpline(nX);
			yeval_deriv[i]=new_spline_deriv.evalSpline(nX);
			yeval_deriv_est[i]=new_spline_deriv_est.evalSpline(nX);
			
			//ysl_natural[i]=new_spline_natural.evalSlope(nX);
			//ysl_deriv[i]=new_spline_deriv.evalSlope(nX);
			ysl_deriv_est[i]=new_spline_deriv_est.evalSlope(nX);
			nX+=nStep;
		}
		System.out.print("Done.");
	}	
}
