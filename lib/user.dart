import 'package:flutter/material.dart';
import 'main.dart';

class login extends StatefulWidget{
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Text("usuario: "),
              title: TextField(),
            ),
            ListTile(
              leading: Text("contrasenia: "),
              title: TextField(),
            ),
            MaterialButton(
              child: Text("login"),
              onPressed: () =>{
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Gallery()
                )
                )
              },
            )
          ],
        ),
      ),
    );
  }
}