/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.mortgagejava;

import java.util.Scanner;
import java.lang.Math;

/**
 *
 * @author golam
 */
public class Compute {
    
    
    float n, L, R;
    double num, den, P;
    String option;
    Scanner readObj;
    
    public void message(String value)
    {
        //System.out.println();
        System.out.println("%s".format(value));
    }

    public void work() {
        readObj = new Scanner(System.in);
        message("Enter the terms (a) 15 year or (b) 30 years: ");
        option=readObj.nextLine();
        n=(option.equals("a")) ? 12*15 : 12*30;
        message("Enter the loan amount (USD): ");
        L=readObj.nextFloat();
        L=(L<0) ? 0 : L;
        message("Enter the rate (percentage): ");
        R=readObj.nextFloat();
        if(R<0) R=0; else R=1+(R/1200);
        
        num=L*Math.pow(R, n);
        den=(1-Math.pow(R, n))/(1-R);
        P=num/den;
        
        message("The monthly payment is:");
        System.out.printf("$%f\n",P);
        message("Appreciated!");
    }
    
    public double get_Payment()
    {
    return P;
    }
}

