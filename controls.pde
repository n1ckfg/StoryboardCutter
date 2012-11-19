void keyPressed() {
  if(!recMode){
  if(keyCode==LEFT) {
    posXarray[counterPanel-1]--;
  } 
  else if(keyCode==RIGHT) {
    posXarray[counterPanel-1]++;
  }

  if(keyCode==UP) {
    posYarray[counterPanel-1]--;
  } 
  else if(keyCode==DOWN) {
    posYarray[counterPanel-1]++;
  }

  if(key==' ') {
    if(counterPanel<=counterPanelMax) {
      counterPanel++;
    }
  }

  if(key=='q') { //test 
    if(counterPanel<=counterPanelMax) {
      counterPanel++;
    }
  }
  }
}
