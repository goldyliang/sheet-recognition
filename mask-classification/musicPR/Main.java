package musicPR;

import java.io.*;
import java.util.*;
import java.util.List;
import java.io.BufferedReader;
import java.io.BufferedWriter;
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

public class Main 
{
	//////////////////////////////////////////////////////////////////////////////////////////
	static List <Point> getPoints(String input)
	{	
		List <Point> points = new ArrayList <Point>();
		String[] content = input.split(",");
		for (int i = 4; i < content.length; i++)
			{
				int x = Integer.parseInt(content[i]);
				int y = Integer.parseInt(content[i+1]);
				Point p = new Point(x,y);
				points.add(p);
				i++;
			}
		return points;
	}
	//////////////////////////////////////////////////////////////////////////////////////////
	
	public static void main(String[] args) throws NumberFormatException, IOException 
	{
		System.out.println(args.length);
		for (int i = 0; i<args.length;i++)
			System.out.println(args[i]);

		String result = "";
		List <Candidate> Notes = new ArrayList <Candidate>();
		FileInputStream fis;
		String sample = args[0];//"C:\\Users\\asad.iftikhar\\Documents\\PR\\in\\out.txt";
		String file = args[1];//"C:\\Users\\asad.iftikhar\\Documents\\PR\\in\\result.txt";

		if (args.length > 2) {
			Candidate.thresholdMinMatched = Double.parseDouble(args[2]);
			Candidate.thresholdMaxDiff = Double.parseDouble(args[3]);
		}

		fis = new FileInputStream(sample);
		BufferedReader fileBuf = new BufferedReader(new InputStreamReader(fis));

		//Mask test = new Mask();
		
		
		String content =  "";
		while ((content = fileBuf.readLine()) != null)
		{
			List <Point> points = getPoints(content);
			String[] line = content.split(",");
			int groupNum = Integer.parseInt(line[0]);
			int lineNum = Integer.parseInt(line[1]);
			int midLine = Integer.parseInt(line[2]);
			int height = Integer.parseInt(line[3]);
			Candidate one = new Candidate(groupNum, lineNum, midLine, height, points);
			Notes.add(one);
		}

				
			System.out.println("Total Candidates : " + Notes.size() + "\n");

			
					
			for(int test = 0; test < Notes.size(); test++)
			{
			//System.out.println("Testing Note : " + test);
			Notes.get(test).compute();
			Notes.get(test).mapIt();
			Notes.get(test).diff();

			result = result + Notes.get(test).groupNum + "\t" + Notes.get(test).lineNum + "\t" +
					String.format ("%.2f",(double)Notes.get(test).pixCount/Notes.get(test).check1.nX.size()) + "\t"+
					String.format ("%.2f",(double)Notes.get(test).diff / Notes.get(test).pixCount);

			if(Notes.get(test).isNote)
			{
				 result = result + "\t" + "1 \n";
			}
			else
			{
				result = result + "\t" + "0 \n";
			}
		//	System.out.println(result);
		//	System.out.println("Note's total unique pixels : " + Notes.get(test).pixCount);
		//	System.out.println("Matching with Mask : " + Notes.get(test).match);
		//	System.out.println("Good Note? : " + Notes.get(test).isNote + "\n");
			}
		//////////////////////////////////////////////////////////////////////////////////////////	
			BufferedWriter writer = new BufferedWriter(new FileWriter(file));
			writer.write(result);//save the string representation of the board
			writer.close();
			System.out.println("Result file generated.");
			
			
			
	}
	

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}
