

import 'dart:convert';

import 'package:farmapp2/global/enviroment.dart';
import 'package:farmapp2/models/DoorResponse.dart';
import 'package:farmapp2/models/belt.dart';
import 'package:farmapp2/models/farm.dart';
import 'package:farmapp2/models/login_response.dart';
import 'package:farmapp2/models/window.dart';
import 'package:farmapp2/models/window_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:farmapp2/models/door.dart';

import 'package:http/http.dart' as http;

class FarmService with ChangeNotifier {

  Response response;

  Farm _farm;
  Farm get farm => this._farm;
  set farm (Farm value){
    this._farm = value;
    notifyListeners();
  }

  List<Door> _doors;
  List<Door> get doors => this._doors;
  set doors (List<Door> values){
    this._doors = values;
    notifyListeners();
  }

  List<Window> _windows;
  List<Window> get windows => this._windows;
  set windows (List<Window> values){
    this._windows = values;
    notifyListeners();
  }

  Belt _belt;
  Belt get belt => this._belt;
  set belt(Belt value){
    this._belt = value;
    notifyListeners();
  }

  final _storage = new FlutterSecureStorage();
  
  Future<Farm> getFarm() async{
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/api/farm'),
      headers:{
        'Content-Type':'application/json',
        'x-access-token':token
      }
    );
    if(resp.statusCode == 200){
      final farmResponse = farmFromJson(resp.body);
      farm = farmResponse;
      await this._saveIdFarm(farmResponse.id);
      return farm;
    }else{
      return null;
    }
  }

  Future _saveIdFarm (String id)async{
    return await _storage.write(key: 'idFarm', value: id);
  }

  Future <bool> updateFarm (Farm farm)async{
    final token = await this._storage.read(key:'token');
    final data  = {
      'idFarm' : farm.id
    };
    if(farm.openDoors != null){
      data['open_doors'] = '${farm.openDoors}';
    }
    if(farm.closeDoors != null){
      data['close_doors'] = '${farm.closeDoors}';
    }
    if(farm.humidityMax != null){
      data['humidity_max'] = '${farm.humidityMax}';
    }
    if(farm.humidityMin != null){
      data['humidity_min'] = '${farm.humidityMin}';
    }
    if(farm.tempMin != null){
      data['temp_min'] = '${farm.tempMin}';
    }
    if(farm.tempMax != null){
      data['temp_max'] = '${farm.tempMax}';
    }
    
    final resp = await http.put(Uri.parse('${Enviroment.apiUrl}/api/farm'),
      body: jsonEncode(data),
      headers:{
        'Content-Type':'application/json',
        'x-access-token':token
      },
    );
    if(resp.statusCode==202){
      return true;
    }else{
      return false;
    }
  }

  Future<List<Door>> getDoors() async{
    final token = await this._storage.read(key:'token');
    final idFarm = await this._storage.read(key:'idFarm');
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/api/door/${idFarm}'),
      headers:{
        'Content-Type': 'application/json',
        'x-access-token':token
      },
    );
    if(resp.statusCode == 200){
      final doorResponse = doorResponseFromJson(resp.body);
      return doorResponse.doors;
    }else{
      return [];
    }
  }

  Future<List<Window>> getWindows() async{
    final token = await this._storage.read(key: 'token');
    final idFarm = await this._storage.read(key: 'idFarm');
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/api/window/${idFarm}'),
      headers: {
        'Content-Type':'application/json',
        'x-access-token' : token
      },
    );
    if (resp.statusCode == 200){
      final windowResponse = windowResponseFromJson(resp.body);
      return windowResponse.windows;
    }else{
      return [];
    }
  }

  Future<Belt> getBelt() async{
    final token = await this._storage.read(key: 'token');
    final idFarm = await this._storage.read(key: 'idFarm');
    final resp = await http.get(Uri.parse('${Enviroment.apiUrl}/api/belt/${idFarm}'),
      headers: {
        'Content-Type':'application/json',
        'x-access-token' : token
      },
    );
    if(resp.statusCode == 200){
      final beltResponse = beltFromJson(resp.body);
      belt = beltResponse;
      print(belt.id);
      return belt;
    }else{
      return null;
    }
  }

  Future<bool> savePhoneToken() async{
    final token = await this._storage.read(key: 'token');
    final phoneToken = await this._storage.read(key: 'phoneToken');
    final data = {
      "token": phoneToken
    };
    final resp = await http.post(Uri.parse('${Enviroment.apiUrl}/api/phone'),
      body: jsonEncode(data),
      headers: {
        'Content-Type':'application/json',
        'x-access-token' : token
      },
    );
    if(resp.statusCode == 201){
      print(resp.body);
      return true;
    }else{
      return null;
    }
  }
}