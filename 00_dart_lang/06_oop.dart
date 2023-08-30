/**
 * Topics to demonstrate:
 * 
 * - Classes
 * - Constructors
 * - Getters & Setters
 * - Inheritance
 * - Mixins
 * - Operator overloading
 * - Generics
 */

// Classes
class Shape {
  double area() {
    return 0;
  }
}

class Circle extends Shape {
  double radius;

  // Constructors
  Circle(this.radius);

  // Getters and Setters
  double get diameter => radius * 2;
  set diameter(double value) => radius = value / 2;

  @override
  double area() {
    return 3.14159 * radius * radius;
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  // Constructors
  Rectangle(this.width, this.height);

  @override
  double area() {
    return width * height;
  }
}

// Mixin
mixin PositionMixin {
  double x = 0;
  double y = 0;
}

class PositionedCircle extends Circle with PositionMixin {
  PositionedCircle(double radius, double x, double y)
      : super(radius) {
    this.x = x;
    this.y = y;
  }
}

// Operator Overloading
class Vector {
  double x, y;

  Vector(this.x, this.y);

  Vector operator +(Vector other) {
    return Vector(x + other.x, y + other.y);
  }
}

// Generics
class Box<T> {
  T value;

  Box(this.value);
}

void main() {
  // Using the classes and demonstrating features
  Circle circle = Circle(5);
  print('Circle Area: ${circle.area()}');
  print('Circle Diameter: ${circle.diameter}');
  circle.diameter = 10;
  print('Updated Circle Radius: ${circle.radius}');

  Rectangle rectangle = Rectangle(4, 6);
  print('Rectangle Area: ${rectangle.area()}');

  PositionedCircle pCircle = PositionedCircle(8, 2, 5);
  print('Positioned Circle Area: ${pCircle.area()}');
  print('Positioned Circle Position: (${pCircle.x}, ${pCircle.y})');

  Vector v1 = Vector(3, 4);
  Vector v2 = Vector(1, 2);
  Vector sum = v1 + v2;
  print('Vector Sum: (${sum.x}, ${sum.y})');

  Box<int> intBox = Box(42);
  print('Integer Box Value: ${intBox.value}');
}
