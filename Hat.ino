
#include <Adafruit_GFX.h>   // Core graphics library
#include <RGBmatrixPanel.h> // Hardware-specific library
#include <String.h>
#include "BMPs.h"

// If your 32x32 matrix has the SINGLE HEADER input,
// use this pinout:
#define CLK 11  // MUST be on PORTB!
#define OE  9
#define LAT 10
#define A   A0
#define B   A1
#define C   A2
#define D   A3

RGBmatrixPanel matrix(A, B, C, D, CLK, LAT, OE, false);
int normalizeValue(int);
void drawPicture(const int, const int, const int);


void setup() {
  matrix.begin();
}

void loop() {
  levelUp(1);
}

int normalizeValue(int hex) {
  // Range is between 0-7, 0 is off, 7 is full sat
  // FF/24=7
  return hex / 24;
}

void drawPicture(const int red[], const int green[], const int blue[]) {
  // Send in a normalized value of the hex value of the color
  int i, j, pix;
  pix = 0;
  for (i = 0; i < 32; i++) { // Row
    for (j = 31; j >= 0 ; j--) { // Column
      matrix.drawPixel(i, j, matrix.Color333(normalizeValue(pgm_read_word(&red[pix])), normalizeValue(pgm_read_word(&green[pix])), normalizeValue(pgm_read_word(&blue[pix]))));
      pix++;
    }
  }
}

/* ===================GRAPHIC FUNCTIONS===================================================*/

void levelUp (int repeat) { // Level Up Graphic
  for (int i = 0; i < repeat; i++) {
    drawPicture(levelup_Red, levelup_Green, levelup_Blue);
    delay(10);
    drawPicture(levelup1_Red, levelup1_Green, levelup1_Blue);
    delay(10);
    drawPicture(levelup2_Red, levelup2_Green, levelup2_Blue);
    delay(10);
    drawPicture(levelup3_Red, levelup3_Green, levelup3_Blue);
    delay(10);
    drawPicture(levelup4_Red, levelup4_Green, levelup4_Blue);
    delay(10);
    drawPicture(levelup5_Red, levelup5_Green, levelup5_Blue);
    delay(10);
    drawPicture(levelup6_Red, levelup6_Green, levelup6_Blue);
    delay(10);
  }
}
