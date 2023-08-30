/**
 * Topics to demonstrate:
 * 
 * - Basic functions
 * - Parameter options (optional, named, default)
 * - Anonymous functions 
 * - Higher-order functions
 * - Lexical scope (closures)
 */
import 'dart:math';

void main() {
  parameterOptions();
  anonymousFunctions();
  hofs();
  lexicalScoping();
}

/*****************************************************************************/

void parameterOptions() {
  printCharacterSheet('Bob');
  printCharacterSheet('Tom', 50);
  printCharacterSheet('Alice', 1000, 'Fireball');
  printCharacterSheet2(name: 'Bob');
  printCharacterSheet2(name: 'Tom', hp: 50);
  printCharacterSheet2(name: 'Alice', ability: 'Fireball', hp: 1000);
}

void printCharacterSheet(String name, [int hp=100, String? ability]) {
  print('Name: $name');
  print('HP: $hp');
  if (ability != null) {
    print('Ability: $ability');
  }
}

void printCharacterSheet2({
  required String name,
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

int foo(int x) {
  return x * 2;
}

void anonymousFunctions() {
  int Function(int) fn1 = foo;
  var fn2 = foo;

  print('fn1 is ${fn1.runtimeType}');
  print('fn1(5) = ${fn1(5)}');

  var fn3 = (int x) => x * 2;

  var fn4 = (int x) {
    return x * 2;
  };

  var fn5 = ({required int x}) => x * 2;

  print('fn3(5) = ${fn3(5)}');
  print('fn4(5) = ${fn4(5)}');
  print('fn5(x: 5) = ${fn5(x: 5)}');
}

/*****************************************************************************/

void hofs() {
  const list = ['dart', 'is', 'a', 'semi-cool', 'language'];

  final pairs = map(list, (s) => (s.length, s));
  print(pairs);

  final filtered = filter(pairs, (pair) => pair.$1 > 5);
  print(filtered);

  list.forEach((element) => print(element));

  ({'Alice': 30, 'Bob': 25, 'Carol': 28, 'David': 22}).forEach((name, age) {
    print('$name: $age');
  });
}

List<E> map<E,T>(List<T> list, E Function(T) f) {
  // note: `E Function(T) f` is the same as `E f(T)`
  final result = <E>[];
  for (final item in list) {
    result.add(f(item));
  }
  return result;
}

List<E> filter<E>(List<E> list, bool Function(E) pred) {
  // note: `bool Function(E) pred` is the same as `bool pred(E)`
  final result = <E>[];
  for (final item in list) {
    if (pred(item)) {
      result.add(item);
    }
  }
  return result;
}

/*****************************************************************************/

Function makeAdder() {
  int x = Random().nextInt(100);
  print('Made adder with x = $x');
  return (int y) => x + y;
}


void lexicalScoping() {
  final adder = makeAdder();
  print(adder(10));
  print(adder(20));
  print(adder(30));
}
