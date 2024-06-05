// Demonstrates:
// - how to persist data to a database
// - how to manage asynchronous data loading
// - swipe-to-delete

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';
import 'package:intl/intl.dart';
import '../models/orders.dart';
import '../utils/db_helper.dart';

class App5 extends StatelessWidget {
  const App5({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomerList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late Future<List<Customer>> _customers;

  @override
  void initState() {
    super.initState();
    _customers = _loadData();
  }

  Future<List<Customer>> _loadData() async {
    final data = await DBHelper().query('customer');
    return data.map((c) => Customer(
      id: c['id'] as int,
      name: c['name'] as String,
      email: c['email'] as String,
    )).toList();    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _customers, 
      initialData: const <Customer>[],
      builder: (context, snapshot) {
        final people = snapshot.data as List<Customer>; 

        return Scaffold(
          appBar: AppBar(
            title: const Text('Customers'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final person = Customer(
                    name: WordGenerator().randomName(),
                    email: '${WordGenerator().randomNoun()}@example.com',
                  );
                  await person.dbSave();
                  setState(() {
                    _customers = _loadData();
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _customers = _loadData();
                  });
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: people.length,
            itemBuilder: (context, index) {
              final person = people[index];
              return ListTile(
                title: Text(person.name),
                subtitle: Text(person.email),
                onTap:() => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderList(customer: person),
                  ),
                )
              );
            },
          ),
        );
      }
    );
  }
}


class OrderList extends StatefulWidget {
  final Customer customer;

  const OrderList({required this.customer, super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late Future<List<Order>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = _loadData();
  }

  Future<List<Order>> _loadData() async {
    final data = await DBHelper().query(
      'purchase_order', 
      where: 'customer_id = ${widget.customer.id!}'
    );
    return data.map((o) => Order(
      id: o['id'] as int,
      description: o['description'] as String,
      price: o['price'] as double,
      customerId: o['customer_id'] as int,
    )).toList();    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _orders, 
      initialData: const <Order>[],
      builder: (context, snapshot) {
        final orders = snapshot.data as List<Order>;
        var formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.customer.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () async {
                  final order = Order(
                    customerId: widget.customer.id!,
                    price: Random().nextDouble() * 100,
                    description: WordGenerator().randomSentence(),
                  );
                  await order.dbSave();
                  setState(() {
                    _orders = _loadData();
                  });
                },
              )
            ],
          ),
          body: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Dismissible(
                key: Key(order.id.toString()), 
                onDismissed: (_) {
                  order.dbDelete();
                  setState(() {
                    orders.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(order.description.toUpperCase()),
                  subtitle: Text(formatter.format(order.price)),
                ),
              );
            },
          ),
        );
      }
    );
  }
}
