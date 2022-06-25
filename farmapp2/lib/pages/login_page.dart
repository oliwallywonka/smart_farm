
import 'package:farmapp2/helpers/show_alert.dart';
import 'package:farmapp2/services/auth_service.dart';
import 'package:farmapp2/services/farm_service.dart';
import 'package:farmapp2/services/socket_service.dart';
import 'package:farmapp2/widgets/custom_buton.dart';
import 'package:farmapp2/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              height: MediaQuery.of(context).size.height*0.9,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _Logo(),
                _Form(),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  

}


class _Logo extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Center(
      child: Container(
        width: 160,
        margin: EdgeInsets.only(top:50),
        child: Column(children: <Widget>[
          SizedBox(height: 20,),
          Text('SmartFarm',style: TextStyle(fontSize: 30),),
          Container(
            width: 160,
            height: 160,
            margin: EdgeInsets.only(top: 20),
            child: SvgPicture.asset('assets/cinta.svg')
          ),
        ],)
      ),
    );
  }
}


class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context,listen: false);
    final farmService = Provider.of<FarmService>(context,listen:false);
    final socketService = Provider.of<SocketService> (context);
    return Container(
      margin: EdgeInsets.only(top:40),
      padding: EdgeInsets.symmetric(horizontal:50),
       child: Column (
         children: <Widget>[
           CustomInput(
             icon:Icons.mail_outline,
             placeholder: 'Email',
             keyboardType: TextInputType.emailAddress,
             textController: emailCtrl,
           ),
           CustomInput(
             icon:Icons.lock_outline,
             placeholder: 'Password',
             textController: passCtrl,
             isPassword: true,
           ),
           
           CustomButon(
             text: 'Ingresar',
             onPressed: authService.autenticate ? null :() async{
               FocusScope.of(context).unfocus();
               final loginOK = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
               if(loginOK){
                 //TODO: Socket server conection
                 socketService.connect();
                 farmService.getFarm();
                 //TODO: go to next page
                 Navigator.pushReplacementNamed(context, 'home');

               }else{
                 //Show alert
                 showAlert(context, 'Login incorrect' , 'Revise sus Credenciales');
               }
             },
           ),

         ]
       ),
    );
  }
}