import 'package:flutter/services.dart';
import 'inGamePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
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
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, right: 20.0, left: 20.0, bottom: 30.0),
              child: Image.asset(
                'images/entertainment.png',
                height: 150,
                width: 150,
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: size,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 2,
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
              onPressed: () {
                print(size.text);
                if(int.parse(size.text)<3 || int.parse(size.text)>10)
                  alertSize();
                else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        new inGamePage(int.parse(size.text)),
                    ));
                }
              },
              child: Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
  alertSize() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Size is between 3-10 only',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "OK",
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                size.clear();
              },
            ),
        ]);
      }
    );
  }
}
