/**
 * Topics to demonstrate:
 * 
 * - Loops { for, while, do-while, for-in }
 * - Branches { if-else, switch-case }
 * - Pattern matching
 * 
 */

import 'dart:math';


void main() {
  loops();
  branches();
  patterns();
}

/*****************************************************************************/

void loops() {
  // for loop
  print('for loop:');
  for (int i = 0; i < 5; i++) {
    print(i);
  }


  // while loop
  print('\nwhile loop:');
  int i = 0;
  while (i < 5) {
    print(i);
    i++;
  }


  // do-while loop
  print('\ndo-while loop:');
  i = 0;
  do {
    print(i);
    i++;
  } while (i < 5);


  // for-in loop
  print('\nfor-in loop:');
  final list = [1, 2, 3, 4, 5];
  for (final item in list) {
    print(item);
  }
}

/*****************************************************************************/

void branches() {
  // if-else
  print('\nif-else:');
  final x = 5;
  if (x < 5) {
    print('x < 5');
  } else if (x > 5) {
    print('x > 5');
  } else {
    print('x == 5');
  }


  // switch-case
  print('\nswitch-case:');
  final score = Random().nextInt(100);
  print('score = $score');
  switch(score) {
    case 100:
      print('Perfect score!');
      break;
    case >= 90:
      print('A');
      break;
    case >= 80:
      print('B');
      break;
    case >= 70:
      print('C');
      break;
    case >= 60:
      print('D');
      break;
    case < 60 && >= 0:
      print('E');
      break;
    default:
      print('Invalid score!');
  }


  // switch-case as expression
  String? grade = switch(score) {
    100 || >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    >= 60 => 'D',
    < 60 && >= 0 => 'E',
    _ => null, // catch-all case
  };
  print('grade = $grade');
}


/*****************************************************************************/

void patterns() {
  (int,int) point1 = (1, 2);

  ({int x, int y}) point2 = (x: 3, y: 4);

  List<int> point3 = [5, 6];

  Map<String,int> point4 = {'x': 7, 'y': 8};


  var p = point4; // try different values for `p`


  // switch pattern-matching
  switch (p) {
    case (int x, int y):
      print('p is a pair of int: ($x, $y)');
      break;
    case (x: int a, y: int b):
      print('p is a pair of named ints: (x=$a, y=$b)');
      break;
    case [int x, int y]:
      print('p is a list of ints: [$x, $y]');
      break;
    case {'x': int x, 'y': int y}:
      print('p is a map of ints: (x=$x, y=$y)');
      break;
    default:
      print("Can't decode p");
  }


  // if-case pattern matching
  if (p case [int x, int y]) {
    print('p is a list of ints!');
  }


  // pattern matching return values
  var (x,y) = vectorAdd((1, 2), (3, 4));
  print('x = $x, y = $y');
}


(int,int) vectorAdd((int,int) v1, (int,int) v2) {
  var (x1,y1) = v1;
  var (x2,y2) = v2;
  return (x1 + x2, y1 + y2);
}
