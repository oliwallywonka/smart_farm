import 'package:flutter/material.dart';

class CustomCard2 extends StatelessWidget {

  final Color firstColor;
  final Color secondColor;
  final String value;
  final String tittle;
  final String subTittle;
  final String text;
  final Function onPressed;

  const CustomCard2({
    Key key, 
    this.firstColor, 
    this.secondColor, 
    this.text,
    this.onPressed,
    @required this.value, 
    @required this.tittle, 
    @required this.subTittle, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 162,
        width: 200,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              (firstColor==null)
              ?Colors.pink
              :firstColor,
              (secondColor == null)
              ?Colors.red
              :secondColor
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
          boxShadow: [
                  BoxShadow(
                    color: (secondColor== null)
                    ?Colors.red
                    :secondColor,
                    blurRadius: 12,
                    offset: Offset(0,6)
                  ),
                ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(tittle,style: TextStyle(color: Colors.white,fontSize: 42 ),),
            Text(subTittle,style: TextStyle(color: Colors.white,fontSize: 42 ),),
            Text(value,style: TextStyle(color: Colors.white,fontSize: 30 ),),
          ]
        ),
      ),
      onTap: onPressed,
    );
  }
}