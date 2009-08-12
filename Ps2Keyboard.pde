/**
 * PS2Keyboard
 *
 * Read keypresses from a PS/2 or AT keyboard, or a USB keyboard
 * connected via a PS/2 adaptor.
 *
 * Copyright 2009 Jonathan Oxer <jon@oxer.com.au>
 * Copyright 2009 Hugh Blemings <hugh@blemings.org>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version. http://www.gnu.org/licenses/
 *
 * www.practicalarduino.com/projects/easy/ps2-keyboard-or-mouse
 */

// Requires the use of the "PS2Keyboard" library
#include <PS2Keyboard.h>

// The PS/2 'DATA' pin connects to Arduino's digital input 4
#define DATA_PIN 4

// Create a PS2Keyboard object called "keyboard". The PS2Keyboard library hard-codes
// the PS/2 'CLOCK' pin to Arduino's digital input 3
PS2Keyboard keyboard;

/**
 */
void setup()
{
  keyboard.begin(DATA_PIN);

  // Set up the serial connection to report keypresses to the host
  Serial.begin(38400);
  Serial.println("Initialised PS/2 reader");
  delay(1000);
}


/**
 * Main program loop
 */
void loop()
{
  if(keyboard.available()) {
    byte data = keyboard.read();

    // Test for special keys and handle them appropriately
    if(data == PS2_KC_BREAK) {
      Serial.print("[BREAK]");
    } else if(data == PS2_KC_ENTER) {
      Serial.println("");
    } else if(data == PS2_KC_ESC) {
      Serial.print("[ESC]");
    } else if(data == PS2_KC_KPLUS) {
      Serial.print("+");
    } else if(data == PS2_KC_KMINUS) {
      Serial.print("-");
    } else if(data == PS2_KC_KMULTI) {
      Serial.print("*");
    } else if(data == PS2_KC_NUM) {
      Serial.print("[NUMLOCK]");
    } else if(data == PS2_KC_BKSP) {
      Serial.print("[BACKSPACE]");
    } else {
      // Not a special key so print it directly
      Serial.println(data, HEX);
    }
  }
}
