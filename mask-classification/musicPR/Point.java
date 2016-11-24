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

public class Point 
{
	int x;
	int y;
	
	//Constructor
	public Point(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////
	public void show() 
	{	
	System.out.println("[X, Y] : " + this.x + " " + this.y);
	}
}
