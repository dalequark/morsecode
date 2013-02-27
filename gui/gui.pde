color backColor = color(102);
String printString = "";
int i = 0;
int buttonWidth = 200;
int buttonHeight = 60;
color buttonColor = color(200);
int buttonX;
int buttonY;
int stringLength = 0;
int charsPerLine = 15;
int lineNumber = 1;
int charSize = 60;

void setup() {
  size(800, 500);
  buttonY = height*4/5;
  buttonX = width/2 - buttonWidth/2;
  clearScreen();
}
void draw() {
  /*
  while(i < 1){
    addchar('a');
    addchar('b');
    addSpace();
    addchar('d');
    i++;
  }
  */
  buttonClick();
}

void keyPressed() {
  addchar(key);
}

void addchar(char a){
  clearScreen();
  printString += a;
  textAlign(CENTER);
  fill(255);
  textFont(createFont("Georgia", charSize));
  text(printString, width/2, 200);
  stringLength++;
  handleLining();
  
}

void clearScreen(){
background(backColor);
  textAlign(CENTER);
  fill(255);
  textFont(createFont("Georgia", 60));
  text("MorseMaker", width/2, 80);
  textFont(createFont("Georgia", 20));
  fill(204);
  text("Beep in now!", width/2, 110);
  fill(255);
  stroke(255);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(102);
  text("Click to add space", width/2, buttonY + buttonHeight/2 + 5);
}

void addSpace()
{
  addchar(' ');
  addchar(' ');
  stringLength--;
}

void buttonClick()  {
  if (mouseX >= buttonX && mouseX <= buttonX+buttonWidth && 
      mouseY >= buttonY && mouseY <= buttonY+buttonHeight
      && mousePressed) 
  {
       addSpace();
       delay(100);
  } 
}

void handleLining()
{
  if((stringLength%charsPerLine) == 0)
  {
    lineNumber++;
    if (lineNumber % 2 == 0) {
      charSize /= 1.4;
    }
    addchar('\n');
    stringLength--;
  }
}
