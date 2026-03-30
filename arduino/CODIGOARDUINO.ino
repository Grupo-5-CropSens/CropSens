#include <Ultrasonic.h>


  int pinoTrigger = 13;  
  int pinoEcho =12; 

  HC_SR04 sensor(pinoTrigger,pinoEcho);

  void setup(){

    Serial.begin (9600);

  }

  void loop(){

    float distancia = sensor.distance();

    if (distancia > 0 && distancia < 5){

      // Serial.println("Tem Objeto");
      Serial.println(distancia);
    }

    else{

      Serial.println(distancia);
        // Serial.println("Não tem Objeto");
    }


    delay(1000);


    }