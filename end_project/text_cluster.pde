class TextCluster
{
  String url;

  TextCluster(String _url)
  {
    url = _url;
  }

  void add_boids() {
    int currentX = 50;         //setting the starting X-point 
    int currentY = 50;         //setting the sarting Y-point
    int i = 0;                    
    while (currentY<height-100) {
      while (currentX<width-100 && i<=words.length-1) {
        PVector loc = new PVector(currentX, currentY);
        PVector vel = new PVector(0, 0);
        tbs.add(new TextBoid(words[i], loc, vel, 255));    
        currentX += textWidth(words[i]);                  //calculate the width of each word
        currentX+= textWidth(" ");
        i++;
      }
      currentX = 50;
      currentY+=20;
    }
  }

  void splitToWords() {

    try {
      lines = loadStrings(url);  //try to load the data,  the text file should be in the data folder
    }
    catch(Exception e) {
      println(e);
      lines = null;
    } 
    if (lines != null) {
      String allthetext = join(lines, " ");
      words = splitTokens(allthetext, " ,.:;/'()[]!");            //take out the unnecessary characters.
    }
  }

}
