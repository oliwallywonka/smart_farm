import 'package:farmapp2/services/auth_service.dart';
import 'package:farmapp2/services/farm_service.dart';
import 'package:farmapp2/services/push_notifications_service.dart';
import 'package:farmapp2/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context,snapshot){

          return Center(
            child: Text('Loading....'),
          );
        },
      ),
    );
  }

  
  
  Future checkLoginState (BuildContext context)async{
    final socketService = Provider.of<SocketService>(context,listen:false);
    final authService = Provider.of<AuthService>(context,listen:false);
    final farmService = Provider.of<FarmService>(context,listen:false);
    //final pushNotificationService = Provider.of<PushNotificationService>(context,listen: false);
    final saveFarmId = await farmService.getFarm();
    await farmService.getBelt();
    //await pushNotificationService.initNotifications();
    await farmService.savePhoneToken();
    final authenticate = await authService.isLoggedIn();

    if(authenticate){
      //TODo: Coneect socket server
      socketService.connect();
      Navigator.pushReplacementNamed(context, 'home');
    }else{
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}