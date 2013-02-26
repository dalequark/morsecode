color backColor = color(102);
String printString = "";
int i = 0;
int buttonWidth = 200;
int buttonHeight = 60;
color buttonColor = color(200);
int buttonX;
int buttonY;
int stringLength = 0;
int charsPerLine = 40;

void setup() {
  size(800, 500);
  buttonY = height*4/5;
  buttonX = width/2 - buttonWidth/2;
  clearScreen();
}
void draw() {
  while(i < 1){
  addchar('a');
  addchar('b');
  addSpace();
  addchar('d');
  i++;
  }
  
  buttonClick();
  
}

void addchar(char a){
  clearScreen();
  printString += a;
  textAlign(CENTER);
  fill(255);
  textFont(createFont("Georgia", 60));
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
  stroke(255);
  fill(255);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  
}

void addSpace()
{
  addchar(' ');
  addchar(' ');
  addchar(' ');
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
  println(stringLength);
  if((stringLength%charsPerLine) == 0)
  {
    addchar('\n');
  }
}
