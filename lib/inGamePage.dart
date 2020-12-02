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
      body: Container(
        child: Center(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:15),
                    child: Text(
                      lastChar2 + ' turn ',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:60),
                child: GridView.count(
                  crossAxisCount: matrix.length,
                  children: <Widget>[
                    for (var i = 0; i < matrix.length; i++) 
                      for (var j = 0; j < matrix[i].length; j++) 
                        buildTable(i, j)
                  ],
                ),
              ),
            ],
          ),
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
        checkTheWinner(i, j);
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              matrix[i][j],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 300/matrix.length),
            ),
          ],
        ),
      ),
    );
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
    else if (count == (matrix.length * matrix.length))
      alertDraw();
  }
  alertWinner(String winner) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Player \'$winner\' is the Winner',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'New Dimension',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                'Play Again',
                style: TextStyle(fontSize: 18.0),
              ),
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
          title: Center(
            child: Text(
              'Draw',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'New Dimension',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                'Play Again',
                style: TextStyle(fontSize: 18.0),
              ),
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
