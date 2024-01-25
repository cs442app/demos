/**
 * Topics to demonstrate:
 * 
 * - Arithmetic operators
 * - Relational operators
 * - Logical operators
 * - Assignment operators
 * - Increment and decrement operators
 * - Conditional (Ternary) operator
 * - Cascade notation
 * - Type test operators
 * - Null safety and related operators
 */

void main() {
  // Arithmetic operators
  int a = 10;
  int b = 3;
  print("Arithmetic Operators:");
  print("$a + $b = ${a + b}");
  print("$a - $b = ${a - b}");
  print("$a * $b = ${a * b}");
  print("$a / $b = ${a / b}");
  print("$a ~/ $b = ${a ~/ b}"); //like "//" integer division in python
  print("$a << $b = ${a << b}"); 
  //bitwise shift - Binary representation of 10 is 00001010. 
  //Left shifting it by 3 positions results in 01010000, which is 80 in decimal.
  
  print("$a >> $b = ${a >> b}");
    //Binary representation of 10 is 00001010. Right shifting it by 3 positions results in 00000001,
  // which is 1 in decimal.
  print("$a & $b = ${a & b}");
  print("$a | $b = ${a | b}");

  // Relational operators
  print("\nRelational Operators:");
  print("$a > $b is ${a > b}");
  print("$a < $b is ${a < b}");
  print("$a >= $b is ${a >= b}");
  print("$a <= $b is ${a <= b}");
  print("$a == $b is ${a == b}");
  print("$a != $b is ${a != b}");

  // Logical operators
  bool x = true;
  bool y = false;
  print("\nLogical Operators:");
  print("$x && $y is ${x && y}");
  print("$x || $y is ${x || y}");
  print("!$x is ${!x}");
  print("!$y is ${!y}");

  // Assignment operators
  int c = 15;
  print("\nAssignment Operators:");
  print("c = $c");
  c += 5;
  print("c += 5 => c = $c");
  c -= 3;
  print("c -= 3 => c = $c");
  c *= 2;
  print("c *= 2 => c = $c");
  c ~/= 3;
  print("c ~/= 3 => c = $c");
  c %= 4;
  print("c %= 4 => c = $c");

  // Increment and decrement operators
  int d = 8;
  print("\nIncrement and Decrement Operators:");
  print("d = $d");
  d++;
  print("d++ => d = $d");
  d--;
  print("d-- => d = $d");

  // Conditional (Ternary) operator
  int e = 12;
  int f = 9;
  int max = e > f ? e : f;
  // if e>f is true, print a else print f-->finding max of e and f
  print("\nConditional (Ternary) Operator:");
  print("Maximum between $e and $f is $max");

  // Cascade notation
  print("\nCascade Notation:");
  List<int> list = [1, 2, 3, 4, 5]
    ..add(6) //used when we recursively perform operations over the same object
    ..add(7)
    ..add(8)
    ..add(9)
    ..add(10);
  print(list);

  // Type test operators
  print("\nType Test Operators:");
  var g = 10;
  print("g is int: ${g is int}"); // "is" refers to the type of the variable
  print("g is! int: ${g is! int}");
}
