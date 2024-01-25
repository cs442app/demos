/**
 * Topics to demonstrate:
 * 
 * - Classes
 * - Constructors
 * - Getters & Setters
 * - Inheritance
 * - Mixins
 * - Operator overloading
 * - Object identity, equality, and constant objects
 */

import 'dart:math';


// Classes
class Shape {
  double area() {
    return 0; // can we get rid of this definition?
  }
}


// Inheritance
class Circle extends Shape {
  double radius;

  // Constructor
  Circle(this.radius);
  //  keyword "this" is used only in constructor
  // Circle(double rad) : radius = rad;  // Another way of writing constructor

  // Getters and Setters
  double get diameter => radius * 2;  
  // this is a way assigning fn to a variable using get. 
  // So, to call this fn, we can use like an attribute .diameter instead of diameter() which returns r*2

  set diameter(double value) => radius = value / 2;
  // In set, we dont return anything, we set the instance attribute radius to value/2.So, whenever a diameter variable is intialized, radius automatically updated
  //it is called using the assignment operator - .diameter = 20;

  double area() {
    return 3.14159 * radius * radius;
  }

  // Operator overloading - + symbol
  // adding the radius of 2 circles and forming a new circle
  Circle operator +(Circle other) {
    return Circle(this.radius + other.radius);
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  // Constructors
  Rectangle(this.width, this.height);

  double area() {
    return width * height;
  }
}

class Square extends Rectangle {
  // Constructor with initializer list
  Square(double side) : super(side, side); 
  // initializing its super class att/ w and h as side, side so that we can access the super class function 
  // area to calculate the square area
}


// Mixin -> used as alternative of multiple inheritence ->which may sometimes cause confusion
// Mixin are those that can provide its functions and attributes when used but not inherited

mixin Positioned {
  double x = 0;
  double y = 0;

// distance b/w 2 points formula --> sqrt[(x2-x1)^2 +(y2-y1)^2]
  double distanceTo(Positioned other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

//inheritance takes precedence than mixins->inherited variable uses ->super, 
// mixin variables that are passed on are treated as separate variables sent over arguements which can be copied from  mixins

class PositionedCircle extends Circle with Positioned {
  PositionedCircle(double radius, double x, double y)
      : super(radius) {
    this.x = x;
    this.y = y;
  }
}

class Blob with Positioned {
  final String name;

  Blob(this.name, double x, double y) {
    this.x = x;
    this.y = y;
  }
}


// Object identity, equality, and constant objects

// final variables can only be initialized once and should be done before its used in the body of the function.
// Ideally, it is expected to be done in constructor
// if we would like final variable o be intialized later in the body, then use late
class Foo {
  final int x;
  late int y;
  //  final int  y;
  
  // Foo(this.x, this.y); // one way of intializing
  Foo (int xp, int yp) : x = xp { 
    y=yp; // it can be intialized in body as it is late but x cant be done here bcz it is final
    // x = xp;
    }

  // const Foo(this.x, this.y); // compile time const constructor cannto have body, they should be intialized in compile time


// comapring this object with "other" - Equality
  bool operator ==(Object other) {
    if (other is Foo) { //check if the "other" object is also an instance of foo
      return x == other.x && y == other.y;
    }
    return false;
  }

// hashcode fn should align with equality 
// hashcode - store the objects of the maps(hashtable) - unformly distributes where the object sits

  int get hashCode => x.hashCode ^ y.hashCode;

}


void main() {
  var circle = Circle(5);  // 5 is assigned as the radius
  print('Circle Area: ${circle.area()}');
  print('Circle Diameter: ${circle.diameter}'); //getter attribute
  print('Is Circle a Shape? ${circle is Shape}'); //Inherited


  circle.diameter = 50; //setter attribute calls setter function
  print('Updated Circle Radius: ${circle.radius}');


  var circle2 = circle + Circle(8);
  print('Circle2 Radius: ${circle2.radius}');
  print('Circle2 Area: ${circle2.area()}');


  var rectangle = Rectangle(4, 6);
  print('Rectangle Area: ${rectangle.area()}');


  var square = Square(5);
  print('Is Square a Shape? ${square is Shape}');
  print('Is Square a Rectangle? ${square is Rectangle}');
  print('Square Area: ${square.area()}');


  var pCircle = PositionedCircle(8, 2, 5);

  print('Positioned Circle Area: ${pCircle.area()}');
  print('Positioned Circle Position: (${pCircle.x}, ${pCircle.y})');
  print('Is Positioned Circle a Circle? ${pCircle is Circle}');
  print('Is Positioned Circle Positioned? ${pCircle is Positioned}');


  var blob = Blob('Flubber', 5, 1);
  print('Is Blob a Shape? ${blob is Shape}');
  print('Is Blob Positioned? ${blob is Positioned}');
  print('Distance between Circle and Blob: ${pCircle.distanceTo(blob)}');


  // how to make the following const objects? what does it mean?
  var foo1 = Foo(5, 10);
  var foo2 = Foo(5, 10);

  //foo1 and foo2 are 2 diff instances and hence they are not identical

  print('foo1 == foo2? ${foo1 == foo2}'); //instances of same class
  print('foo1.hashCode == foo2.hashCode? ${foo1.hashCode == foo2.hashCode}');
  print('foo1 identity == foo2 identity? ${identical(foo1, foo2)}'); //2 diff instances

// when the constructor is a compile time cost constructor, when a function is called twice, it doesnt create 2 instances, 
//  instead it just looks up the existing instance , so here foo1 and foo2 refer to the same instance and they are identical
  // var foo1 = const Foo(5, 10);
  // var foo2 = const Foo(5, 10);

  // print('foo1 == foo2? ${foo1 == foo2}');
  // print('foo1.hashCode == foo2.hashCode? ${foo1.hashCode == foo2.hashCode}');
  // print('foo1 identity == foo2 identity? ${identical(foo1, foo2)}');

}
