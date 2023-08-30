/**
 * Topics to demonstrate:
 * 
 * - Built-in types, including:
 *     - Strings
 *     - Records
 *     - Lists, Sets, Maps
 * - Pattern matching
 */

void main() {
  strings();
  records();
  collections();
}

/*****************************************************************************/

void strings() {
  // Creating strings
  String greeting = 'Hello,';
  String name = "Alice";

  // Concatenation
  String message = greeting + ' ' + name;
  print(message); // Output: Hello, Alice

  // Interpolation
  String interpolatedMessage = '$greeting $name';
  print(interpolatedMessage); // Output: Hello, Alice

  // Length of a string
  int messageLength = message.length;
  print('Message length: $messageLength'); // Output: Message length: 12

  // Substring
  String sub = message.substring(7);
  print('Substring: $sub'); // Output: Substring: Alice

  // Uppercase and lowercase
  String uppercaseMessage = message.toUpperCase();
  String lowercaseMessage = message.toLowerCase();
  print('Uppercase: $uppercaseMessage'); // Output: Uppercase: HELLO, ALICE
  print('Lowercase: $lowercaseMessage'); // Output: Lowercase: hello, alice

  // Checking if a string contains another string
  bool containsAlice = message.contains('Alice');
  print('Contains "Alice": $containsAlice'); // Output: Contains "Alice": true

  // Finding the index of a substring
  int indexAlice = message.indexOf('Alice');
  print('Index of "Alice": $indexAlice'); // Output: Index of "Alice": 7

  // Removing whitespace from the beginning and end
  String spacedMessage = '  Some spaced message   ';
  String trimmedMessage = spacedMessage.trim();
  print('Trimmed message: "$trimmedMessage"'); // Output: Trimmed message: "Some spaced message"
}

/*****************************************************************************/

void records() {
  (double,double) point1 = (3.14, 2.71);

  (double x, double y) point2 = (3, 2);
  // x and y do not stick

  ({double x, double y}) point3 = (x: 3, y: 2);

  ({double w, double z}) point4 = (w: 4, z: 3);

  //Points 2 and 3 have same type while 4 has different type

  var point5 = ('coordinates', x: 3.5, y: 2.1);

  print(point1.runtimeType);
  print('point.x = ${point1.$1}, point.y = ${point1.$2}');

  print(point2.runtimeType);
  print('point2.x = ${point2.$1}, point2.y = ${point2.$2}');
  // print('point2.x = ${point2.x}, point2.y = ${point2.y}');

  point1 = point2;
  print('point2.x = ${point2.$1}, point2.y = ${point2.$2}');

  print(point3.runtimeType);
  print('point3.x = ${point3.x}, point3.y = ${point3.y}');

  // point1 = point3; // how to fix this? point1 = (point3.x, point3.y)
  // point3 = point4; // how to fix this? point3 = (x:point4.w,y:point4.z)

  print(point5.runtimeType);
  print('${point5.$1}: point5.x = ${point5.x}, point5.y = ${point5.y}');

  var p = point1; // try different values for `p`
  switch (p) {
    case (double x, double y):
      print('p is a pair of doubles: ($x, $y)');
      break;
    case (x: double a, y: double b):
      print('p is a pair of named doubles: (x=$a, y=$b)');
      break;
    case (w: double a, z: double b):
      print('p is a pair of named doubles: (w=$a, z=$b)');
      break;
    case (String label, x: double a, y: double b):
      print('p is a labeled pair of doubles: $label (x=$a, y=$b)');
      break;
  }

  var (x,y) = vectorAdd((1, 2), (3, 4));
  print('x = $x, y = $y');
}

(double,double) vectorAdd((double,double) v1, (double,double) v2) {
  var (x1,y1) = v1;
  var (x2,y2) = v2;
  return (x1 + x2, y1 + y2);
}

/*****************************************************************************/

void collections() {
  // Lists
  List<String> colors = ['red', 'green', 'blue'];
  print('List: $colors');
  print('Second color: ${colors[1]}');
  colors.add('yellow');
  print('List after adding yellow: $colors');
  print('List length: ${colors.length}');

  // Sets
  Set<int> numbers = {1, 2, 3, 4, 5};
  print('\nSet: $numbers');
  numbers.add(3); // Adding a duplicate value
  print('Set after adding duplicate: $numbers');
  numbers.remove(2);
  print('Set after removing 2: $numbers');
  print('Set contains 5: ${numbers.contains(5)}');

  // Maps
  Map<String, int> ages = {
    'Alice': 30,
    'Bob': 25,
    'Carol': 28,
  };
  print('\nMap: $ages');
  ages['David'] = 22;
  print('Map after adding David: $ages');
  print("Alice's age: ${ages['Alice']}");

  // Iterating over collections
  print('\nIterating over list:');
  for (var color in colors) {
    print(color);
  }

  print('\nIterating over set:');
  for (var number in numbers) {
    print(number);
  }

  print('\nIterating over map:');
  for (var entry in ages.entries) {
    print('${entry.key} is ${entry.value} years old');
  }
}
