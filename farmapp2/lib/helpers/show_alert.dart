
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert (BuildContext context,String title ,String subtitle){
  
  showDialog( 
    context: context,
    builder: (_)  => AlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: <Widget>[
        MaterialButton(
          child: Text('OK'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context),
        )
      ],
    )
  );
}