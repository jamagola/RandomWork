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

int main()
{
	float l,T;
	float bc,ic,C;
	int n,nt;

	cout<<"This program attempts to solve a particular heat equation!"<<endl;
	cout<<"Assume there is a square conductive plane. Temperature"<<endl;
	cout<<"u(x,y,t) is fixed at the boundary defined by the user. Also,"<<endl;
	cout<<"u(x,y,0) is the intial condition defined by the user. This"<<endl;
	cout<<"program solves u'(x,y,t)=(c^2)*(u_xx(x,y,t)+u_yy(x,y,t)) where"<<endl;
	cout<<"'c' diffusivity is given by the user"<<endl;
	printf("\nEnter the square length: ");
	scanf("%f",&l);
	printf("Enter the number of grid point within a given length, including the boundary: ");
	scanf("%d",&n);
	cout<<"Enter the simulation time length: ";
	cin>>T;
	cout<<"Enter the number of time stamps within the given length: ";
	cin>>nt;
	cout<<"Enter the constant source temperature at the boundary: ";
	cin>>bc;
	cout<<"Enter the constant initial temperature rest of the plane: ";
	cin>>ic;
	cout<<"Enter the constant diffusivity of the material 'C': ";
	cin>>C;
	
	//Attention!!
	Heat pdeSolve(l,T,C,bc,ic,n,nt);
	
	pdeSolve.xytgrid();
	pdeSolve.boundaryInitial();
	pdeSolve.printInitial();
	pdeSolve.solve();
	pdeSolve.printFinal();
	pdeSolve.csvOut();
	//pdeSolve.~Heat();
	
	return 0;
}   	
