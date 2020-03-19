
Table table;
String[] provinceNames = {"WC", "KZN", "GP", "MP", "LP", "NW", "FS", "EC", "NC"};
int[] provinces = {0, 0, 0, 0, 0, 0, 0, 0, 0};

void setup() {
  size(500, 500);
  colorMode(HSB, 255);
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
  text("total " + provinceNames[i] + ": " + provinces[i], 20, 50*i+50);
println("total " + provinceNames[i] + ": " + provinces[i]);
//fill(random(100));
//ellipse(150*i, 100, 2*provinces[i], 2*provinces[i]);
}

  
}


