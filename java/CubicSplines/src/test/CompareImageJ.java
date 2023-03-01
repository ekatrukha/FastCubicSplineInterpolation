package test;

import cubicsplineIJ.CubicSplineImageJ;
import cubicsplineIJ.SplineFitter;

/** compare new implementation of cubic splines CubicSplineImageJ
 * versus previous SplineFitter **/
public class CompareImageJ {

	public static void main(String[] args) {
	
		int i;
		
		//let's make some x and y points
		// x should be ascending
		int [] xi = {0, 1, 2, 3, 4, 5};
		// y  can be anything
		int [] yi = {0, 0, 1, -1, 0, 2};
		
		//do the same for float
		float [] xf = {0.0f, 1.0f, 2.0f, 3.0f, 4.0f, 5.0f};
		float [] yf = {0.0f, 0.0f, 1.0f, -1.0f, 0.0f, 2.0f};
		
		//new implementation
		CubicSplineImageJ new_spline_int = new CubicSplineImageJ(xi, yi, 6);
		CubicSplineImageJ new_spline_float = new CubicSplineImageJ(xf, yf, 6);
		CubicSplineImageJ new_spline_closed = new CubicSplineImageJ(xf, yf, 6, true);
		
		//previous one
		SplineFitter old_spline_int = new SplineFitter(xi, yi, 6);
		SplineFitter old_spline_float = new SplineFitter(xf, yf, 6);
		SplineFitter old_spline_closed = new SplineFitter(xf, yf, 6, true);
		
		//evaluation points
		//step in dx
		double nStep = 0.1;
		//total number of points
		int nArraySize = (int)Math.round(5.0/nStep)+1;
		
		//double [] xeval = new double [nArraySize];
		double [] yeval_new_int = new double [nArraySize];
		double [] yeval_new_float = new double [nArraySize];
		double [] yeval_new_closed = new double [nArraySize];
		double [] yeval_old_int = new double [nArraySize];
		double [] yeval_old_float = new double [nArraySize];
		double [] yeval_old_closed = new double [nArraySize];
		
		double nX = 0.0;
		
		for (i=0;i<nArraySize; i++)
		{
			yeval_new_int[i]=new_spline_int.evalSpline(nX);
			yeval_new_float[i]=new_spline_float.evalSpline(nX);
			yeval_new_closed[i]=new_spline_closed.evalSpline(nX);
			yeval_old_int[i]=old_spline_int.evalSpline(nX);
			yeval_old_float[i]=old_spline_float.evalSpline(nX);
			yeval_old_closed[i]=old_spline_closed.evalSpline(nX);
			
			nX+=nStep;
		}
		
		//calculate a sum of squared differences
		double  diff_int = 0.0;
		double  diff_float = 0.0;
		double  diff_closed = 0.0;
		
		for (i=0;i<nArraySize; i++)
		{
			diff_int += Math.pow(yeval_new_int[i]-yeval_old_int[i], 2.0);
			diff_float += Math.pow(yeval_new_float[i]-yeval_old_float[i], 2.0);
			diff_closed += Math.pow(yeval_new_closed[i]-yeval_old_closed[i], 2.0);
		}
		System.out.println("Integer implementation (sum of squared differences): "+ Double.toString(diff_int));
		System.out.println("Float implementation (sum of squared differences): "+ Double.toString(diff_float));
		System.out.println("Closed spline implementation (sum of squared differences): "+ Double.toString(diff_closed));
		System.out.print("Done.");
		
	}
}
