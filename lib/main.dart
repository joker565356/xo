import 'package:xo/modelSize.dart';

import 'inGamePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Game XO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Firstpage(),
    );
  }
}

class Firstpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstpageState();
  }
}

class _FirstpageState extends State<Firstpage> {
  var size = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Game XO"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              child: TextField(
                controller: size,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 3,
                decoration: InputDecoration(
                  labelText: 'Dimension Size',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>new inGamePage(),
                ));
              },
            child: Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}


