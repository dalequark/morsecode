/*-------------------------------------------------------*/
/* gui.pde                                               */
/* Collin Stedman                                        */
/* Team TFCS                                             */
/* Lab 1                                                 */
/* Lasted updated 2/27/13                                */
/* The GUI for our FSR implementation of a morse code    */
/* oscillator. Prints typed characters and provides two  */
/* buttons, one for adding spaces and the other for      */
/* clearing the output.                                  */
/*-------------------------------------------------------*/

//  Text string global variables
String printString = "";
int stringLength = 0;
int charsPerLine = 15;
int lineNumber = 1;
int charSize = 60;

//  Button size in pixels
int buttonWidth = 200;
int buttonHeight = 60;

//  Button coordinates
int spaceButtonX;
int spaceButtonY;
int clearButtonX;
int clearButtonY;

//  Global GUI colors
color backColor = color(102);
color buttonColor = color(200);

//  Initialize screen size and button placement.
void setup() {
  size(800, 500);
  spaceButtonY = height*4/5;
  spaceButtonX = width/4 - buttonWidth/2;
  clearButtonY = spaceButtonY;
  clearButtonX = width - spaceButtonX - buttonWidth;
  clearScreen();
}

//  Continually waits for button press events. Also resets
//  screen if more than 80 characters have been typed
void draw() {
  if (stringLength > 80) {
     reset();
     addchar(key); //  After reset, retype most recent char
  }
  spaceButtonClick();
  clearButtonClick();
}

//  Add most recently pressed key to string
void keyPressed() {
  addchar(key);
}

//  Add char to the current string.
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

//  Create the base GUI screen
void clearScreen(){
background(backColor);
  textAlign(CENTER);
  fill(255); //  White
  textFont(createFont("Georgia", 60));
  text("MorseMaker", width/2, 80);
  textFont(createFont("Georgia", 20));
  fill(buttonColor);
  text("Beep in now!", width/2, 110);
  fill(255); //  White
  stroke(255);  //  White
  rect(spaceButtonX, spaceButtonY, buttonWidth, buttonHeight); //  Space button
  rect(clearButtonX, clearButtonY, buttonWidth, buttonHeight); //  Clear button
  fill(100); // Gray
  text("Click to add space", width/4, spaceButtonY + buttonHeight/2 + 5);
  text("Click to clear text", width*3/4, clearButtonY + buttonHeight/2 + 5);
}

//  Add space chars to the string. Since one char isn't 
//  sufficient, we add two.
void addSpace()
{
  addchar(' ');
  addchar(' ');
  stringLength--; //  Count addSpace() as adding one char instead of two
}

//  On button click, add a space to the string
void spaceButtonClick()  {
  if (mouseX >= spaceButtonX && mouseX <= spaceButtonX+buttonWidth && 
      mouseY >= spaceButtonY && mouseY <= spaceButtonY+buttonHeight
      && mousePressed) 
  {
    addSpace();
    delay(100); //  Delay so that the user doesn't accidentally hold down
                //  click and add multiple spaces.
  } 
}

//  One button click, clear the string completely
void clearButtonClick() {
  if (mouseX >= clearButtonX && mouseX <= clearButtonX+buttonWidth && 
      mouseY >= clearButtonY && mouseY <= clearButtonY+buttonHeight
      && mousePressed)
  {
    reset();
  }
}

//  Create empty string and return all corresponding global variables
//  to their original values.
void reset() {
  printString="";
  lineNumber = 1;
  charSize = 60;
  stringLength = 0;
  clearScreen();
}

//  Add a newline character once the string reaches a certain length
//  in order to avoid exceeding screen bounds.
void handleLining()
{
  if((stringLength%charsPerLine) == 0)
  {
    lineNumber++;
    //  Every few lines...
    if (lineNumber % 2 == 0) {
      charSize /= 1.4; //  Shrink text to prevent new lines from extending
                       //  below onscreen buttons
    }
    addchar('\n');
    stringLength--; //  Don't include newline in string length
  }
}
