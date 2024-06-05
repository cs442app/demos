// Model classes for Customer and Order, used in eg5.dart

import '../utils/db_helper.dart';

class Customer {
  // id is only populated after the record is saved to the database
  int? id;

  final String name;
  final String email;

  Customer({
    this.id,
    required this.name,
    required this.email,
  });


  // know how to save ourself to the database
  Future<void> dbSave() async {
    // update our id with the newly inserted record's id
    id = await DBHelper().insert('customer', {
      'name': name,
      'email': email,
    });
  }
}


class Order {
  int? id;
  final int customerId;
  final String description;
  final double price;


  Order({
    this.id,
    required this.customerId,
    required this.description,
    required this.price,
  });


  Future<void> dbSave() async {
    id = await DBHelper().insert('purchase_order', {
      'description': description,
      'price': price,
      'customer_id': customerId,
    });
  }

  // delete this record from the database
  Future<void> dbDelete() async {
    if (id != null) {
      await DBHelper().delete('purchase_order', id!);
    }
  }
}
