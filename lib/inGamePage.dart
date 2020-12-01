import 'package:flutter/material.dart';

class inGamePage extends StatefulWidget {
  int dimension;
  inGamePage(int size) {
    this.dimension = size;
  }
  @override
  State<StatefulWidget> createState() {
    return _inGamePageState(dimension);
  }
}

class _inGamePageState extends State<inGamePage> {
  List<List> matrix;
  int dimension;
  _inGamePageState(int dimension) {
    this.dimension = dimension;
    _initMatrix();
  }
  _initMatrix() {
    matrix = List<List>(dimension);
    for (var i = 0; i < matrix.length; i++) {
      matrix[i] = List(dimension);
      for (var j = 0; j < matrix[i].length; j++) {
        matrix[i][j] = ' ';
      }
    }
    count = 0;
  }

  var count = 0;
  String lastChar = 'O';
  String lastChar2 = 'X';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Playing"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lastChar2 + ' turn ',
              style: TextStyle(fontSize: 25),
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildTable(0, 0),
                buildTable(0, 1),
                buildTable(0, 2),
                buildTable(0, 3),
              ],
            ),*/
            for (var i = 0; i < matrix.length; i++) buildFromDimension(i)
          ],
        ),
      ),
    );
  }

  buildTable(int i, int j) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (matrix[i][j] == ' ') {
            if (lastChar == 'O') {
              matrix[i][j] = 'X';
            } else {
              matrix[i][j] = 'O';
            }
            lastChar = matrix[i][j];
            if (lastChar == 'O')
              lastChar2 = 'X';
            else
              lastChar2 = 'O';
            count++;
          }
        });
        for (var k = 0; k < matrix.length; k++) {
          var str = '';
          for (var m = 0; m < matrix[k].length; m++) {
            str += matrix[k][m];
          }
          print(str);
        }
        checkTheWinner(i, j);
        if (count == (matrix.length * matrix.length)) alertDraw();
      },
      child: Container(
        width: 35,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Text(
          matrix[i][j],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }

  buildFromDimension(int length) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < matrix.length; i++) {
      list.add(buildTable(length, i));
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list);
  }

  checkTheWinner(int x, int y) {
    var column = 0, row = 0, diag = 0, rdiag = 0;
    var n = matrix.length - 1;
    var player = matrix[x][y];

    for (int i = 0; i < matrix.length; i++) {
      if (matrix[x][i] == player) column++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i] == player) rdiag++;
    }
    if (column == n + 1 || row == n + 1 || diag == n + 1 || rdiag == n + 1) {
      alertWinner(player);
    }
  }
  alertWinner(String winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Player \'$winner\' is the Winner'),
          actions: <Widget>[
            FlatButton(
              child: Text('New Dimension'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initMatrix();
                });
              },
            )
          ]
        );
      }
    );
  }
  alertDraw() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Draw'),
          actions: <Widget>[
            FlatButton(
              child: Text('New Dimension',style: TextStyle(fontSize: 18.0),),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                
              },
            ),
            FlatButton(
              child: Text('Play Again',style: TextStyle(fontSize: 18.0),),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _initMatrix();
                });
              },
            )
          ]
        );
      }
    );
  }
}
