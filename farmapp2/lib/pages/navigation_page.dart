import 'package:farmapp2/pages/dashboard_page.dart';
import 'package:farmapp2/pages/door_page.dart';
import 'package:farmapp2/pages/transport_page.dart';
import 'package:farmapp2/pages/window_page.dart';
import 'package:farmapp2/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:farmapp2/services/socket_service.dart';


class NavigationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);

    return  ChangeNotifierProvider(
      create: (_) => new _NavegationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Farm',style: TextStyle(color: Colors.black38),),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                ?Icon(Icons.check_circle,color: Colors.blue[300])
                :Icon(Icons.offline_bolt ,color: Colors.red)
                
            )
          ],
        ),
        body: _Pages() ,
        bottomNavigationBar: _Navegation(),
          
      ),
    );
  }
}


class _Navegation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegationModel = Provider.of<_NavegationModel>(context);

    return BottomNavigationBar(
      currentIndex: navegationModel.currentPage,
      onTap: (i) => navegationModel.currentPage = i,
      items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.data_usage),
              label: 'Puertas',
              backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.three_mp),
              label: 'Ventanas',
              backgroundColor: Colors.blue
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Cinta',
              backgroundColor: Colors.blue
            ),
          ]
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final navegationModel = Provider.of<_NavegationModel>(context);
    return PageView(
      controller: navegationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        DashboardPage(),
        DoorPage(),
        WindowPage(),
        TransportPage()
      ],
    );
  }
}


class _NavegationModel with ChangeNotifier{

  int _currentPage = 0;
  PageController _pageController = new PageController(initialPage:0);

  int get currentPage => this._currentPage;
  PageController get pageController => this._pageController;

  set currentPage(int valor){
    this._currentPage = valor;
    _pageController.animateToPage(valor, duration: Duration(milliseconds: 350), curve: Curves.easeOut);
    notifyListeners();
  }

}