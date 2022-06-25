
#include <Servo.h>
#include <DHT.h>
#include <ArduinoJson.h>

int SENSOR = 3;
 
// Inicializamos el sensor DHT11
DHT dht(SENSOR, DHT11);

Servo servo1;
Servo servo2;
Servo servo3;

String inputString = "";

int win1 = 2;
int win2 = 12;
int win3 = 4;

int door1 = 5;
int door2 = 6;

int belt = 7;

int echo1 = 8;
int trigger1 = 9;

int echo2 = 10;
int trigger2 = 11;

int temp,tempNow, hum, humNow;
int waterLevel,waterNow,foodLevel,foodNow;

long time1,time2,time3,time4;

int sensorTime = 4;//Segundos

const char * water = "whater";
const char * food = "food";
const char * humidity = "humidity";
const char * temperature = "temperature";


void setup() {
  servo1.attach(win1);
  servo2.attach(win2);
  servo3.attach(win3);
  pinMode(door1,OUTPUT);
  pinMode(door2,OUTPUT);
  pinMode(belt,OUTPUT);

  pinMode(trigger1,OUTPUT);
  pinMode(echo1,INPUT);
  pinMode(trigger2,OUTPUT);
  pinMode(echo2,INPUT);
  dht.begin();

  time1 = millis();
  time2 = millis();
  time3 = millis();
  time4 = millis();
  
  // put your setup code here, to run once:
  Serial.begin(9600);
  delay(500);
  waterLevel = ping(trigger1,echo1);
  foodLevel = ping(trigger2,echo2);
  hum = dht.readHumidity();
  temp = dht.readTemperature();

  waterNow = waterLevel;
  foodNow = foodLevel;
  humNow = hum;
  tempNow = temp;

  sensorMessage("water",waterLevel);
  Serial.println("");
  sensorMessage("food",foodLevel);
  Serial.println("");
  sensorMessage("humidity",hum);
  Serial.println("");
  sensorMessage("temperature",temp);
  Serial.println("");
}

void loop() {
  // put your main code here, to run repeatedly:
    waterLevel = ping(trigger1,echo1);
    foodLevel = ping(trigger2,echo2);
    hum = dht.readHumidity();
    temp = dht.readTemperature();
    
    if(waterLevel >= waterNow-10 && waterLevel <= waterNow+10 ){
      waterNow = waterLevel;
    }else{
      sensorMessage("water",waterLevel);
      Serial.println("");
      waterNow = waterLevel;
    }
    if(foodLevel >= foodNow-10 && foodLevel <= foodNow+10){
      foodNow = foodLevel;
    }else{
      sensorMessage("food",foodLevel);
      Serial.println("");
      foodNow = foodLevel;
    }
    if(hum == humNow){
      humNow = hum;
    }else{
      sensorMessage("humidity",hum);
      Serial.println("");
      humNow = hum;
    }
    if(temp == tempNow){
      tempNow = temp;
    }else{
      sensorMessage("temperature",temp);
      Serial.println("");
      tempNow = temp;
    }
    /*if(millis()-time4 > sensorTime*1100){
      if(temp == tempNow){
        tempNow = temp;
      }else{
        sensorMessage("temperature",temp);
        Serial.println("");
        tempNow = temp;
      }
      time4 = millis();
    }*/

  if(Serial.available() > 0){
    
    inputString = Serial.readStringUntil('\n');
    inputString.trim();
    if(inputString.equals("window1-true")){
      servo1.write(90);
    }
    if(inputString.equals("window1-false")){
      servo1.write(0);
    }
    if(inputString.equals("window2-true")){
      servo2.write(90);
    }
    if(inputString.equals("window2-false")){
      servo2.write(0);
    }
    if(inputString.equals("window3-true")){
      servo3.write(90);
    }
    if(inputString.equals("window3-false")){
      sensorMessage("window3",0);
      servo3.write(0);
    }
    
    if(inputString.equals("door1-true")){
      digitalWrite(door1,HIGH);
    }
    if(inputString.equals("door1-false")){
      digitalWrite(door1,LOW);
    }
    if(inputString.equals("door2-true")){
      digitalWrite(door2,HIGH);
    }
    if(inputString.equals("door2-false")){
      digitalWrite(door2,LOW);
    }
    if(inputString.equals("belt-true")){
      digitalWrite(belt,HIGH);
    }
    if(inputString.equals("belt-false")){
      digitalWrite(belt,LOW);
    }
  }
}

void sensorMessage(const char* sensor,int value){
  StaticJsonDocument<200>  doc;
  doc[sensor] = value;
  serializeJson(doc,Serial);
}

int ping(int TriggerPin, int EchoPin) {
   long duration, distanceCm;
   
   digitalWrite(TriggerPin, LOW);  //para generar un pulso limpio ponemos a LOW 4us
   delayMicroseconds(4);
   digitalWrite(TriggerPin, HIGH);  //generamos Trigger (disparo) de 10us
   delayMicroseconds(10);
   digitalWrite(TriggerPin, LOW);
   
   duration = pulseIn(EchoPin, HIGH);  //medimos el tiempo entre pulsos, en microsegundos
   
   distanceCm = duration / 292/ 2;   //convertimos a distancia, en m
   return distanceCm;
}
