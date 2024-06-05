import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:word_generator/word_generator.dart';
import 'package:isar/isar.dart';
import '../models/orders_isar.dart';

class App6 extends StatelessWidget {
  const App6({super.key});

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
  Isar? db;
  List<Customer> customers = [];

  @override
  void initState() {
    super.initState();
    _openDB();
  }

  void _openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    print(dir.path);
    db = Isar.open(
      schemas: [CustomerSchema], 
      directory: dir.path,
      inspector: true
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final customers = <Customer>[];
    if (db != null) {
      customers.addAll(db!.customers.where().findAll());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final person = Customer()
              ..id = db!.customers.autoIncrement()
              ..name = WordGenerator().randomName()
              ..email = '${WordGenerator().randomNoun()}@example.com';
              setState(() {
                db!.write((isar) {
                  isar.customers.put(person);
                });
              });
            }
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
                setState(() { });
            }
          ),            
        ],
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return ListTile(
            title: Text(customer.name ?? ''),
            subtitle: Text(customer.email ?? ''),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderList(db: db!, customer: customer),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  final Isar db;
  final Customer customer;
  const OrderList({super.key, required this.customer, required this.db});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.name ?? ''),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final order = Order()
              ..price = Random().nextDouble() * 100
              ..description = WordGenerator().randomSentence();
              setState(() {
                widget.customer.orders.add(order);
                widget.db.write((isar) {
                  isar.customers.put(widget.customer);
                });
              });
            }
          )
        ],
      ),
      body: ListView.builder(
        itemCount: widget.customer.orders.length,
        itemBuilder: (context, index) {
          final order = widget.customer.orders[index];
          return ListTile(
            title: Text(order.description ?? ''),
            subtitle: Text(order.price.toString()),
          );
        },
      ),
    );
  }
}
