/*-----------------------------------------------------*/
/* interpreter.pde                                     */
/* Collin Stedman                                      */
/* Team TFCS                                           */
/* Lab 1                                               */
/* Lasted updated 2/27/13                              */
/* Reads serial data from Arduino, interprets the data */
/* as a series of dots, dashes, and character breaks,  */
/* and identifies the corresponding letter in morse    */
/* code. Then programmatically presses corresponding   */
/* key on keyboard.                                    */
/*-----------------------------------------------------*/

import java.util.*;
import processing.serial.*;
import java.awt.*;

Serial myPort;

//  A string of 1's and 0's corresponding to dashes and dots, respectively
String current = "";

//  A dictionary of morse code strings and their corresponding English
//  characters. The language includes all 26 letters and the numbers 0-9.
//  Note that 0's are dots and 1's are dashes.
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

/*  Given the string of 1's and 0's, treat the string as a morse code
 *  character and find the corresponding English character. Print the
 *  character to stdout and then programmatically press the corresponding
 *  key on the keyboard.
 */
void morse(String letter) {
 Character result = language.get(letter);
 //  If corresponding English character is found...
 if (result != null) {
     println(result); //  Print character to stream for sake of debugging
     //  Create robot to programmatically press corresponding keyboard character
     try {
       Robot haiRobot = new Robot();
       haiRobot.keyPress(result);
     } catch (AWTException e) {
       e.printStackTrace();
     }
 }
 return; //  Return regardless of whether or not character was found
}

//  Initialize serial connection
void setup() {
  myPort = new Serial(this, Serial.list()[0], 9600);
}

/*  Continually read serial data, adding 0's and 1's to current morse code
 *  character string. If a 2 is found, treat character as indicator of the
 *  end of the current morse code character. Pass character to morse(), reset
 *  morse code character string, and continue.
 */
void draw() {
  int[] letter = new int[5]; //  No morse code letter consists of more than 5
                             //  dots and dashes.
  while (myPort.available()) {
    int inByte = myPort.read();
    //  Ignore the \r and \n characters which Arduino prints
    if (inByte != 13 && inByte != 10) {
      //  If '2' is found, pass current string to morse() and reset string
      if (inByte == '2') {
        morse(current);
        current = "";
      }
      //  If '1' is found, concatenate "1" with current string
      if (inByte == '1') {
        current += "1";
      }
      //  If '0' is found, concatenate "0" with current string
      if (inByte == '0') {
        current += "0";
      }
    }
  }
}
