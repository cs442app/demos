// after editing this file, run `dart run build_runner build` 
// to generate the orders_isar.g.dart file

import 'package:isar/isar.dart';
part 'orders_isar.g.dart';

@collection
class Customer {
  late int id;
  String? name;
  String? email;

  List<Order> orders = List.empty(growable: true);
}

@embedded
class Order {
  String? description;
  double? price;
}
