BufferedReader reader;
PImage mapImage;
Table locationTable;
Table nameTable;
int rowCount;

Table dataTable;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;


void setup() {
  size(480, 800);
  mapImage = loadImage("img.png");
  locationTable = new Table("locations.tsv");
  nameTable = new Table("names.tsv");
  rowCount = locationTable.getRowCount();
  
  dataTable = new Table("random.tsv");
  
  for (int row = 0; row < rowCount; row++) {
    float value = dataTable.getFloat(row, 1);
    if (value > dataMax) {
      dataMax = value;
    }
    if (value < dataMin) {
      dataMin = value;
    }
  }
  
  PFont font = loadFont("Univers-Bold-12.vlw");
  textFont(font);

  smooth();
  noStroke();  
}


// Global variables set in drawData() and read in draw()
float closestDist;
String closestText;
float closestTextX;
float closestTextY;


void draw() {
  background(255);
  image(mapImage, 0, 0);
  
  //text(mouseX + "  " + mouseY,mouseX+50,mouseY+50);
  // Use the built-in width and height variables to set the
  // closest distance high so it will be replaced immediately
  closestDist = width*height;
  

  for (int row = 0; row < rowCount; row++) {
    String abbrev = dataTable.getRowName(row);
    float x = locationTable.getFloat(abbrev, 1);
    float y = locationTable.getFloat(abbrev, 2);
    drawData(x, y, abbrev);
    fill(0);
  text("Maine - Weather data from 3 sources)", 200, 625);
  text("County Seat, County" + " | " + "Weather.gov | WUnderground | AccuWeather", 200, 653);
  }

  // Use global variables set in drawData()
  // to draw text related to closest circle.
  if (closestDist != width*height) {
    fill(0);
    textAlign(CENTER);

    text(closestText, 200, 670);
  }
}

String getGovValue(String abbrev) {
  String url = "";
  if(abbrev.indexOf("roost") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=46.126158742000484&lon=-67.84029620099966&site=all&smap=1#.VVUNpPlVhBc";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("iscat") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=45.18338892000048&lon=-69.22698762099964&site=all&smap=1#.VVURU_lVhBc";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("omers") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.7650565510005&lon=-69.71921693199965&site=all&smap=1#.VVURpvlVhBc";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("rankl") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.662139652324186&lon=-70.11893959018914&site=all&smap=1#.VTkBBPlT75U";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("xfor") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.25978739700048&lon=-70.50061757699967&site=all&smap=1";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("enneb") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.31061938500045&lon=-69.77948908199966&site=all&smap=1";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("enobs") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.8011793440005&lon=-68.77780598999965&site=all&smap=1#.VVUUd_lVhBc";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("ashing") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.71507948600049&lon=-67.46137583299964&site=all&smap=1#.VVUUq_lVhBc";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("aldo") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.42590815300048&lon=-69.00641719899966&site=all&smap=1";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("ancoc") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.54340622400048&lon=-68.41945779599962&site=all&smap=1#.VVUVNPlVhBc";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("nox") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.00285570200049&lon=-69.66559969099967&site=all&smap=1#.VVUVn_lVhBc";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("incol") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=44.09784677100049&lon=-70.23116799199965&site=all&smap=1#.VVUXX_lVhBc";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("ndrosco") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=43.6614665030005&lon=-70.25532634799964&site=all&smap=1#.VVUXivlVhBc";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("unberl") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=43.910636387000466&lon=-69.82059743399964&site=all&smap=1#.VVUX8vlVhBc";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("agadah") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=43.47646992300048&lon=-70.71838924799965&site=all&smap=1#.VVUYJvlVhBc";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("ork") != -1){
    url = "http://forecast.weather.gov/MapClick.php?lat=43.47646992300048&lon=-70.71838924799965&site=all&smap=1";
    return readAndParseURL(url);
  } 
  else {
    return null;
  }
}

String getWunValue(String abbrev) {
  String url = "";
  if(abbrev.indexOf("roost") != -1){
    url = "http://www.wunderground.com/q/zmw:04730.1.99999";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("iscat") != -1){
    url = "http://www.wunderground.com/q/zmw:04426.1.99999";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("omers") != -1){
    url = "http://www.wunderground.com/q/zmw:04426.1.99999";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("rankl") != -1){
    url = "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=04938";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("xfor") != -1){
    url = "http://www.wunderground.com/q/zmw:04426.1.99999";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("enneb") != -1){
    url = "http://www.wunderground.com/q/zmw:04330.1.99999";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("enobs") != -1){
    url = "http://www.wunderground.com/q/zmw:04401.1.99999";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("ashing") != -1){
    url = "http://www.wunderground.com/q/zmw:04654.1.99999";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("aldo") != -1){
    url = "http://www.wunderground.com/q/zmw:04915.1.99999";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("ancoc") != -1){
    url = "http://www.wunderground.com/q/zmw:04605.1.99999";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("nox") != -1){
    url = "http://www.wunderground.com/q/zmw:04841.1.99999";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("incol") != -1){
    url = "http://www.wunderground.com/q/zmw:04578.1.99999";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("ndrosco") != -1){
    url = "http://www.wunderground.com/q/zmw:04210.1.99999";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("unberl") != -1){
    url = "http://www.wunderground.com/q/zmw:04101.1.99999";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("agadah") != -1){
    url = "http://www.wunderground.com/q/zmw:04530.1.99999";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("ork") != -1){
    url = "http://www.wunderground.com/q/zmw:04002.1.99999";
    return readAndParseURL(url);
  } 
  else {
    return null;
  }
}

String getAccValue(String abbrev) {
  String url = "";
  if(abbrev.indexOf("roost") != -1){
    url = "http://www.accuweather.com/en/us/houlton-me/04730/weather-forecast/333492";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("iscat") != -1){
    url = "http://www.accuweather.com/en/us/dover-foxcroft-me/04426/weather-forecast/333489";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("omers") != -1){
    url = "http://www.accuweather.com/en/us/skowhegan-me/04976/weather-forecast/847";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("rankl") != -1){
    url = "http://www.accuweather.com/en/us/farmington-me/04938/weather-forecast/333491";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("xfor") != -1){
    url = "http://www.accuweather.com/en/us/paris-me/04281/weather-forecast/2183517";
    return readAndParseURL(url);
  }
  else if(abbrev.indexOf("enneb") != -1){
    url = "http://www.accuweather.com/en/us/augusta-me/04330/weather-forecast/333496";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("enobs") != -1){
    url = "http://www.accuweather.com/en/us/bangor-me/04401/weather-forecast/329156";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("ashing") != -1){
    url = "http://www.accuweather.com/en/us/machias-me/04654/weather-forecast/333493";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("aldo") != -1){
    url = "http://www.accuweather.com/en/us/belfast-me/04915/weather-forecast/333488";
    return readAndParseURL(url);
  }  
  else if(abbrev.indexOf("ancoc") != -1){
    url = "http://www.accuweather.com/en/us/ellsworth-me/04605/weather-forecast/333490";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("nox") != -1){
    url = "http://www.accuweather.com/en/us/rockland-me/04841/weather-forecast/333494";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("incol") != -1){
    url = "http://www.accuweather.com/en/us/rockland-me/04841/weather-forecast/333494";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("ndrosco") != -1){
    url = "http://www.accuweather.com/en/us/auburn-me/04210/weather-forecast/333499";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("unberl") != -1){
    url = "http://www.accuweather.com/en/us/portland-me/04101/weather-forecast/329157";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("agadah") != -1){
    url = "http://www.accuweather.com/en/us/bath-me/04530/weather-forecast/333497";
    return readAndParseURL(url);
  } 
  else if(abbrev.indexOf("ork") != -1){
    url = "http://www.accuweather.com/en/us/alfred-me/04002/weather-forecast/333498";
    return readAndParseURL(url);
  } 
  else {
    return null;
  }
}



void drawData(float x, float y, String abbrev) { 
  float radius = 0;
  /** if (value >= 0) {
    radius = map(value, 0, dataMax, 1.5, 15);
    fill(#333366);  // blue
  } else {
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#ec5166);  // red
  } */
  fill(255,20,20);
  ellipseMode(RADIUS);
  radius = 5;
  ellipse(x, y, radius, radius);

  float d = dist(x, y, mouseX, mouseY);
  // Because the following check is done each time a new
  // circle is drawn, we end up with the values of the
  // circle closest to the mouse.
  if ((d < radius + 2) && (d < closestDist)) {
    closestDist = d;
    String name = nameTable.getString(abbrev, 1);
    String govValue = getGovValue(abbrev);
    String wunValue = getWunValue(abbrev);
    String accValue = getAccValue(abbrev);
    closestText = name + " " + govValue + " | " + wunValue + " | " + accValue;
    text(abbrev,125, 690);
    closestTextX = x;
    closestTextY = y-radius-4;
  }
}

String readAndParseURL(String url) {
  String data = "";  
  reader = createReader(url);
    String html="";
    try {
      String line = reader.readLine();
      while(line != null) {
        html += line;
        line = reader.readLine();
      }
    }
  
  catch(Exception e) {
    println("Error parsing file: " + e.toString());
    }
  
  if(url.indexOf("weather.gov") != -1) {
    int loc = html.indexOf("myforecast-current-lrg");
    return html.substring(loc+24,loc+26).trim();
  }
  else if(url.indexOf("wunderground.com") != -1) {
    int loc = html.indexOf("curTemp");
    return html.substring(loc+134,loc+138).trim();
  }
  else if(url.indexOf("accuweather.com") != -1) {
    int loc = html.indexOf("temp");
    return html.substring(loc+6,loc+8).trim();
  }
  else {
    return null;
  }
}
