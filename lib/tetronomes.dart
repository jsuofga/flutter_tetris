import 'package:flutter/material.dart';


// The 7 Tetronomes Shapes
// [-7,-6,-5,-4] straight Type 0
// [-6,-5,-16,-15] square Type 1
// [-16,-15,-14,-5] T Type 2
// [-16,-15,-14,-4] L Type 3
// [-16,-15,-14,-6] _| Type 4
// [-6,-5,-15,-14] S Type 5
// [-5,-4,-16,-15]  Z Type 6

List tetronomePieces =
[
  [-7, -6, -5, -4],
  [-6, -5, -16, -15],
  [-16,-15,-14,-5],
  [-16,-15,-14,-4],
  [-16,-15,-14,-6],
  [-6, -5, -15, -14],
  [-5, -4, -16, -15]
];

 List tetronomeColors =
[
  Colors.purple,
  Colors.lightGreenAccent,
  Colors.orange,
  Colors.blue,
  Colors.yellowAccent,
  Colors.brown,
  Colors.red
];


List rotationPattern = [
  [
    [0,(10-1),(20-2),(30-3)], // Rotation 1
    [ 0, - (10)+1,- (20)+2,- (30)+3 ], // Rotation 2
    [0,(10)-1,(20)-2,(30)-3], // Rotation 3
    [0, - (10)+1,- (20)+2,- (30)+3 ], // Rotation 4
  ], //Type 0
  [
    [0,0,0,0], // Rotation 1
    [0,0,0,0], // Rotation 2
    [0,0,0,0], // Rotation 3
    [0,0,0,0], // Rotation 4
  ], //Type 1
  [
    [1,10,(20-1),-1], // Rotation 1
    [(10)+1,- (10)+1,0,- (10)-1], // Rotation 2
    [10,-10,-1,(10)-2], // Rotation 3
    [2,- (10)+1,- (10)-1,- (10)+1], // Rotation 4
  ], //Type 2
  [
    [1,(10),(20)-1,(10)-2], // Rotation 1
    [(10) +1,0,-20,- (10)-1], // Rotation 2
    [1,-10,-1,(10)-2], // Rotation 3
    [2,(10)+1,-(10)+1,-20], // Rotation 4
  ], //Type 3
  [
    [1,10,(20)-1,-10], // Rotation 1
    [2,(10)+1,0,- (10)-1], // Rotation 2
    [(20)-1,-10,-1, (10)-2], // Rotation 3
    [2,- (10)+1,-20,- (10)-1], // Rotation 4
  ], //Type 4
  [
    [10,(20)-1,-10,-1], // Rotation 1
    [2,- (10)+1,0,- (10)-1], // Rotation 2
    [10,(20)-1,-10,-1], // Rotation 3
    [2,- (10)+1,0,- (10)-1], // Rotation 4
  ], //Type 5
  [
    [1,10,-1,(10)-2], // Rotation 1
    [(10)+1,1,-10,-20], // Rotation 2
    [1,10,-1,(10)-2], // Rotation 3
    [(10)+1,1,-10,-20], // Rotation 4
  ],//Type 6
];