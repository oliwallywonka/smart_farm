#include <ESP8266WiFi.h>
#include <SocketIoClient.h>
#include <WebSocketsClient.h>

#define ARDUINOJSON_ENABLE_COMMENTS 0
#include <ArduinoJson.h>

String inputString = " ";

//Sensors
char* idTemperature1 = "5f9ce072d13615050459708b";

const char* idHumidity1 = "5f9c3003219a212790d7e13f";

const char* idWhaterLevel = "5fbf0721de296722041d01cf";

const char* idFoodLevel = "5f9ce0be2b87b022b439880e";

//Actuators

const char* idWindow1 = "5fbd5b288f8d722ca078882e";

const char* idWindow2 = "5fbd5b2a8f8d722ca078882f";

const char* idWindow3 = "5fbd5f7a8f8d722ca0788830";

const char* idDoor1 = "5fbad7a884b652365c8fd3a8";

const char* idDoor2 = "5fbad7ab84b652365c8fd3a9";

const char* idBelt = "5fbd7dc3368e72219c1e7015";

uint64_t messageTimestamp;
SocketIoClient webSocket;

const char* userid = "5f627dce0f44e517ac297aef";

String deleteBackSlash(const char * payload){
 String s = String(payload);
 char c;
 char no = '\\';
 for(int i = 0; i<s.length()-1; ++i){
  c = s.charAt(i);
  if(c== no){
    s.remove(i, 1);
  }
 }
  return s;
}

void windowMessageEventHandler(const char * payload, size_t length) {
 String json = deleteBackSlash(payload);
 DynamicJsonDocument doc(1024);
 deserializeJson(doc,json);
 const char* idWin = doc["window"];
 bool stat = doc["status"];
 
 if(strcmp(idWin,idWindow1)==0){
  if(stat){
    Serial.println("window1-true"); 
  }else{
    Serial.println("window1-false");
  }  
 }
 
 if(strcmp(idWin,idWindow2)==0){
  if(stat){
    Serial.println("window2-true"); 
  }else{
    Serial.println("window2-false");
  }  
 }

 if(strcmp(idWin,idWindow3)== 0){
  if(stat){
    Serial.println("window3-true"); 
  }else{
    Serial.println("window3-false");
  }  
 }
 
}

void doorMessageEventHandler(const char * payload, size_t length) {
 String json = deleteBackSlash(payload);
 StaticJsonDocument<200> doc;
 deserializeJson(doc,json);
 const char* idDoor = doc["door"];
 bool stat = doc["status"];
 if(strcmp(idDoor,idDoor1) == 0){
  if(stat){
    Serial.println("door1-true"); 
  }else{
    Serial.println("door1-false");
  }  
 }

 if(strcmp(idDoor,idDoor2) == 0){
  if(stat){
    Serial.println("door2-true"); 
  }else{
    Serial.println("door2-false");
  }  
 }
}

void beltMessageEventHandler(const char * payload, size_t length){
 String json = deleteBackSlash(payload);
 StaticJsonDocument<200> doc;
 deserializeJson(doc,json);
 const char* idBelt = doc["belt"];
 bool stat = doc["status"];
 if(stat){
  Serial.println("belt-true");
 }else{
  Serial.println("belt-false") ;
 }
}

void sensorHandler(String payload){
  StaticJsonDocument<200> doc;
  deserializeJson(doc,payload);
  if(doc.containsKey("wather")){
    long value = doc["wather"];
    webSocket.emit("whater", sensorMessageEventHandler(idFoodLevel,"whater",value));
  }
  if(doc.containsKey("food")){
    long value = doc["food"];
    webSocket.emit("food", sensorMessageEventHandler(idWhaterLevel,"food",value));
  }
  if(doc.containsKey("humidity")){
    long value = doc["humidity"];
    webSocket.emit("humidity", sensorMessageEventHandler(idHumidity1,"humidity",value));
  }
  if(doc.containsKey("temperature")){
    long value = doc["temperature"];
    webSocket.emit("temperature", sensorMessageEventHandler(idTemperature1,"temperature",value));
  }

  if(doc.containsKey("window1")){
    bool value = doc["window"];
    webSocket.emit("window", actuatorMessageEventHandler(idWindow1,"window",value)); 
  }

  if(doc.containsKey("window2")){
    bool value = doc["window2"];
    webSocket.emit("window", actuatorMessageEventHandler(idWindow2,"window",value)); 
  }
  if(doc.containsKey("window3")){
    bool value = doc["window3"];
    webSocket.emit("window", actuatorMessageEventHandler(idWindow3,"window",value)); 
  }
  if(doc.containsKey("door1")){
    bool value = doc["door1"];
    webSocket.emit("door", actuatorMessageEventHandler(idDoor1,"door",value));
  }
  if(doc.containsKey("door2")){
    bool value = doc["door2"];

    webSocket.emit("door", actuatorMessageEventHandler(idDoor2,"door",value));
  }
  if(doc.containsKey("belt")){
    bool value = doc["belt"];
    webSocket.emit("belt", actuatorMessageEventHandler(idBelt,"belt",value)); 
  }
  
  
}

const char* actuatorMessageEventHandler(const char * id,const char * actuatorType, bool value){
 StaticJsonDocument<200> doc;
 doc[actuatorType] = id;
 doc["status"] = value;
 char* payload = "";
 serializeJson(doc,payload,200);
 return payload;
}

const char* sensorMessageEventHandler(const char * id,const char * sensorType, long value) {
 StaticJsonDocument<200> doc;
 doc["sensor"] = id;
 doc[sensorType] = value;
 char* payload = "";
 serializeJson(doc,payload,200);
 return payload;
}



void setup() {
  
 Serial.begin(9600);
 WiFi.begin("HP-LPB300", "*Aladdin123*");
 Serial.print("Connecting");
 while (WiFi.status() != WL_CONNECTED)
 {
  delay(2500);
  Serial.print(".");
 }
 Serial.println();

 Serial.print("Connected, IP address: ");
 
 Serial.println(WiFi.localIP());
  

  // server address, port and URL
  //Develop domain
  webSocket.begin("192.168.1.4",8000);
  //Producction domain
  //webSocket.begin("gentle-tor-35472.herokuapp.com");
  
  
  //use HTTP Basic Authorization this is optional remove if not needed authorization: 
  //Response Example 'Basic eGF1dGgtdG9rZW46NDE2NDU2NTE=' base64 coded 
  //Use without "user" param just use password to send some token authorization
  //webSocket.setAuthorization("", userid);

  // event handler for the event message
  webSocket.on("door",doorMessageEventHandler);
  webSocket.on("window",windowMessageEventHandler);
  webSocket.on("belt",beltMessageEventHandler);
}

void loop() {
      webSocket.loop();
      //webSocket.emit("prueba2","123");
      if(Serial.available()>0){
         inputString = Serial.readStringUntil('\n');
         inputString.trim();
         Serial.println(inputString);
         StaticJsonDocument<200> doc;
          deserializeJson(doc,inputString);
          if(doc.containsKey("water")){
            long value = doc["water"];
             webSocket.emit("whater", sensorMessageEventHandler(idWhaterLevel,"whater",value));
          }
          if(doc.containsKey("food")){
            long value = doc["food"];
            webSocket.emit("food", sensorMessageEventHandler(idFoodLevel,"food",value));
          }
          if(doc.containsKey("humidity")){
            long value = doc["humidity"];
            webSocket.emit("humidity", sensorMessageEventHandler(idHumidity1,"humidity",value));
          }
          if(doc.containsKey("temperature")){
            long value = doc["temperature"];
            webSocket.emit("temperature", sensorMessageEventHandler(idTemperature1,"temperature",value));
          }
        }
}
