/*
 * Script to read out moisture values from capacitive moisture sensor.
 * Calibration:
 * - dry (no water for 10 days): ~2800
 * - directly after watering: ~1250
 * - a few minutes after watering: ~1100 
 */
#include <Arduino.h>

#define LED 2
#define AOUT_PIN 15

float calculateMoisture(int value) {
  int dry = 2800;
  int wet = 1100;
  float moisture_percentage = (float)((dry - value) / (dry - wet));
  moisture_percentage = max(0.0f, min(1.0f, moisture_percentage));
  return round(moisture_percentage * 20.0) / 20.0;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(LED, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(LED, HIGH);
  delay(500);
  digitalWrite(LED, LOW);
  delay(500);

  int value = analogRead(AOUT_PIN);
  Serial.println(value);
  //Serial.println(calculateMoisture(value));  // for now, send the value through directly

}