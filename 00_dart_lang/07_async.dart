import 'dart:async';

void main() {
  print('main() started');
  switch (1) {
    case 1:
      asyncFunction1a();
      break;
    case 2:
      var future = asyncFunction2a();
      future.then((result) {
        print('Future resolved in main with result: $result');
      });
      // below requires main to be async
      // var result = await asyncFunction2b();
      // print('Future resolved in main with result: $result');
      break;
    case 3:
      asyncFunction3a();
      break;
    case 4:
      asyncFunction4a();
      // create a timer that repeatedly invokes a callback
      Timer.periodic(Duration(milliseconds: 500), (timer) {
        print('Timer tick');
      });
      break;
  }
  print('main() finishing');
}

// obtain a future and runs a handler on its completion
void asyncFunction1a() {
  print('asyncFunction1a() started');

  Future<int> future = Future<int>.delayed(Duration(seconds: 2), () {
    return 42;
  });

  future.then((result) => print('Future resolved with result: $result'));

  print('asyncFunction1a() finishing');
}

// same as above but using async/await
void asyncFunction1b() async {
  print('asyncFunction1b() started');

  var result = await Future<int>.delayed(Duration(seconds: 2), () {
    return 42;
  });

  print('Future resolved with result: $result');

  print('asyncFunction1b() finishing');
}

// return a future
Future<int> asyncFunction2a() {
  return Future.value(42);
}

// same as above but using async/await
Future<int> asyncFunction2b() async {
  return 42;
}

// obtain a future and deal with errors in its completion
void asyncFunction3a() {
  print('asyncFunction3a() started');

  Future<int> future = Future<int>.delayed(Duration(seconds: 2), () {
    throw Exception('Error in asyncFunction3a()');
  });

  future
      .then((result) => print('Future resolved with result: $result'))
      .catchError((error) => print('Future failed with error: $error'));

  print('asyncFunction3a() finishing');
}

// same as above but using async/await
void asyncFunction3b() async {
  print('asyncFunction3b() started');

  try {
    var result = await Future<int>.delayed(Duration(seconds: 2), () {
      throw Exception('Error in asyncFunction3a()');
    });

    print('Future resolved with value: $result');
  } catch (error) {
    print('Future failed with error: $error');
  }

  print('asyncFunction3b() finishing');
}

// same as below but with explicit futures
void asyncFunction4a() {
  print('asyncFunction4a() started');

  Future<int> future1 = Future<int>.delayed(Duration(seconds: 1), () => 42);

  future1.then((result) {
    print('First future resolved with result: $result');

    Future<int> future2 = Future<int>.delayed(Duration(seconds: 1), () => 43);

    future2.then((result) {
      print('Second future resolved with result: $result');

      Future<int> future3 = Future<int>.delayed(Duration(seconds: 1), () => 44);

      future3.then((result) {
        print('Third future resolved with result: $result');
      });
    });
  });

  // a better way to chain futures (allows for easier exception handling)
  // future1
  //     .then((result) {
  //       print('First future resolved with result: $result');
  //       return Future<int>.delayed(Duration(seconds: 1), () => 43);
  //     })
  //     .then((result) {
  //       print('Second future resolved with result: $result');
  //       return Future<int>.delayed(Duration(seconds: 1), () => 44);
  //     })
  //     .then((result) {
  //       print('Third future resolved with result: $result');
  //     });

  print('asyncFunction4a() finishing');
}

// multiple futures
void asyncFunction4b() async {
  print('asyncFunction4b() started');

  var result = await Future.delayed(Duration(seconds: 1), () => 42);
  print('First future resolved with result: $result');

  result = await Future.delayed(Duration(seconds: 1), () => 43);
  print('Second future resolved with result: $result');

  result = await Future.delayed(Duration(seconds: 1), () => 44);
  print('Third future resolved with result: $result');

  print('asyncFunction4b() finishing');
}
