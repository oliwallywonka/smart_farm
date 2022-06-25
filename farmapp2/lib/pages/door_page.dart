import 'dart:convert';

import 'package:farmapp2/models/DoorResponse.dart';
import 'package:farmapp2/models/door.dart';
import 'package:farmapp2/models/door_status.dart';
import 'package:farmapp2/models/farm.dart';
import 'package:farmapp2/services/socket_service.dart';
import 'package:farmapp2/widgets/custom_buton.dart';
import 'package:farmapp2/widgets/custom_card.dart';
import 'package:farmapp2/widgets/custom_card2.dart';
import 'package:farmapp2/services/farm_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoorPage extends StatefulWidget{

  @override
  _DoorPageState createState() => _DoorPageState();
}

class _DoorPageState extends State<DoorPage> with AutomaticKeepAliveClientMixin {
  SocketService socketService;
  FarmService farmService;
  Farm farm;
  Door door;
  
  List<Door> doors = [];
  bool _checked = false;
  TimeOfDay currentTime;
  TimeOfDay openDoors;
  TimeOfDay closeDoors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.socketService = Provider.of<SocketService>(context,listen: false);
    this.farmService = Provider.of<FarmService>(context,listen:false);
    currentTime = TimeOfDay.now();
    _getDoors();
    _getFarmTime();
    this.socketService.socket.on("door",_changeDoorStatus);
  }

  _changeDoorStatus(dynamic payload){
    DoorStatus doorStatus = doorStatusFromJson(payload);
    setState(() {
    });
    for(int i = 0; i < doors.length; i++){
      if(doors[i].id == doorStatus.door){
        this.doors[i].status = doorStatus.status;
      }
    }
  }

  void _getFarmTime()async{
    this.farm = await this.farmService.getFarm();
    setState(() {
      this.openDoors = TimeOfDay.fromDateTime(this.farm.openDoors);
      this.closeDoors = TimeOfDay.fromDateTime(this.farm.closeDoors);
    });
  }
  void _getDoors() async{
    this.doors = await this.farmService.getDoors();
    setState(() {
      
    });
  }

  @override
  Widget build (BuildContext context){

    return Center(
      child: Column(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:30,bottom: 30),
            child: Text("Control de puertas",style: TextStyle(fontSize: 42,color: Colors.black54),)
          ),
          /*CheckboxListTile(
            title: Text ("TIPO DE CONTROL ${_checked}"),
            secondary: Icon(Icons.auto_awesome),
            controlAffinity: ListTileControlAffinity.platform,
            value: _checked, 
            onChanged: (bool value){
              setState((){
                _checked= value;
              }); 
            },
          ),*/
          (closeDoors != null)
          ?Padding(                                                                                      
            padding: const EdgeInsets.all(30),
            child: CustomButon(
              text: "Hora de Cierre ${closeDoors.hour}:${closeDoors.minute} ${closeDoors.period}",
              onPressed: _pickClose,
            ) 
          )
          :Text("esperando....."),
          (openDoors != null)
          ?Padding(
            padding: const EdgeInsets.only(bottom:30,left: 30,right: 30),
            child: CustomButon(
              text: "Hora de apertura ${openDoors.hour}:${openDoors.minute} ${openDoors.period}",
              onPressed: _pickOpen,
            ) 
          )
          :Text("esperando...."),
          (doors!=null)
          ?Flexible(
              child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: doors.length,
              itemBuilder: (BuildContext context , int index){
                return CustomCard2(
                  tittle: "Puerta",
                  subTittle: "${index+1}",
                  value: (doors[index].status)
                    ?"Abierto"
                    :"Cerrado",
                  
                  firstColor: (doors[index].status)
                    ?Colors.blue[400]
                    :null,
                  secondColor: (doors[index].status)
                    ?Colors.blueAccent
                    :null,
                  onPressed:() => _doorController(doors[index].id, doors[index].status, index)
                );
              },
            ),
          )
          :Text("esperando...."),
        ]
      ),
    );
  }
  _doorController(String door,bool status,int index){
    
    setState(() {
      doors[index].status = !doors[index].status;
    });
    this.socketService.emit('door',{
      'door' : door,
      'status' : doors[index].status
    });
  }
  _pickOpen() async {
    TimeOfDay date = await showTimePicker(
      context: context, 
      initialTime: currentTime
    );
    Farm newFarm = new Farm();
    newFarm.openDoors = DateTime(2020,11,6,date.hour,date.minute).toUtc();
    newFarm.id = farm.id;
    await farmService.updateFarm(newFarm);
    if(date != null)
      setState(() {
        openDoors = date;
      });
    
  }

  _pickClose() async {
    TimeOfDay date = await showTimePicker(
      context: context, 
      initialTime: currentTime
    );
    Farm newFarm = new Farm();
    newFarm.closeDoors = DateTime(2020,11,6,date.hour,date.minute).toUtc();
    newFarm.id = farm.id;
    await farmService.updateFarm(newFarm);
    if(date != null)
      setState(() {
        closeDoors = date;
        print(date);
      });
    
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

