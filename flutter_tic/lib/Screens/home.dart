import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> XorOturn = ['', '', '', '', '', '', '', '', ''];
  bool isTurnO = true;
  var FilledBoxes = 0;
  bool GameHasResult = false;
  var ScoreX = 0;
  var ScoreO = 0;
  var winnertitle = '';

  Widget Players(String name, String score) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '$name',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ClearGame();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueGrey,
              Colors.blue,
              Colors.blueAccent,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              getplayerscor(),
              SizedBox(
                height: 35,
              ),
              GetResultButton(),
              SizedBox(
                height: 20,
              ),
              getGridView(),
              getturn(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getplayerscor() {
    return Column(
      children: [
        Row(
          children: [
            Players('Player X', '$ScoreX'),
            Players('Player O', '$ScoreO'),
          ],
        ),
      ],
    );
  }

  void Tapped(int index) {
    setState(() {
      if (GameHasResult) {
        return;
      }
      if (XorOturn[index] != '') {
        return;
      }
      if (isTurnO) {
        XorOturn[index] = 'X';
        FilledBoxes++;
      } else {
        XorOturn[index] = 'O';
        FilledBoxes++;
      }
      isTurnO = !isTurnO;
      CheckWinner();
    });
  }

  void CheckWinner() {
    if (XorOturn[0] == XorOturn[1] &&
        XorOturn[0] == XorOturn[2] &&
        XorOturn[0] != '') {
      setResult(XorOturn[0], 'winner is ' + XorOturn[0]);
      return;
    }
    if (XorOturn[3] == XorOturn[4] &&
        XorOturn[3] == XorOturn[5] &&
        XorOturn[3] != '') {
      setResult(XorOturn[3], 'winner is ' + XorOturn[3]);

      return;
    }
    if (XorOturn[6] == XorOturn[7] &&
        XorOturn[6] == XorOturn[8] &&
        XorOturn[6] != '') {
      setResult(XorOturn[6], 'winner is ' + XorOturn[6]);

      return;
    }
    if (XorOturn[0] == XorOturn[3] &&
        XorOturn[0] == XorOturn[6] &&
        XorOturn[0] != '') {
      setResult(XorOturn[0], 'winner is ' + XorOturn[0]);

      return;
    }
    if (XorOturn[1] == XorOturn[4] &&
        XorOturn[1] == XorOturn[7] &&
        XorOturn[1] != '') {
      setResult(XorOturn[1], 'winner is ' + XorOturn[1]);

      return;
    }
    if (XorOturn[2] == XorOturn[5] &&
        XorOturn[2] == XorOturn[8] &&
        XorOturn[2] != '') {
      setResult(XorOturn[2], 'winner is ' + XorOturn[2]);

      return;
    }
    if (XorOturn[0] == XorOturn[4] &&
        XorOturn[0] == XorOturn[8] &&
        XorOturn[0] != '') {
      setResult(XorOturn[0], 'winner is ' + XorOturn[0]);

      return;
    }
    if (XorOturn[2] == XorOturn[4] &&
        XorOturn[2] == XorOturn[6] &&
        XorOturn[2] != '') {
      setResult(XorOturn[2], 'winner is ' + XorOturn[2]);

      return;
    }
    if (FilledBoxes == 9) {
      setResult('', 'Draw');
    }
  }

  void ClearGame() {
    setState(() {
      for (var i = 0; i < XorOturn.length; i++) {
        XorOturn[i] = '';
        isTurnO = false;
      }
    });
    FilledBoxes = 0;
  }

  void setResult(String winner, String title) {
    setState(() {
      winnertitle = title;
      GameHasResult = true;
      if (winner == 'X') {
        ScoreX = ScoreX + 1;
      } else if (winner == 'O') {
        ScoreO = ScoreO + 1;
      } else {
        ScoreX = ScoreX + 1;
        ScoreO = ScoreO + 1;
      }
    });
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Tapped(index);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 100,
                  sigmaX: 100,
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 255, 255, 0.2),
                        Color.fromRGBO(255, 255, 255, 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(
                      XorOturn[index],
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color:
                            XorOturn[index] == 'X' ? Colors.white : Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getturn() {
    return Text(
      isTurnO ? 'Turn X' : 'Turn O',
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
  }

  Widget GetResultButton() {
    return Visibility(
      visible: GameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        onPressed: () {
          setState(() {
            GameHasResult = false;
            ClearGame();
          });
        },
        child: Text(
          '$winnertitle,play again!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
