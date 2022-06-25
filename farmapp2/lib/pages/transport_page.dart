import 'package:farmapp2/models/belt.dart';
import 'package:farmapp2/models/belt_status.dart';
import 'package:farmapp2/services/farm_service.dart';
import 'package:farmapp2/services/socket_service.dart';
import 'package:farmapp2/widgets/custom_card2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransportPage extends StatefulWidget{

  @override
  _TransportPageState createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> with AutomaticKeepAliveClientMixin{
  bool beltStatus = false;
  Belt belt;
  FarmService farmService;
  SocketService socketService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.socketService = Provider.of<SocketService>(context,listen:false);
    this.farmService = Provider.of<FarmService>(context,listen:false);
    _getBelt();
    this.socketService.socket.on('belt',_listenBelt);
  }

  _listenBelt(dynamic payload){
    BeltStatus beltStatus = beltStatusFromJson(payload);
    setState(() {
      this.belt.status = beltStatus.status;
      this.beltStatus = beltStatus.status;
    });
    print(payload);
  }

  _getBelt() async {
    this.belt = await this.farmService.getBelt();
    setState(() {
    });
  }

  @override
  Widget build (BuildContext context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:30,bottom: 30,left: 50),
            child: Text("Control de Cinta Transportadora",style: TextStyle(fontSize: 42,color: Colors.black54),)
          ),

          ClipRRect(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(50),bottomRight: Radius.circular(50)),
            child: Container(
              child:Image.asset(
                  'assets/trans.gif',
              )
            ),
          ),
          
          CustomCard2(
            value: (beltStatus)
              ?"Encendido"
              :"Apagado", 
            tittle: "Cinta ", 
            subTittle: "",
            firstColor: (beltStatus)
              ?Colors.blue[400]
              :null,
            secondColor: (beltStatus)
              ?Colors.blueAccent
              :null,
            onPressed: ()=> _beltController(),
          )
          
        ],
      )
    );
  }
  _beltController(){
    setState(() {
      this.belt.status = !this.belt.status;
      this.beltStatus = this.belt.status;
    });
    this.socketService.emit('belt',{
      'belt' : this.belt.id,
      'status' :this.belt.status
    });
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}