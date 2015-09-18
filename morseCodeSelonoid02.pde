//Morse Code Selonoid by Fraco 

// Morse Code Translator by Julian Kraan, at OpenProcessing *@*http://www.openprocessing.org/sketch/134812*@*
// User [Keyboard] Input  Example 18-1 by Daniel Shiffman, at http://www.learningprocessing.com
// Serial Communication SimpleWrite by Processing's examples

import processing.serial.*;

String textInput;
String textToMorse;
String textToMorseDD;

PFont f;
String typing = ""; // Variable to store text currently being typed
String saved = ""; // Variable to store saved text when return is hit
String savedTr = "";

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port
boolean morse;

int indent;
PImage bkg;

void setup() {
  size(displayWidth, displayHeight);
  f = createFont("Gotham-ExtraLight-38", 38, true);

  println(Serial.list());
  ///—Serial Communication
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);  
  println(myPort);

  indent = width/2;
  bkg = loadImage("bkgndImage.png");
}

void draw() {
  // background(21);
  imageMode(CENTER);
  image(bkg, width/2, height/2);
  ///—Morse Translation Variables
  textInput = typing;
  textToMorse = encodeMorseCode(textInput);
  textToMorseDD = encodeMorseCodeDD(textInput);

  ///—Keyboard Input

    textFont(f); // Set the font and fill for text
  fill(156);
  // Display everything
  textAlign(CENTER, TOP);
  text("Type the text to translate. \n Hit ENTER to translate. \n Hit ENTER again to restart", indent, 40);
  fill(38);
  text(typing, indent, height/2);
  text(saved, indent, height/2);
  text(textToMorseDD, indent, height/1.5);
  text(savedTr, indent, height/1.5);
}

void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
    //    println(textToMorse);
    myPort.write(textToMorse);
    saved = typing; // A String can be cleared by setting it equal to ""
    savedTr = textToMorseDD;
    typing = "";
  } else { // Otherwise, concatenate the String  
    // Each character typed by the user is added to the end of the String variable.
     
    typing = typing + key;
  }
}

void keyReleased() {
  morse = true;
  //  println(textToMorse);
}

String encodeMorseCode(String in_string) {

  String TextInput = in_string.toLowerCase();
  String MorseCode = new String();

  String[] AlphabetArray = {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
  };
  String[] MorseCodeArray = {
    "PD", "DPPP", "DPDP", "DPP", "P", "PPDP", "DDP", "PPPP", "PP", "PDDD", "DPD", "PDPP", "DD", 
    "DP", "DDD", "PDDP", "DDPD", "PDP", "PPP", "D", "PPD", "PPPD", "PDD", "DPPD", "DPDD", "DDPP"
  };
  String[] MorseCodeTrArray = {
    "._", "_...", "_._.", "_..", ".", ".._.", "__.", "....", "..", ".___", "_._", "._..", "__", 
    "_.", "___", ".__.", "__._", "._.", "...", "_", ".._", "..._", ".__", "_.._", "_.__", "__.."
  };

  for (int i=0; i<TextInput.length (); i++) {
    for (int j=0; j<AlphabetArray.length; j++) {
      if (String.valueOf(TextInput.charAt(i)).equals(AlphabetArray[j])) {
        MorseCode += MorseCodeArray[j] + " " ;
      }
    }
  }
  return MorseCode;
}

String encodeMorseCodeDD(String in_string) {
  String TextInput = in_string.toLowerCase();
  String MorseCodeTr = new String();

  String[] AlphabetArray = {
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
  };
  String[] MorseCodeTrArray = {
    "._", "_...", "_._.", "_..", ".", ".._.", "__.", "....", "..", ".___", "_._", "._..", "__", 
    "_.", "___", ".__.", "__._", "._.", "...", "_", ".._", "..._", ".__", "_.._", "_.__", "__.."
  };

  for (int i=0; i<TextInput.length (); i++) {
    for (int j=0; j<AlphabetArray.length; j++) {
      if (String.valueOf(TextInput.charAt(i)).equals(AlphabetArray[j])) {
        MorseCodeTr += MorseCodeTrArray[j] + " " ;
      }
    }
  } 
  return MorseCodeTr;
}
