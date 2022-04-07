/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Project/Maven2/JavaApp/src/main/java/${packagePath}/${mainClassName}.java to edit this template
 */

package com.mycompany.mortgagejava;

/**
 *
 * @author golam
 */
import java.util.Scanner;
import java.lang.Math;


public class MortgageJava {
    public static void main(String[] args) {
        Compute paymentObj=new Compute();
        paymentObj.work();
        
        if(paymentObj.get_Payment()==0)
        {
        System.out.printf("\n\nAre you stupid? Check your input!!\n\n");
        }
        
        else
        {}
    }
}