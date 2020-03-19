package processing.test.parsecoronavirussa;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class parseCoronavirusSA extends PApplet {


Table table;
String[] provinceNames = {"WC", "KZN", "GP", "MP", "LP", "NW", "FS", "EC", "NC"};
int[] provinces = {0, 0, 0, 0, 0, 0, 0, 0, 0};
int[] lat = {110, 370, 305, 360, 325, 235, 250, 250, 130};
int[] lon = {355, 210, 140, 125, 65, 145, 225, 315, 240};

PImage map1;
public void setup() {
 
//  colorMode(HSB, 255);
textSize(20);
  map1 = loadImage("map.gif");
  background(map1);
  //offline for testing:
//  table = loadTable("data.csv", "header, csv");
  //online:
  table = loadTable("https://raw.githubusercontent.com/dsfsi/covid19za/master/data/covid19za_timeline_confirmed.csv", "header, csv");

  for (TableRow row : table.rows()) {
    
    String num = row.getString("case_id");
    String province = row.getString("province");
    
    for(int i = 0; i < provinces.length; i++){
      if(province.equals(provinceNames[i])){
        provinces[i]++;
      }
    }
   //test print all data: 
    println(num);     
    println("province: " + province);
    println("");
  }

//  println(table.getRowCount() + " total rows in table"); 
for(int i = 0; i < provinces.length; i++){
  fill(0);
//  text("total " + provinceNames[i] + ": " + provinces[i], 20, 30*i+30);
text(provinces[i], lat[i], lon[i]);
println("total " + provinceNames[i] + ": " + provinces[i]);
//fill(random(100));
//ellipse(150*i, 100, 2*provinces[i], 2*provinces[i]);
}



  
}



  public int sketchWidth() { return 450; }
  public int sketchHeight() { return 383; }
}
