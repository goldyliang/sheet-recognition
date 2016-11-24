package musicPR;

import java.io.*;
import java.util.*;
import java.util.List;
import java.io.BufferedReader;
import java.io.DataInput;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.*;
import javax.imageio.*;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.awt.Graphics;
//////////////////////////////////////////////////////////////////////////////////////////////////
public class Candidate 
{
	public static double thresholdMinMatched = 0.5;
	public static double thresholdMaxDiff = 0.22;
	int match = 0;
	int diff = 0;
	List <Integer> nX = new ArrayList<Integer>();
	List <Integer> nY = new ArrayList<Integer>();
	//////////////////////////////////////////////
	//Input
	List <Point> contour;
	int groupNum;
	int lineNum;  // 0 - 11
	int midLine;
	int heightEst;
	///////////////////////
	
	int pixCount;
	Point noteCenter;
	boolean isNote = false;
	Mask check1 = new Mask();
//////////////////////////////////////////////////////////////////////////////////////////////////
	//Constructor
	public Candidate(int groupNum, int lineNum, int midLine, int height, List <Point> contour)
	{
		this.contour = contour;
		this.groupNum = groupNum;
		this.lineNum = lineNum;
		this.midLine = midLine;
		this.heightEst = height;
		//this.compute();
		//this.mapIt();
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////
	public void compute()
	{
		List <Integer> x = new ArrayList<Integer>();
		List <Integer> y = new ArrayList<Integer>();
				
		for(int i = 0; i < this.contour.size(); i++)
		{
			Point p = contour.get(i);
			x.add(p.x);
			y.add(p.y);
		}
       	Set <Integer> uniqueX = new HashSet <Integer>();
       	uniqueX.addAll(x);
       	List <Integer> xS = new ArrayList <Integer>(uniqueX);
       	Collections.sort(xS);
        int countX = xS.size();
        int maxX = xS.get(xS.size()-1);
        int minX = xS.get(0);
       	////////////////////////////////////////////////////
        Set <Integer> uniqueY = new HashSet <Integer>();
       	uniqueY.addAll(y);
        List <Integer> yS = new ArrayList <Integer>(uniqueY);
        Collections.sort(yS);
        int countY = yS.size();
        int maxY = yS.get(yS.size()-1);
        int minY = yS.get(0);
        
       
        
        int[][] Disp = new int[countY][countX];
        ///////////////////////////////////////////////////////////
    	for(int i = 0; i < this.contour.size(); i++)
		{
			Point p = contour.get(i);
			int cX = p.x - minX;
			int cY = p.y - minY;
			Disp[cY][cX] = 1;
		}
    	///////////////////////////////////////////////////////////

    	
    	
    	for(int i = 0; i < countY; i++)
		{
    		for(int k = 0; k < countX; k++)
    		{
    			if(Disp[i][k] == 1)
    			{
    			// System.out.print(Disp[i][k] + " ");
    			 nX.add(k);
    			 nY.add(i);
    			 pixCount++;
    			}
    			//
    			//	System.out.print("  ");
    		}
    		//System.out.println();
		}
    	
    	//for (int c = 0; c < nX.size(); c++)
    	//	System.out.print(nX.get(c) + "	");
    	
    	//System.out.println();
    	
    	//for (int c = 0; c < nY.size(); c++)
    		//System.out.print(nY.get(c) + "	");
///////////////////////////////////////////////////////

	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////
	public void mapIt() 
	{
		for (int c = 0; c < this.nX.size(); c++)
		{
		int x = this.nX.get(c);
		int y = this.nY.get(c);
			for (int k = 0; k < this.check1.nX.size(); k++)
			{
				int mX = this.check1.nX.get(k);
				int mY = this.check1.nY.get(k);
					if(x == mX && y == mY)
					{
						this.match++;
					}
			}
		}
	}
//////////////////////////////////////////////////////////////////////////////////////////////////
public void diff() 
{
	this.diff = this.pixCount - this.match;
	double count = this.check1.nX.size() * thresholdMinMatched;
	double allowDiff = this.pixCount * thresholdMaxDiff;
	//System.out.println(count);
	if(this.diff <= allowDiff && this.pixCount >= count)
	{
	this.isNote = true;
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////
	public void show() 
	{	
		System.out.println("Group Number: " + this.groupNum);
		System.out.println("Line Number: " + this.lineNum);
		System.out.println("Middle Line: " + this.midLine);
		System.out.println("Expected Height: " + this.heightEst);
		System.out.println("X, Y _ Coordinates.");
		
		for(int i = 0; i < this.contour.size(); i++)
		{
			Point p = contour.get(i);
			p.show();	
		}
		
		
	}
	
	
	// System.out.println("Total pixels: " + this.contour.size());
     //System.out.println("Total different X values: " + countX);
     //System.out.println("Minimum X value: " + minX);
     //System.out.println("Maximum X value: " + maxX);
     //System.out.println("Total different Y values: " + countY);
    // System.out.println("Minimum Y value: " + minY);
   //  System.out.println("Maximum Y value: " + maxY);
//////////////////////////////////////////////////////////////////////////////////////////////////
}
