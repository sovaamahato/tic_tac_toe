import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for confetti
  final _controller=ConfettiController();

  bool isWin=false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  // to add icon
  final String cross = "lib/icons/cancel.png";
  final String circle = "lib/icons/0.png";
  final String edit = "lib/icons/pencil.png";
  bool isCross = true;
  String message = '';
  late List<String> gameState;

  //initialize box with empty value
  @override
  void initState() {
    gameState = List.filled(9, "empty");
    this.message = "";

    super.initState();
  }

  // to play game
  PlayGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = "cross";
        } else {
          this.gameState[index] = "circle";
        }
        isCross = !isCross;
        checkwin();
      });
    }
  }

  //reset game
  resetGame() {
    setState(() {
      gameState = List.filled(9, "empty");
      this.message = "";
      _controller.stop();
    });
  }

  //to get icon
  // ignore: unused_element
  String getImage(String title) {
    switch (title) {
      case ('empty'):
        return edit;
        break;

      case ('cross'):
        return cross;
        break;
      case ("circle"):
        return circle;
        break;
      default:
        return "";
        break;
    }
  }

  //to check winning

  checkwin() {
    if ((gameState[0] != "empty") &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2])) {
      setState(() {
        message = gameState[0] + " Wins";
        
      });
      _controller.play();
    } else if ((gameState[3] != "empty") &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5])) {
      setState(() {
        message = gameState[3] + "Wins";
      });
      _controller.play();
    } else if ((gameState[6] != "empty") &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8])) {
      setState(() {
        message = gameState[6] + " Wins";
      });
      _controller.play();
    } else if ((gameState[0] != "empty") &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6])) {
      setState(() {
        message = gameState[0] + " Wins";
      });
      _controller.play();
    } else if ((gameState[1] != "empty") &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7])) {
      setState(() {
        message = gameState[1] + " Wins";
      });
      _controller.play();
    } else if ((gameState[2] != "empty") &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8])) {
      setState(() {
        message = gameState[2] + " Wins";
      });
      _controller.play();
    } else if ((gameState[0] != "empty") &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8])) {
      setState(() {
        message = gameState[0] + " Wins";
      });
      _controller.play();
    } else if ((gameState[2] != "empty") &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6])) {
      setState(() {
        message = gameState[2] + " Wins";
      });
      _controller.play();
    } else if (!gameState.contains("empty")) {
      setState(() {
        message = "game draw";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac Toe"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
    
            children: [
              SizedBox(height: 50,),
              Text("Let's play 🙌",style: TextStyle(color: Colors.amber[800],fontSize: 20,fontWeight: FontWeight.bold ),),
              SizedBox(height: 50,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10),
                  itemCount: gameState.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right:5.0,bottom: 8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.amber,width: 2)
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            this.PlayGame(index);
                          },
                          child: Image.asset(getImage(gameState[index])),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(message,style: TextStyle(color: Colors.amber[900],fontSize:25),),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  resetGame();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber[700],
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(221, 102, 96, 96),
                              offset: const Offset(
                                3.0,
                                5.0,
                              ),
                              blurRadius: 10)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Reset Game"),
                    )),
              ),
            ],
          ),
        ),
      ),
      ConfettiWidget(confettiController: _controller,blastDirection: pi/2,emissionFrequency: 0.2  ,
      ),
      ],
      
    );
  }
}
