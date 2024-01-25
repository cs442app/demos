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
  // break statement is not neccessary.it automatically exits after executing a case.
  // if we want to fall through the next case, use labels (like GOTO) to where the execution should go and use Continue <label>
  print('\nswitch-case:');
  final score = Random().nextInt(100); //100 is exclusive - 0 to 99
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
  // Can use the result of the switch case expression to store and use later
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


  // switch pattern-matching - A way of accessing the components of an iterable directly
  // When we dont know what type of input we get,list/record/named record/map, we can use switch as below.
  // Also, we need not unpack the iterable with a for, we can directly receive it unpacked as varilables inside
  // It matches the brackets and also the type of data inside

  switch (p) {
    case (int x, int y):
      print('p is a pair of int: ($x, $y)');
      break;
    case (x: int a, y: int b):
      print('p is a pair of named ints: (x=$a, y=$b)'); 
      break;
    case [int x, int y]:
      print('p is a list of ints: [$x, $y]'); //can also use indexing like p[0]
      break;

      // Map should have the exact same key x and y .their values should be integers
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

// this function accepts 2 tuples - each with 2 int elements and return one tuple/record
(int,int) vectorAdd((int,int) v1, (int,int) v2) {
  // take each tuple and match them variable inside a tuple
  var (x1,y1) = v1;
  var (x2,y2) = v2;
   return (x1 + x2, y1 + y2);
  // return (v1.$1 + v2.$1, v1.$2 + v2.$2); // can use like this also directly without assigning them labels x1,x2,y1,y2
}
