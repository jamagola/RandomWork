#ifndef HEAT_H
#define HEAT_H
#include <iostream>
#include <math.h>
#include <fstream>

using namespace std;

class Heat {
	
	public:
	  Heat(float length, float duration, float C_, float boundary, float initial, int gridXY, int gridTime);
	  ~Heat();
	  void xytgrid();
	  void boundaryInitial();
	  void printInitial();
	  void solve();
	  void printFinal();
	  void csvOut();
	  
	private:
	  float l,T,delta,deltaT,C,alpha,bc,ic;
	  int n,nt;
	  float *x;
	  float *y;
	  float *t;
	  float *u;	  
};
#endif
