import 'package:farmapp2/services/farm_service.dart';
import 'package:farmapp2/services/push_notifications_service.dart';
import 'package:flutter/material.dart';

import 'package:farmapp2/services/auth_service.dart';
import 'package:farmapp2/services/socket_service.dart';

import 'package:farmapp2/routes/routes.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_) => AuthService() ),
          ChangeNotifierProvider(create: (_) => SocketService() ),
          ChangeNotifierProvider(create: (_)=> FarmService(),),
          ChangeNotifierProvider(create: (_) => PushNotificationService(),)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'loading',
          routes: appRoutes
        ),
    );
  }
}