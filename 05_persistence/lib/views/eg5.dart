// Demonstrates:
// - how to persist data to a database
// - how to manage asynchronous data loading
// - swipe-to-delete

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_generator/word_generator.dart';
import 'package:intl/intl.dart';
import '../models/orders.dart';
import '../utils/db_helper.dart';

class App5 extends StatelessWidget {
  const App5({super.key});

  Future<List<Customer>> _loadData() async {
    final data = await DBHelper().query('customer');
    return data.map((e) => Customer(
      id: e['id'] as int,
      name: e['name'] as String,
      email: e['email'] as String,
    )).toList();    
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureProvider<List<Customer>?>(
        create: (_) => _loadData(),
        initialData: null,
        child: const CustomerList()
      ),
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
  @override
  Widget build(BuildContext context) {
    final people = Provider.of<List<Customer>?>(context);
    
    if (people == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = Customer(
            name: WordGenerator().randomName(),
            email: '${WordGenerator().randomNoun()}@example.com',
          );
          await person.dbSave();
          setState(() {
            people.add(person);
          });
        },
        child: const Icon(Icons.add),
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
}


class OrderList extends StatefulWidget {
  final Customer customer;

  const OrderList({required this.customer, super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late Future<List<Order>> _orders;

  Future<List<Order>> _loadData() async {
    final data = await DBHelper().query(
      'purchase_order', 
      where: 'customer_id = ${widget.customer.id!}'
    );
    return data.map((e) => Order(
      id: e['id'] as int,
      description: e['description'] as String,
      price: e['price'] as double,
      customerId: e['customer_id'] as int,
    )).toList();    
  }


  @override
  void initState() {
    super.initState();
    _orders = _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _orders, 
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final orders = snapshot.data as List<Order>;
          var formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.customer.name),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final order = Order(
                  customerId: widget.customer.id!,
                  price: Random().nextDouble() * 100,
                  description: WordGenerator().randomSentence(),
                );
                await order.dbSave();
                setState(() {
                  orders.add(order);
                });
              },
              child: const Icon(Icons.add),
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
      }
    );
  }
}
