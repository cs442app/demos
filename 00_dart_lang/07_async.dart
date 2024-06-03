void main() {
  print('main() started');
  switch(1) {
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
  future.then((result) => print('Future resolved with result: $result'))
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
