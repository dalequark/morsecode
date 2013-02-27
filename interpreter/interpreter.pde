import java.util.*;
import processing.serial.*;
import java.awt.*;

Serial myPort;

String current = "";

HashMap<String, Character> language = new HashMap<String, Character>(){{
  put("01", 'A');
  put("1000", 'B');
  put("1010", 'C');
  put("100", 'D');
  put("0", 'E');
  put("0010", 'F');
  put("110", 'G');
  put("0000", 'H');
  put("00", 'I');
  put("0111", 'J');
  put("101", 'K');
  put("0100", 'L');
  put("11", 'M');
  put("10", 'N');
  put("111", 'O');
  put("0110", 'P');
  put("1101", 'Q');
  put("010", 'R');
  put("000", 'S');
  put("1", 'T');
  put("001", 'U');
  put("0001", 'V');
  put("011", 'W');
  put("1001", 'X');
  put("1011", 'Y');
  put("1100", 'Z');
  put("01111", '1');
  put("00111", '2');
  put("00011", '3');
  put("00001", '4');
  put("00000", '5');
  put("10000", '6');
  put("11000", '7');
  put("11100", '8');
  put("11110", '9');
  put("11111", '0');
}};

void morse(String letter) {
 Character result = language.get(letter);
 if (result != null) {
     println(result);
     try {
       Robot haiRobot = new Robot();
       haiRobot.keyPress(result);
     } catch (AWTException e) {
       e.printStackTrace();
     }
 }
 return;
}

void setup() {
  myPort = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  int[] letter = new int[5];
  while (myPort.available() > 0) {
    int inByte = myPort.read();
    if (inByte != 13 && inByte != 10) {
      if (inByte == '2') {
        morse(current);
        current = "";
      }
      if (inByte == '1') {
        current += "1";
      }
      if (inByte == '0') {
        current += "0";
      }
    }
  }
}
