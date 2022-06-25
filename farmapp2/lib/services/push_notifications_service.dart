import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class PushNotificationService extends ChangeNotifier {

  /*FirebaseMessaging _firebaseMessaging() => FirebaseMessaging();

  final _storage= new FlutterSecureStorage();
  Future _savePhoneToken(String token)async{
    return await _storage.write(key: 'phoneToken', value: token);
  }

  initNotifications(){
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token)async{
      print('====== FMC TOKEN =======');
      print(token);
      await this._savePhoneToken(token);

      //eeMiPZqET-aI82nGTkKugv:APA91bE8__WVcHTeU2r4b0QpGCa6tOZfzIzbJGPZ5ldhKhqmJs2zc-kKT3NNa6wfC5gd6XxU0ycXkC1PKiilLjCyemlUkJ2DwACwi8XcD7rHl8G7WXBt5_7Z9lR_TK3LqMTTchWWRuGu
    });
    _firebaseMessaging.configure(
      onMessage: (message){
        print('====== on message ======');
        print(message);
      },
      onLaunch: (message) {
        print('===== on Launch =======');
        print(message);
      },
      onResume: (message) {
        print('====== on Resume ======');
        print(message);

        final food = message['data']['comida'];
        print(food);
      }
    );
  }*/

}