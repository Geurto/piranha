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

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(LED, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(LED, HIGH);
  delay(1000);
  digitalWrite(LED, LOW);
  delay(1000);
  int value = analogRead(AOUT_PIN);
  Serial.print("Moisture value: ");
  Serial.println(value);
}