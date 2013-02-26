import java.util.*;
import processing.serial.*;

Serial myPort;

String current = "";

HashMap<String, char> language = new HashMap<String, char>(){{
  put("01", 'a');
  put("1000", 'b');
  put("1010", 'c');
  put("100", 'd');
  put("0", 'e');
  put("0010", 'f');
  put("110", 'g');
  put("0000", 'h');
  put("00", 'i');
  put("0111", 'j');
  put("101", 'k');
  put("0100", 'l');
  put("11", 'm');
  put("10", 'n');
  put("111", 'o');
  put("0110", 'p');
  put("1101", 'q');
  put("010", 'r');
  put("000", 's');
  put("1", 't');
  put("001", 'u');
  put("0001", 'v');
  put("011", 'w');
  put("1001", 'x');
  put("1011", 'y');
  put("1100", 'z');
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
}}

void morse(String letter) {
 char result = language.get(letter);
 if (result != null) {
     printf(result);
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
        morse(result);
        result = "";
      }
      if (inByte == '1') {
        result.append('1');
      }
      if (inByte == '0') {
        result.append('0');
      }
    }
  }
}
