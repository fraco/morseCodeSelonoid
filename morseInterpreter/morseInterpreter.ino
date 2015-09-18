char val; // Data received from the serial port
int ledPin =13; // Set the pin to digital I/O 4

void setup() {
  pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
  Serial.begin(9600); // Start serial communication at 9600 bps
  digitalWrite(ledPin, LOW);
}

void loop() {
  
  if (Serial.available()) { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'D') { // If H was received
    digitalWrite(ledPin, HIGH); // turn the LED on
    delay(400);
    digitalWrite(ledPin, LOW);
    delay(150);
  } 
  else if (val == 'P') { // If H was received
    digitalWrite(ledPin, HIGH); // turn the LED on
    delay(200);
    digitalWrite(ledPin, LOW);
    delay(150);
  } 
  else if (val == ' ') { // If H was received
    delay(250);
  }
  else {
    digitalWrite(ledPin, LOW); // Otherwise turn it OFF
  }
  delay(10); // Wait 100 milliseconds for next reading
}

