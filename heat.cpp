/* 
PDE explicit iterative method to solve heat equation
Golam Gause Jaman
jamagola@isu.edu
*/

#include <iostream>
#include <math.h>
#include <fstream>
#include "heat.h"

using namespace std;

Heat::Heat(float length, float duration, float C_, float boundary, float initial, int gridXY, int gridTime) {

  l=length;
  T=duration;
  C=C_;
  bc=boundary;
  ic=initial;
  n=gridXY;
  nt=gridTime;
  delta=l/(n-1);
  deltaT=T/(nt-1);
  alpha=deltaT*pow(C,2)/delta;
  
  x=new float[n];
  y=new float[n];
  t=new float[nt];
  u=new float[n*n*nt];
}

Heat::~Heat() {
	
	delete[] x;
	delete[] y;
	delete[] t;
	delete[] u;
	
	printf("\n\nDestructor called!!\n\n");
}

void Heat::xytgrid()
{
	int i=0;
	while(i<n)
	{
		x[i]=i*delta;
		y[i]=i*delta;
		i++;
	}
	
	i=0;
	while(i<nt)
	{
		t[i]=i*deltaT;
		i++;
	}
}

void Heat::boundaryInitial()
{
	for(int k=0; k<nt; k++){
		for(int j=0; j<n; j++){
			for(int i=0; i<n; i++){
				if((i==0||i==(n-1)||j==0||j==(n-1))&&(k==0)) u[n*n*k+n*j+i]=bc;
				else if(k==0) u[n*n*k+n*j+i]=ic;
				else u[n*n*k+n*j+i]=0;
			}
		}
	}
}

void Heat::printInitial()
{
	printf("\n\n");
	// At t=0
	for(int j=0; j<n; j++){
		for(int i=0; i<n; i++){
			printf("%3.2f\t", u[n*j+i]);
		}
		cout<<endl;
	}
	cout<<endl;
	
	for(int i=0; i<n; i++) printf("x[%2d]: %3.2f\n",i,x[i]);
	cout<<endl;
	for(int i=0; i<n; i++) printf("y[%2d]: %3.2f\n",i,y[i]);
	cout<<endl;
	for(int i=0; i<nt; i++) printf("t[%2d]: %3.2f\n",i,t[i]);
	cout<<endl;
	cout<<endl;
	
	cout<<"alpha is : "<<alpha<<endl;
}

void Heat::solve()
{
	//Explicit algorithm
	for(int k=0; k<nt; k++){
		for(int j=0; j<n; j++){
			for(int i=0; i<n; i++){
				if(k==0) { }
				else if(i==0 || i==(n-1) || j==0 || j==(n-1)) u[n*n*k+n*j+i]=bc;
				else {
					u[n*n*k+n*j+i]=alpha*(u[n*n*(k-1)+n*(j-0)+(i-1)] + u[n*n*(k-1)+n*(j-0)+(i+1)] + u[n*n*(k-1)+n*(j-1)+(i-0)] + u[n*n*(k-1)+n*(j+1)+(i-0)] - 4*u[n*n*(k-1)+n*(j-0)+(i-0)]) + u[n*n*(k-1)+n*(j-0)+(i-0)];
					}
			}
		}
	}
}

void Heat::printFinal()
{
	// Display at last time stamp
	cout<<endl;
	
	cout<<"At t=tend: "<<endl;
	for(int j=0; j<n; j++){
		for(int i=0; i<n; i++){
			printf("%3.2f\t", u[n*n*(nt-1)+n*j+i]); //k=1
		}
		cout<<endl;
	}
	cout<<endl;
}

void Heat::csvOut(){
	ofstream outputFile;
	outputFile.open("heatSolve.csv");
	
	for(int k=0; k<nt; k++){
		for(int j=0; j<n; j++){
			for(int i=0; i<n; i++){
				outputFile<<u[n*n*k+n*j+i]<<", ";
			}
			outputFile<<endl;
		}
		outputFile<<endl;
	}
	outputFile.close();
}
