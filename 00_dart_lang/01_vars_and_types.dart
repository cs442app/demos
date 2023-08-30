/**
 * Topics to demonstrate:
 * 
 * - Static typing
 * - Type inference
 * - Type casting (type conversion)
 * - Type test operators
 * - Null safety
 * - Generics
 */

void main() {
  simpleTypes();
  nullableTypes();
  complexTypes();
}

/*****************************************************************************/

void simpleTypes() {
  // try declaring the following with `var` and initializing them with `null`
  int inum = 42;
  double fpnum = 3.14;
  String snum = '442';
  // We should make the above var not directly declared

  print('inum.runtimeType = ${inum.runtimeType}');
  print('fpnum.runtimeType = ${fpnum.runtimeType}');
  print('snum.runtimeType = ${snum.runtimeType}');

  // Statically typed so does not work
  // inum = fpnum;
  // fpnum = inum;

  inum = fpnum.toInt();
  fpnum = inum.toDouble();
  // fpnum = inum as double;
  // ^ explicit type cast still fails as int not subclass of double


  inum = int.parse(snum);
  snum = inum.toString();
}

/*****************************************************************************/

void nullableTypes() {
  int n = 10; // try initializing with `null`
  // to declare as null: int? n = null;

  print('n.runtimeType = ${n.runtimeType}');

  print(n == null);

  print(n.abs());
  // if using int? do the following: print(n?.abs()); which only if not null will do abs()

  print(n + 10);
  // if using int? can do following: print(n!+10); which ensures that n is not null
}

/*****************************************************************************/

void complexTypes() {
  var inum = 42;
  var fpnum = 3.14;
  var snum = '442';

  var listOfAll = [inum, fpnum, snum];

  List<Object> listOfObjs = [inum, fpnum, snum];

  var listOfNums = [inum, fpnum, -5, 0.01];

  var listOfStrs = [snum, 'mobile', 'app', 'dev'];

  var listOfUnknown = [];

  var listOfStrs2 = <String>[];

  List<String> listOfStrs3 = [];

  print('listOfAll.runtimeType = ${listOfAll.runtimeType}');
  print('listOfObjs.runtimeType = ${listOfObjs.runtimeType}');
  print('listOfNums.runtimeType = ${listOfNums.runtimeType}');
  print('listOfStrs.runtimeType = ${listOfStrs.runtimeType}');
  print('listOfUnknown.runtimeType = ${listOfUnknown.runtimeType}');
  print('listOfStrs2.runtimeType = ${listOfStrs2.runtimeType}');
  print('listOfStrs3.runtimeType = ${listOfStrs3.runtimeType}');

  print(listOfObjs[0] is int);
  // print(listOfObjs[0] + 10);
  // print((listOfObjs[0] as int) + 10);
  print(listOfObjs[2] is String);
  // print(listOfObjs[2].length);

  print(listOfStrs[0].length);
}