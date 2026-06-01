#include <Ultrasonic.h>


  int pinoTrigger = 13;  
  int pinoEcho =12; 

  HC_SR04 sensor(pinoTrigger,pinoEcho);

  void setup(){

    Serial.begin (9600);

  }

  void loop(){

    float distancia = sensor.distance();
    
    Serial.println(distancia);


    delay(1000);


    }