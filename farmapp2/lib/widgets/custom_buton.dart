import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {

  final Function onPressed;
  final String text;

  const CustomButon({
    Key key, 
    @required this.onPressed, 
    @required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.onPressed, 
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child:Text(this.text,style:TextStyle(color:Colors.white)),
        ),
      ),
    );
  }
}