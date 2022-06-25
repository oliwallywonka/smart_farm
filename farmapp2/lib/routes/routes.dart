import 'package:flutter/material.dart';

import 'package:farmapp2/pages/navigation_page.dart';
import 'package:farmapp2/pages/loading_page.dart';
import 'package:farmapp2/pages/dashboard_page.dart';
import 'package:farmapp2/pages/door_page.dart';
import 'package:farmapp2/pages/login_page.dart';
import 'package:farmapp2/pages/transport_page.dart';
import 'package:farmapp2/pages/window_page.dart';

final Map<String,Widget Function(BuildContext)> appRoutes = {

  'home'      :(_) => NavigationPage(),
  'dashboard' :(_) => DashboardPage(), 
  'door'      :(_) => DoorPage(), 
  'transport' :(_) => TransportPage(),
  'window'    :(_) => WindowPage(),
  'login'     :(_) => LoginPage(),
  'loading'   :(_) => LoadingPage(),

};