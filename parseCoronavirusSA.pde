////////////////////new total://///////////////
import http.requests.*;
JSONArray values;
JSONObject corona;
//////////////////////////////////////////////
Table table;
String[] provinceNames = {"WC", "KZN", "GP", "MP", "LP", "NW", "FS", "EC", "NC"};
int[] provinces = {0, 0, 0, 0, 0, 0, 0, 0, 0};
int[] lat = {110, 370, 305, 360, 325, 235, 250, 250, 130};
int[] lon = {355, 210, 140, 125, 65, 145, 225, 315, 240};
int total = 0;

PImage map1;

void setup() {
  total = 0; //double check we get this right at the start
  noLoop(); //new try this
  size(800, 800);
  /////////////////////new total://////////////////////////////
    GetRequest get3 = new GetRequest("http://thevirustracker.com/free-api?countryTotal=ZA"); 
  get3.send(); // program will wait untill the request is completed
  corona = parseJSONObject(get3.getContent()); 
    values = corona.getJSONArray("countrydata");
   JSONObject valueObj = values.getJSONObject(0);
    int newTotal = valueObj.getInt("total_cases");
///////////////////////////now we have total////////////////////
//  colorMode(HSB, 255);
textSize(20);
  map1 = loadImage("map.gif");
  background(0);
  image(map1, 0, 0, width, height);
  //background(map1);
  //offline for testing:
//  table = loadTable("data.csv", "header, csv");
  //online:
  table = loadTable("https://raw.githubusercontent.com/dsfsi/covid19za/master/data/covid19za_timeline_confirmed.csv", "header, csv");

  for (TableRow row : table.rows()) {
    total++;
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
//adjust text co-ordinates
float latAdj = map(lat[i], 0, 450, 0, width);
float lonAdj = map(lon[i], 0, 383, 0, height);
text(provinces[i], latAdj, lonAdj);
println("total " + provinceNames[i] + ": " + provinces[i]);
//fill(random(100));
//ellipse(150*i, 100, 2*provinces[i], 2*provinces[i]);
}
float latAdj = map(340, 0, 450, 0, width);
float lonAdj = map(350, 0, 383, 0, height);
text(newTotal, latAdj, lonAdj); //total or newTotal.. newTotal more up to date
}
