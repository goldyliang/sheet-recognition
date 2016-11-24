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
public class Mask 
{
	List <Integer> nX = new ArrayList<Integer>();
	List <Integer> nY = new ArrayList<Integer>();
	//Mask1
	
	String M1 = "2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10,0,11,0,1,1,2,1,3,1,4,1,5,1,6,1,7,1,8,1,9,1,10,1,11,1,12,1,0,2,1,2,2,2,11,2,12,2,0,3,1,3,11,3,12,3,0,4,1,4,11,4,12,4,0,5,1,5,10,5,11,5,0,6,1,6,9,6,10,6,0,7,1,7,2,7,3,7,4,7,5,7,6,7,7,7,8,7,9,7,0,8,1,8,2,8,3,8,4,8,5,8,6,8,7,8,8,8,0,9,1,9,0,10,1,10";
	List <Point> mask1 = new ArrayList <Point>();
	//////////////////////////////////////////////

	//Constructor
	public Mask()
	{
		this.load1();
		this.cal();
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////
	public void cal()
	{

		/////////////////////////////////////////////////
		List <Integer> x = new ArrayList<Integer>();
		List <Integer> y = new ArrayList<Integer>();
				
		for(int i = 0; i < this.mask1.size(); i++)
		{
			Point p = this.mask1.get(i);
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
        
        //System.out.println();
        
        int[][] Disp = new int[countY][countX];
        ///////////////////////////////////////////////////////////
    	for(int i = 0; i < this.mask1.size(); i++)
		{
			Point p = this.mask1.get(i);
			int cX = p.x - minX;
			int cY = p.y - minY;
			Disp[cY][cX] = 1;
		}
    	///////////////////////////////////////////////////////////

    	
    	//System.out.println();
    	for(int i = 0; i < countY; i++)
		{
    		for(int k = 0; k < countX; k++)
    		{
    			if(Disp[i][k] == 1)
    			{
    			 //System.out.print(Disp[i][k] + " ");
    			 nX.add(k);
    			 nY.add(i);
    			}
    			//else
    				//System.out.print("  ");
    		}
    		//System.out.println();
		}
    	
   // for (int c = 0; c < nX.size(); c++)
    	//	System.out.print(nX.get(c) + "	");
    	
    	//System.out.println();
    	
    	//for (int c = 0; c < nY.size(); c++)
    	//		System.out.print(nY.get(c) + "	");
///////////////////////////////////////////////////////

	}
//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////
	public void load1() 
	{	
		String[] pix = this.M1.split(",");
		for (int i = 0; i < pix.length; i++)
			{
				int x = Integer.parseInt(pix[i]);
				int y = Integer.parseInt(pix[i+1]);
				Point p = new Point(x,y);
				this.mask1.add(p);
				i++;
			}
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////
}
