import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tetris/tetronomes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tetris',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showGameGrid = true;
  bool showPlayButton = true;
  int count = 0;
  int totalSquares = 180;
  String rotateDirection = '';
  int rotationCount = 0; // tracks number of rotations.
  int newPieceID  = 0;  // the index (0-6) of the newPiece seleceted from tetronomePieces
  int rowsClearCount = 0;
  int score = 0;


  static List topRow = [0,1,2,3,4,5,6,7,8,9];

  var newPieceColor = Colors.white;

  List newPiece = []; //

  List landedPieces = []; // list of all the pieces that have played and landed. [ 163,164,165,174]
  var landedPiecesColors = []; //list of all the piece colors that have played and landed.  [{position:0,color;Color.white},{position:1,color:Color.red}....]


  choosePiece() {
    //Pick a Tetronome
    rotationCount = 0; //reset
      setState(() {
        newPieceID = Random().nextInt(tetronomePieces.length);
        //newPieceID   = 0;
        newPiece = [...tetronomePieces[newPieceID]] ;  // Pick a random tetronome
        newPieceColor = tetronomeColors[count % tetronomeColors.length]; // pick colors in sequence from tetronomeColors[]
      });

  }
  moveDown() {
    for (int i = 0; i < newPiece.length; i++) {
      setState(() {
        // Move pieces down every 1 second
        newPiece[i] += 10 ;
      });
    }
  }
  moveRight(){
    if(newPiece.any((element) => (element + 1) % 10 == 0) || newPiece.any((element) => landedPieces.contains(element+1)) ){
      // If block already at right wall, don't move right any more!
      // If block is 1 block to the left of a landed piece already, don't move right any more!
    }else{
      // Move right 1 square
      for (int i = 0; i < newPiece.length; i++) {
        setState(() {
          // Move pieces down every 1 second
          newPiece[i] += 1;
        });
      }
    }

  }
  moveLeft(){
    if(newPiece.any((element) => element % 10 == 0) || newPiece.any((element) => landedPieces.contains(element-1))  ){
      // If block already at left wall, don't move left any more!
      // If block is 1 block to the right of a landed piece already, don't move left any more!
    }
    else{
      // Move left 1 square
      for (int i = 0; i < newPiece.length; i++) {
        setState(() {
          // Move pieces down every 1 second
          newPiece[i] -= 1;
        });
      }
    }
  }
  resetGame(){
    landedPieces = [];
    landedPiecesColors = [];
    count = 0;
    showGameGrid = true;
    score = 0;
    startGame();
  }

  rotatePieceCW(_pieceType){
    newPiece.sort();
    int type = _pieceType;
    List forecastedPiece = [...newPiece];

    if(rotationCount == 0){
      rotationCount++;
    }
    if ( rotationCount % 4 == 1 &&
        newPiece.every((element) => element < 170)
    ){ // check if too close to bottom)
      rotationCount++;
      // forecast the piece is after rotation
      for (int i = 0; i < forecastedPiece.length; i++) {
        if (i == 0) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][0][i];
        } else if (i == 1) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][0][i];
        } else if (i == 2) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][0][i];
        } else if (i == 3) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][0][i];
        }
      }
      // Test if the forecastedPiece will touch any of the landedPiece
      if (!forecastedPiece.any((element) => landedPieces.contains(element))) {
        // rotated piece will not touch any landedPiece.OK
        for (int i = 0; i < newPiece.length; i++) {
          if (i == 0) {
            newPiece[i] = newPiece[i] + rotationPattern[type][0][i];
          } else if (i == 1) {
            newPiece[i] = newPiece[i] + rotationPattern[type][0][i];
          } else if (i == 2) {
            newPiece[i] = newPiece[i] + rotationPattern[type][0][i];
          } else if (i == 3) {
            newPiece[i] = newPiece[i] + rotationPattern[type][0][i];
          }
        }
      } else {rotationCount--;}
    }else if(rotationCount % 4 == 2 &&
        newPiece.every((element) => element < 170)
    ){
      rotationCount++;
      // forecast the piece is after rotation
      for (int i = 0; i < forecastedPiece.length; i++) {
        if (i == 0) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][1][i];
        } else if (i == 1) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][1][i];
        } else if (i == 2) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][1][i];
        } else if (i == 3) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][1][i];
        }
      }
      // Test if the forecastedPiece will touch any of the landedPiece
      if (!forecastedPiece.any((element) => landedPieces.contains(element))) {
        // rotated piece will not touch any landedPiece.OK
        for (int i = 0; i < newPiece.length; i++) {
          if (i == 0) {
            newPiece[i] = newPiece[i] + rotationPattern[type][1][i];
          } else if (i == 1) {
            newPiece[i] = newPiece[i] + rotationPattern[type][1][i];
          } else if (i == 2) {
            newPiece[i] = newPiece[i] + rotationPattern[type][1][i];
          } else if (i == 3) {
            newPiece[i] = newPiece[i] + rotationPattern[type][1][i];
          }
        }
      } else {rotationCount--;}
    }
    else if(rotationCount % 4 == 3 &&
        newPiece.every((element) => element < 170)
    ){
      rotationCount++;
      // forecast the piece is after rotation
      for (int i = 0; i < forecastedPiece.length; i++) {
        if (i == 0) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][2][i];
        } else if (i == 1) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][2][i];
        } else if (i == 2) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][2][i];
        } else if (i == 3) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][2][i];
        }
      }
      // Test if the forecastedPiece will touch any of the landedPiece
      if (!forecastedPiece.any((element) => landedPieces.contains(element))) {
        // rotated piece will not touch any landedPiece.OK
        for (int i = 0; i < newPiece.length; i++) {
          if (i == 0) {
            newPiece[i] = newPiece[i] + rotationPattern[type][2][i];
          } else if (i == 1) {
            newPiece[i] = newPiece[i] + rotationPattern[type][2][i];
          } else if (i == 2) {
            newPiece[i] = newPiece[i] + rotationPattern[type][2][i];
          } else if (i == 3) {
            newPiece[i] = newPiece[i] + rotationPattern[type][2][i];
          }
        }
      } else {rotationCount--;}
    }
    else if(rotationCount % 4 == 0 &&
        newPiece.every((element) => element < 170)
    ){
      rotationCount++;
      // forecast the piece is after rotation
      for (int i = 0; i < forecastedPiece.length; i++) {
        if (i == 0) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][3][i];
        } else if (i == 1) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][3][i];
        } else if (i == 2) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][3][i];
        } else if (i == 3) {
          forecastedPiece[i] = forecastedPiece[i] + rotationPattern[type][3][i];
        }
      }
      // Test if the forecastedPiece will touch any of the landedPiece
      if (!forecastedPiece.any((element) => landedPieces.contains(element))) {
        // rotated piece will not touch any landedPiece.OK
        for (int i = 0; i < newPiece.length; i++) {
          if (i == 0) {
            newPiece[i] = newPiece[i] + rotationPattern[type][3][i];
          } else if (i == 1) {
            newPiece[i] = newPiece[i] + rotationPattern[type][3][i];
          } else if (i == 2) {
            newPiece[i] = newPiece[i] + rotationPattern[type][3][i];
          } else if (i == 3) {
            newPiece[i] = newPiece[i] + rotationPattern[type][3][i];
          }
        }
      } else {rotationCount--;}
    }

  }

  checkRowsToClear(){
    for(int row = 17; row >= 0 ;row--){
      clearRow(row);
    }

  }

  clearRow(_row){
    int rowStartIndex = _row * 10;
    int rowEndIndex = rowStartIndex+9;
    int pieceCountInRow = 0;

    //Check if Row has 10 blocks filled
    for(int i = rowStartIndex ; i <= rowEndIndex; i++){
      if(landedPieces.any((element) => landedPieces.contains(i))){
        pieceCountInRow ++;
      }
    }
    // Clear row
    if(pieceCountInRow == 10){

      for(int i = rowStartIndex; i <= rowEndIndex; i++){
        //Remove reference to items in the cleared row
         landedPieces.removeWhere((element) => element == i);
         landedPiecesColors.removeWhere((element) => element['position'] == i);
       }

      //Drop down all pieces above this row
        for(int i = rowStartIndex; i >= 0; i--) {
          for(int j = 0; j<landedPieces.length;j++){
            if(landedPieces[j] == i){
              landedPieces[j] = i + (10);
            }
          }
        }
      //Increment all landedPiecesColors position +10. This is called the 'Naive' Line Clear method.
      for(int i = rowStartIndex; i >= 0; i--) {
        for(int j = 0; j<landedPiecesColors.length;j++){
          if(landedPiecesColors[j]['position'] == i){
            landedPiecesColors[j]['position'] = i + (10);
          }
        }
      }

      setState(() {
        score += 10;
        landedPieces;
        landedPiecesColors;
      });

      checkRowsToClear();

    }

  }


 bool GameOver(){
  // Check if landedPiece is in Top Row, if it is in topRow then GameOver
    if(landedPieces.any((element) => element <= 9)){
      setState(() {
        showGameGrid = false;
      });
      return true;
    }
    else{
      return false;
    }

  }

  bool hitBottom_hitOtherPiece(_newPiece) {

      bool bottom = false;
      // Check if any of the block in _selectedPiece has hit bottom row(170-179)
      if(_newPiece.any((element) => element >= 170 && element <= 179 )){
        return true;
      }
      // Check if newPiece has hit another landedPiece
      if(_newPiece.any((element) => landedPieces.contains(element + 10)  )){
        return true;
      }
      // nothing hit
      return false;
    }

    void startGame() {
    showPlayButton = false;

     var posColor = {'position':0, 'color':Colors.white};  // declare an object to store position and the color
     choosePiece();

     count++;
      // Drop new Tetronome (newPiece). Once it hits bottom or other pieces, save newPiece tolandedPieces[]
      Timer.periodic(const Duration(milliseconds: 500), (timer) {

        if(GameOver()){
          timer.cancel();
        }else{
          if (hitBottom_hitOtherPiece(newPiece)) {
            //push newPiece into landedPieces[]
            for(int i = 0; i< newPiece.length;i++){
              setState(() {
                landedPieces.add(newPiece[i]);
              });
            }
            // add position of  newPiece and color to landedPieceColor
            for(int i = 0; i< newPiece.length;i++){
              posColor = {'position':newPiece[i] , 'color': newPieceColor};
              landedPiecesColors.add(posColor);
            }
            checkRowsToClear();  // check if rows need to be cleared
            startGame();
            timer.cancel();
          } else {
            moveDown();

          }
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: SingleChildScrollView(
            child: Center(
              child: Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Stack(
                     alignment: Alignment.center,
                     children: [
                       GestureDetector(
                       onTap: () {
                         print('rotate');
                       },
                       onHorizontalDragStart: (details) {
                         print(details);
                       },
                       onHorizontalDragUpdate: (details) {
                           print(details);
                         if (details.delta.dx > 0) {
                          moveRight();
                         } else {
                            moveLeft();
                         }
                       },
                       child: Container(
                         child: SizedBox(
                           width: 300,
                           child: GridView.builder(
                               shrinkWrap: true, //do not use up the entire allowable space of parent
                               physics: const NeverScrollableScrollPhysics(),
                               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   childAspectRatio: 1.05,
                                   crossAxisCount: 10,
                                   //number of columns
                                   crossAxisSpacing: 1,
                                   //gap spacing horizontal between grid elements
                                   mainAxisSpacing: 1 //gap spacing vertical between grid elements
                               ),
                               itemCount: totalSquares,
                               itemBuilder: (BuildContext ctx, index) {
                                 //render landed pieces
                                 if(landedPieces.contains(index)){
                                   return Container(
                                       decoration: BoxDecoration(
                                         color: landedPiecesColors.firstWhere((element) => element['position'] == index)['color'],
                                         borderRadius: BorderRadius.circular(2),
                                       )
                                   );
                                 }
                                 //render new piece
                                 if (newPiece.contains(index)) {
                                   return Container(
                                     // child: Text('$index',style: TextStyle(color: Colors.white)),
                                       decoration: BoxDecoration(
                                         color: newPieceColor,
                                         borderRadius: BorderRadius.circular(2),
                                       )
                                   );
                                 } else {
                                   return Container(
                                     // child: Text('$index',style: TextStyle(color: Colors.white)),
                                     decoration: BoxDecoration(color: Colors.black),
                                   );
                                 }
                               }),
                         ),
                       ),
                     ),
                       Visibility(
                         visible: !showGameGrid,
                         child: Container(
                             child: TextButton(
                               style: TextButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.white, padding: EdgeInsets.all(20)),
                               onPressed: () {
                                  resetGame();
                               },
                               child: Text('Play Again'),
                             )
                         ),
                       ),
                       Visibility(
                         visible: showPlayButton,
                         child: Container(
                             child: TextButton(
                               style: TextButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.white, padding: EdgeInsets.all(20)),
                               onPressed: () {
                                 resetGame();
                               },
                               child: Text('Play'),
                             )
                         ),
                       ),
                       Positioned(
                         top: 50,
                         child: Container(

                           child: score >0? Text('${score}',style:TextStyle(color: Colors.white,fontSize: 25)): Text(''),
                         ),
                       ),
                     ],

                   ),

                    Center(
                      child: Container(
                        width: 360,
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                  color: Colors.white, size: 30.0,),
                                onPressed: () {
                                 moveLeft();
                                },
                              ),
                            ),
                            Container(
                              child: IconButton(icon: const Icon(Icons.arrow_forward,
                                color: Colors.white, size: 30.0,),
                                onPressed: () {
                                    moveRight();
                                },
                              ),
                            ),
                            // Container(
                            //   child: IconButton(icon: const Icon(Icons.arrow_circle_down_sharp,
                            //     color: Colors.white, size: 30.0,),
                            //     onPressed: () {
                            //       setState(() {
                            //
                            //       });
                            //     },
                            //   ),
                            //
                            //
                            // ),
                            Container(
                              child: IconButton(icon: const Icon(Icons.rotate_right,
                                color: Colors.white, size: 30.0,),
                                onPressed: () {
                                  rotatePieceCW(newPieceID);
                                  setState(() {

                                  });
                                },
                              ),
                            ),
                            Container(
                              child: Text('$rotateDirection', style: TextStyle(
                                  color: Colors.white)
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

        ),
      );
    }
  }

