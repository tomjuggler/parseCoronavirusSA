////////////////////new total://///////////////
JSONArray values;
JSONObject corona;
//////////////////////////////////////////////
Table table;
String[] provinceNames = {"WC", "KZN", "GP", "MP", "LP", "NW", "FS", "EC", "NC", "UNKNOWN", "total"};

int[] provinces = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int[] lat = {110, 370, 305, 360, 325, 235, 250, 250, 130, 290, 340};
int[] lon = {355, 210, 130, 125, 65, 145, 225, 315, 240, 370, 350};
int total = 0;

PImage map1;

void setup() {
  total = 0; //double check we get this right at the start
  noLoop(); //new try this
  size(800, 800);

  textSize(20);
  map1 = loadImage("map.gif");
  background(0);
  image(map1, 0, 0, width, height);

  //offline for testing:
  //  table = loadTable("data.csv", "header, csv");

  //online:  
  table = loadTable("https://raw.githubusercontent.com/dsfsi/covid19za/master/data/covid19za_provincial_cumulative_timeline_confirmed.csv", "header, csv");
  for (TableRow row : table.rows()) {
    total++;
  }
  println(total);

  TableRow row = table.getRow(total-1);
  //println(row);

  /////////////////////////////////////////////Error Check: ///////////////////////////////////////////////////////
  // these dssi guys are making problems with the data, the provincial data could be 0 or null... check for that:
  //check for 0 data in provinces (this happened on 1st April, what a joke):
  if (row.getInt(provinceNames[0]) == 0) {
    total--; //use previous row then if 0
    row = table.getRow(total-1);
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  for (int i = 0; i < provinces.length; i++) {
    int provinceData = row.getInt(provinceNames[i]); //number of cases in eg EC loaded
    provinces[i] = provinceData; 
    //println(provinces[i]);
  }


  for (int i = 0; i < provinces.length; i++) {
    fill(0);
    //adjust text co-ordinates
    float latAdj = map(lat[i], 0, 450, 0, width);
    float lonAdj = map(lon[i], 0, 383, 0, height);
    text(provinces[i], latAdj, lonAdj);
    println("total " + provinceNames[i] + ": " + provinces[i]);
  }

  //add unknown province:
  float latAdj2 = map(290, 0, 450, 0, width);
  float lonAdj2 = map(370, 0, 383, 0, height);
  text("unknown province:", latAdj2-180, lonAdj2);
}
