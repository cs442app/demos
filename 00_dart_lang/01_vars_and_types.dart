/**
 * Topics to demonstrate:
 * 
 * - Static typing
 * - Type inference
 * - Type casting (type conversion)
 * - Type test operators
 * - Null safety
 * - Generics
 * - Final and const variables
 */

void main() {
  simpleTypes();
  nullableTypes();
  complexTypes();
  constAndFinalVars();
}

/*****************************************************************************/

void simpleTypes() {
  // try declaring the following with `var` and initializing them with `null`
  int inum = 42;
  double fpnum = 3.14;
  String snum = '442';

  print('inum.runtimeType = ${inum.runtimeType}');
  print('fpnum.runtimeType = ${fpnum.runtimeType}');
  print('snum.runtimeType = ${snum.runtimeType}');

  // different types
  // inum = fpnum;
  // fpnum = inum;

  // type casting
  // fpnum = inum as double; // type casting

  // explicit type conversions
  // inum = fpnum.toInt();
  // fpnum = inum.toDouble();

  // more type conversions
  // inum = int.parse(snum);
  // snum = inum.toString();

  //local level might not need to delarce types
  //functions or global level yes
  //dynamic type
}

/*****************************************************************************/

void nullableTypes() {
  int n = 10; // try initializing with `null`
  //int n = null;
  //int? n = null; <= then it works (nullable)

  print('n.runtimeType = ${n.runtimeType}');

  print(n == null);

  print(n?.abs()); // `?.` is the null-aware `.` operator

  print(
      10 + (n ?? 0)); // `??` takes a default value if the first operand is null
}

/*****************************************************************************/

void complexTypes() {
  var inum = 42;
  var fpnum = 3.14;
  var snum = '442';

  // what are the inferred types of the following?
  var listOfNum = [inum, fpnum, -5, 0.01];
  var listOfStr = [snum, 'mobile', 'app', 'dev'];
  var listOfAll = [inum, fpnum, snum];
  var listOfUnknown = [];
  var listOfStr2 = <String>[];

  // print('listOfNum.runtimeType = ${listOfNum.runtimeType}');
  // print('listOfStr.runtimeType = ${listOfStr.runtimeType}');
  // print('listOfAll.runtimeType = ${listOfAll.runtimeType}');
  // print('listOfUnknown.runtimeType = ${listOfUnknown.runtimeType}'); //can be anything (not good, avoid dynamic)
  // print('listOfStr2.runtimeType = ${listOfStr2.runtimeType}'); //guess the most specific type, int and doubles are both nums so class nums

  // print(listOfNum[0] + 10);
  // print(listOfAll[0] is int);
  // print(listOfAll[0] + 10); // how to fix this?
  //answer: type cast => print((listOfAll[0] as int)+ 10); // how to fix this?

  // print(listOfStr[0].length);
  // print(listOfAll[2] is String);
  // print(listOfAll[2].length); // how to fix this? type cast

  // listOfUnknown.add('dart');
  // listOfUnknown.add(42);
  // listOfUnknown.add(null);
  // print(listOfUnknown[0].length);
  // print(listOfUnknown[1].length);

  // listOfStr2.add('flutter');
  // listOfStr2.add(42); // is this possible? <= dynamic types
  // listOfStr2.add(null); // is this possible?
  // print(listOfStr2[0].length);
}

/*****************************************************************************/

void constAndFinalVars() {
  var i = 42;
  var l = [1, 2, 3];

  // i = 43;
  // l.add(4);

  final j = 42;
  final m = [1, 2, 3]; //<- can still be change

  // j = 43;
  // m.add(4);

  const k = 42;
  const n = [1, 2, 3]; // <- cannot be change

  // k = 43;
  // n.add(4);

  // print(identical(i, j));
  // print(identical(m, n));
  // print(identical([1, 2, 3], [1, 2, 3]));
  // print(identical(const [1, 2, 3], const [1, 2, 3]));
  // print(identical(m, const [1, 2, 3]));
}
