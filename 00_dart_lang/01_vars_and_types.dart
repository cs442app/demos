/**
 * Topics to demonstrate:
 * 
 * - Static typing
 * - Type inference (compiler assigns the tyoe at initialization)
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
  var snum = '442';

  print('inum.runtimeType = ${inum.runtimeType}');
  print('fpnum.runtimeType = ${fpnum.runtimeType}');
  print('snum.runtimeType = ${snum.runtimeType}');

//The below would create errors as diff types cannot be assigned 
  // inum = fpnum;
  // fpnum = inum;

//-------------------
//converting the types and then assigning to a variable would work as long as the result and the assigned variable are of same tyoe
// Original floating-point number  
  print("Original Floating-Point Number: $fpnum");

  // Convert to integer
   inum = fpnum.toInt();
  print("Converted to Integer: $inum");

  // Convert back to double
  fpnum = inum.toDouble();
  print("Converted back to Double: $fpnum");
  inum = fpnum.toInt();
  fpnum = inum.toDouble();
  // fpnum = inum as double;   This would not work as we cannot cast an int into a double directly
//--------------------------

print("Original String: $snum");

  // Convert to integer
  inum = int.parse(snum);
  print("Converted to Integer: $inum");

  // Convert back to string
  snum = inum.toString();
  print("Converted back to String: $snum");
  
}

/*****************************************************************************/

void nullableTypes() {
  int n = -10; // try initializing with `null`
  
  print('n.runtimeType = ${n.runtimeType}');
  print(n == null); //this always going to be false,so, it gives a hint that no need to evaluate
  print(n.abs());
  print(n + 10);

  int? a = null; //to initialize a var to be int or null, use ?

  print(a == null); //this is going to be true
  print(a?.abs()); //we have to put ? as a may be an int or null-->so, if it null-return null,else do .abs()
  print( a ?? 20.toString() + ' Hello' ); //we put ??<value>-->if a is int, print a, ignore all to the right of ??, but if it is null, take default as 20 ,print 20 Hello
 

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

  var listOfUnknown = []; //this is List<dynamic>
  //use of list<object> vs list<dynamic> -->may cause runtime error in dynamic //null cannot be an element in Object
  //when there is element of type (eg-int,double) which cannot access some methods(like .length), but list<object> doesnt allow such types or the property call .length  to be an element at all.
  // .length can be used on types strings,lists, sets,,etc..
  //eg-var listofUnknown =  [1, 'hello', 3.14, null]; the call element.length would only work for hello and not others in runtime
  //but such a assignment in list<object> would show error immediately and doesnt allow to run

  // List<dynamic> listObject = [1, 'hello', 3.14, null];

  // // Using List<Object>
  // for (dynamic element in listObject) {
  //   print('Object: $element, Type: ${element.runtimeType}');

  //   // Uncommenting the line below may result in a runtime error for the 'null' element.
  //   print(element.length); // Error:  Class 'int' has no instance getter 'length'.
  // }


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
  // print(listOfObjs[0] + 10); //Error - Because the element returns an object and not a int value.
  print((listOfObjs[0] as int) + 10);

  print(listOfObjs[2] is String);
  // print(listOfObjs[2].length);Error - Because the element returns an object and not a string value.

  print(listOfStrs[0].length); //works as the elements are strings and not object
}
