/*
 * Topics to demonstrate:
 * 
 * - Basic functions
 * - Parameter options (optional, named, default)
 * - Anonymous functions 
 * - Higher-order functions
 * - Lexical scope (closures)
 */
import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main() {
  // parameterOptions();
  // anonymousFunctions();
  // hofs();
  lexicalScoping();
}

/*****************************************************************************/

void parameterOptions() {
  printCharacterSheet('Bob');
  printCharacterSheet('Tom', 50);
  printCharacterSheet('Alice', 1000, 'Fireball');
  printCharacterSheet2(name: 'Bob');
  printCharacterSheet2(name: 'Tom', hp: 50);
  printCharacterSheet2(name: 'Alice', ability: 'Fireball', hp: 1000); // named arguements can be any order
}

// [] ---used for optional parameters, so they have to have a default value.
// hp is assigned 100 by default and string can be null by default becoz '?' if  corresponding arguement are not passed
// These parameters are not named and hence arguements should be sent in same order

void printCharacterSheet(String name, [int hp=100, String? ability]) {
  print('Name: $name');
  print('HP: $hp');
  if (ability != null) {
    print('Ability: $ability');
  }
}

// different way of writing -  named optional parameters.using{}
void printCharacterSheet2({
  required String name,  // unless specified as required, it is optional
  int hp=100,
  String? ability,
}) {
  print('Name: $name');
  print('HP: $hp');
  if (ability != null) {
    print('Ability: $ability');
  }
}

/*****************************************************************************/
// Example of a simple fn creation in a general way of doing it
int foo(int x) {
  return x * 2;
}

// Anonymous function can be used in higher order functions( where fn is passed as arguement)
void anonymousFunctions() {
  int Function(int) fn1 = foo; //assigning name to the function - fn1 is a function now with logic of foo
  var fn2 = foo; // TYpe inference determines based on the value assigned on right "foo" which is a function that takes & returns an int 

  print('fn1 is ${fn1.runtimeType}'); //output -(int) => int
  print('fn2 is ${fn2.runtimeType}');
  print('fn1(5) = ${fn1(5)}'); //call function foo using the assigned variable fn1
  print('fn2(5) = ${fn2(5)}');

  var fn3 = (int x) => x * 2; //creating simple fn on the fly --> take int as input and return x*2

  var fn4 = (int x) {  //creating multiline function on the fly
    x *= 2; 
    return x;
  };

  var fn5 = ({required int x}) => x * 2; //creating named function on the fly

  print('fn3(5) = ${fn3(5)}');
  print('fn4(5) = ${fn4(5)}');
  print('fn5(x: 5) = ${fn5(x: 5)}');
}

/*****************************************************************************/
//map is a function that takes a list of T type elements and return a list of E type elements 
//by perfroming an operation defined by the function(f) on every T elements of the input list

List<E> map<E,T>(List<T> list, E Function(T) f) {
  // note: `E Function(T) f` is the same as `E f(T)` - this is the input function  which makes the operation
  final result = <E>[];  //return list will have E type elements 
  for (final item in list) {
    result.add(f(item));
  }
  return result;
}


List<E> filter<E>(List<E> list, bool Function(E) pred) {
  // note: `bool Function(E) pred` is the same as `bool pred(E)` - function returns bool which is used to evaluate condition
  final result = <E>[];
  for (final item in list) {
    if (pred(item)) {
      result.add(item);
    }
  }
  return result;
}

void hofs() {
  const list = ['dart', 'is', 'a', 'semi-cool', 'language'];


  final pairs = map(list, (s) => (s.length, s)); //send the input list and function to be performed and return a tuple/record
  print(pairs);

  //pairs from above-->list of (tuples with 2 values)---the tuple should be filtered based on the 1st element in every tuple
  final filtered = filter(pairs, (pair) => pair.$1 > 5);
  print(filtered);


//******most common way of doing map function******
  list.map((s) => (s.length, s))
      .where((pair) => pair.$1 > 5)
      .forEach((element) => print(element));


  var grades = <String, List<double>> {
    'Alice': [90, 100, 95],
    'Bob': [90, 80, 85],
    'Carol': [70, 75, 80],
    'David': [60, 70, 65],
  };


  grades.forEach((name, scores) {
    final maxScore = scores.reduce(max);//take a list, reduce the list to contain only the max element
    print('$name: $maxScore');
  });

// This code asynchronously processes the HTTP request and response, 
//  demonstrating the use of Dart's Future and Stream concepts for asynchronous programming.

  HttpClient()
      .getUrl(Uri.parse('https://moss.cs.iit.edu/cs440'))
      .then((request) => request.close())
      .then((response) => response.transform(Utf8Decoder()))
      .then((utf8) => utf8.transform(LineSplitter()))
      .then((lines) => lines.take(10).forEach((line) => print(line)));
}

/*****************************************************************************/

// A function returns a function
// Generally, the local variables are stored in a stack and 
// when the execution comes out of the scope of that variable, it is deleted/memory deallocated
// In this case, the value of x is retained - why? lexical scoping/closure.

Function makeAdder() {
  int x = Random().nextInt(100);
  print('Made adder with x = $x');
  return (int y) { 
    x+=1;
    print(x);
    return x + y;
    };
}

// This concept is known as a closure, where the inner function has access to the variables 
// of its outer function, even after the outer function has completed.
// Any function generally keeps the variables that it needs access to . The variable is not delted/de-allocated

// THere are 2 functions below and each of thme have their own value of x associated with their own instances of the function stored in variables 1 and 2
void lexicalScoping() {
  final adder1 = makeAdder();
  final adder2 = makeAdder();  //when called we get the function in adder ->(int y) => x + y--that returned function has the generated value of x also as it needs x in its current scope. 
  print('adder 1: ${adder1(10)}'); //when this is called , it has the fn (int y) => x + y, which takes 10 as input for y and adds with the random x value stored already
  print('adder 2: ${adder2(10)}');
  print('adder 1: ${adder1(20)}');
  print('adder 2: ${adder2(20)}');
}
