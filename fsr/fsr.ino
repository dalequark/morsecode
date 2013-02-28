/*----------------------------------------------------------*/
/* fsr.ino                                                  */
/* Raymond Zhong and Farhan Abrol                           */
/* Team TFCS                                                */
/* Lab 1                                                    */
/* Last updated 2/27/13                                     */
/* A simple program for Arduino which takes analog input    */
/* from an FSR and interprets this input as either a 1 or a */
/* 0. Uses a buzzer to acknowledge 0s with a low beep and   */
/* 1s with a high beep. Also starts a timer for accepting   */
/* further 1s and 0s, as indicated by "descending" LED      */
/* diodes. Sends 1s and 0s to serial port, as well as 2s    */
/* whenever the timer runs out.                             */
/*----------------------------------------------------------*/

/*
Connect one end of FSR to power, the other end to Analog 0.
Then connect one end of a 10K resistor from Analog 0 to ground 
*/

int fsrPin = 0;     // the FSR and 10K pulldown are connected to a0
int fsrThreshold = 20;
int fsrReading;     // the analog reading from the FSR resistor divider
int delayTime = 10;
int buzzerPin = 6;

// number of delay loops for each symbol
int dotLength = 1;
int dashLength = 20; // 200ms
int letterSepLength = 100; // 1000ms
int pauseLength;
int tapLength;

// length of tones emitted for each button press
int dotToneLength = 30;
int dashToneLength = 100;

// LED status display
int firstLEDpin = 8;
int numLEDpins = 5;

void setup(void) {
  Serial.begin(9600);   
}

void sendLetterEnd() {
  Serial.println("2");
}

void sendDot() {
  Serial.println("0");
  tone(buzzerPin, 440);
  delay(dotToneLength);
  noTone(buzzerPin);   
}

void sendDash() {
  Serial.println("1");
  tone(buzzerPin, 1000);
  delay(dashToneLength);
  noTone(buzzerPin);
}

void lightLEDs() {
  for (int i = 0; i < numLEDpins; i++) {
    digitalWrite(firstLEDpin + i, 1);
  }
}

void dimLEDs() {
  for (int i = 0; i < numLEDpins; i++) {
    if (pauseLength > i*letterSepLength/numLEDpins) {
      digitalWrite(firstLEDpin + i, 0);
    }
  }
}

void beep() {
}

void loop(void) {
  fsrReading = analogRead(fsrPin);  

  if (fsrReading < fsrThreshold) {
    if (dashLength > tapLength && tapLength > dotLength) {
      sendDot();
      lightLEDs();
    }
    if (pauseLength == letterSepLength) {
      sendLetterEnd();
    }
    dimLEDs();
    tapLength = 0;
    pauseLength++;    
  } else {
    if (tapLength == dashLength) {
      sendDash();
      lightLEDs();
    }
    pauseLength = 0;
    tapLength++;
  }
    delay(delayTime);
}
