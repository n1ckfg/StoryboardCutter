boolean recMode = false;  //true renders directly; false lets you pick coordinates first

// note: assumes your storyboard files have six panels per page
// and are numbered from 1.
int sW = 1024;  // width and height of your individual panels
int sH = 576;
//int fps = 24;
String fileName = "shot";
String fileFormat = "png";
String fileDir = "render";
String sourceName = "page_";
String sourceFormat = "png";

PFont font;
int fontSize = 18;
int counterBoard = 1;
int counterBoardMax = 3;
ArrayList photoArrayNames;
PImage img;
boolean loaded = false;
int counterPanel = 1;
int counterPanelMax = 6;
int counterShot = 1;
float[] posXarray = { -15,-1210,-15,-1210,-15,-1210 };
float[] posYarray = { -228,-228,-1212,-1212,-2196,-2196 };
String console1,console2;
float buttonSize = 30;
float buttonX  = width-buttonSize; 
float buttonY = buttonSize;
color buttonColor = color(255,0,0);

void setup() {
  Settings settings = new Settings("settings.txt");
  countFrames();
  counterBoardMax = photoArrayNames.size();
  size(sW,sH);
  //frameRate(fps);
  font = createFont("Arial",fontSize);
}

void draw() {
    if(counterPanel>counterPanelMax&&!recMode) {
      counterBoard=1;
      counterPanel=1;
      recMode=true;
    }
  background(50,0,100);
  if (counterBoard<=counterBoardMax){
    if(!loaded){
      img = loadImage((String)photoArrayNames.get(counterBoard-1));
      loaded=true;
    }
  image(img,posXarray[counterPanel-1],posYarray[counterPanel-1]);
  console();
  }
  if(!recMode) {
    if(mousePressed) {  // use mouse to adjust panel position
      posXarray[counterPanel-1] += mouseX-pmouseX;
      posYarray[counterPanel-1] += mouseY-pmouseY;
    }

    fill(150,0,0);
    stroke(0);
    textFont(font,fontSize);
    text(console1,fontSize,1.5*fontSize);
    text(console2,fontSize,3.25*fontSize);
  } else if (recMode) {
    if(counterBoard<=counterBoardMax) {
      if(counterPanel<counterPanelMax) {
        counterPanel++;
      } else {
        counterPanel=1;
        loaded=false;
        counterBoard++;
      }
    }
    else if (counterBoard>counterBoardMax){
      exit();
    }
    saveFrame(fileDir + "/" + fileName + "_" + counterShot + "." + fileFormat);
    counterShot++;
    if(counterShot>6*photoArrayNames.size()) exit();
  }
}

void console(){
      console1 = "board: " + counterBoard + "   panel: " + counterPanel + "   shot: " + counterShot;
    console2 = "1. " + int(posXarray[0]) + "," + int(posYarray[0]) + "   /   " + "2. " + int(posXarray[1]) + "," + int(posYarray[1]) + "   /   " + "3. " + int(posXarray[2]) + "," + int(posYarray[2]) + "   /   " + "4. " + int(posXarray[3]) + "," + int(posYarray[3]) + "   /   " + "5. " + int(posXarray[4]) + "," + int(posYarray[4]) + "   /   " + "6. " + int(posXarray[5]) + "," + int(posYarray[5]);
if(recMode){println(console1);
}else{
println(console2);
println("recMode: " + recMode + "   board: " + counterBoard + "   panel: " + counterPanel);
}
}

void countFrames() {
  photoArrayNames = new ArrayList();
    try {
        //loads a sequence of frames from a folder
        File dataFolder = new File(sketchPath, "data/"); 
        String[] allFiles = dataFolder.list();
        for (int j=0;j<allFiles.length;j++) {
          if (allFiles[j].toLowerCase().endsWith("png")||allFiles[j].toLowerCase().endsWith("jpg")||allFiles[j].toLowerCase().endsWith("jpeg")||allFiles[j].toLowerCase().endsWith("gif")||allFiles[j].toLowerCase().endsWith("tga")) {
            photoArrayNames.add(allFiles[j]);
          }
        }
    }catch(Exception e){ }
  }

