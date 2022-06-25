
import 'package:farmapp2/models/window.dart';
import 'package:farmapp2/models/window_status.dart';
import 'package:farmapp2/services/farm_service.dart';
import 'package:farmapp2/services/socket_service.dart';
import 'package:farmapp2/widgets/custom_card.dart';
import 'package:farmapp2/widgets/custom_card2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WindowPage extends StatefulWidget{

  @override
  _WindowPageState createState() => _WindowPageState();
}
class _WindowPageState extends State<WindowPage> with AutomaticKeepAliveClientMixin {

  SocketService socketService;
  FarmService farmService;

  List<Window> windows = [];

  bool _checked = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.socketService = Provider.of<SocketService>(context,listen:false);
    this.farmService = Provider.of<FarmService>(context,listen: false);
    _getWindows();
    this.socketService.socket.on('window', _listenWindows);

  }

  _listenWindows(dynamic payload){
    WindowStatus windowStatus = windowStatusFromJson(payload);
    setState(() {
      
    });
    this.windows.forEach((element) {
      if(element.id == windowStatus.window){
        this.windows[this.windows.indexOf(element)].status = windowStatus.status;
      }
    });
    print(payload);
  }

  void _getWindows() async{

    this.windows  = await this.farmService.getWindows();
    setState(() {
      
    });
  }
  
  @override
  Widget build (BuildContext context){
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(6.0),
            child: Text("Control de Ventanas",style: TextStyle(fontSize: 42,color: Colors.black54),)
          ),
          /*Container(
            margin: EdgeInsets.only(top:50),
            child: CheckboxListTile(
              title: Text ("Automatico ${_checked}"),
              controlAffinity: ListTileControlAffinity.platform,
              value: _checked, 
              onChanged: (bool value){
                setState((){
                  _checked= value;
                }); 
              },
            ),
          ),*/
          Flexible(
            child: GridView.builder(
              itemCount: windows.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (2)
              ),
              itemBuilder: (BuildContext context, int index){
                return CustomCard2(
                  tittle: "Ventana", 
                  subTittle: "${index+1}",
                  value: (windows[index].status)
                    ?"Abierto"
                    :"Cerrado",
                  firstColor: (windows[index].status)
                    ?Colors.blue[400]
                    :null,
                  secondColor: (windows[index].status)
                    ?Colors.blueAccent
                    :null,
                  onPressed: () => _windowController(
                    windows[index].id,
                    windows[index].status, 
                    index
                  ), 
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _windowController(String window,bool status,int index){
    
    setState(() {
      windows[index].status = !windows[index].status;
    });
    this.socketService.emit('window',{
      'window' : window,
      'status' : windows[index].status
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  

}