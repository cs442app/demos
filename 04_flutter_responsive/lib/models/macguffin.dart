import 'dart:math';

import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';


class MacGuffin {
  String name;
  String description;
  double price = 0.0;

  MacGuffin({
    required this.name, 
    this.description = 'A standard-issue MacGuffin', 
    this.price = 0.0
  });

  MacGuffin.from(MacGuffin other)
      : name = other.name,
        description = other.description;

  @override
  bool operator ==(Object other) {
    return other is MacGuffin &&
        other.name == name &&
        other.description == description;
  }
  
  @override
  int get hashCode => name.hashCode ^ description.hashCode;
}


class MacGuffinCollection with ChangeNotifier {
  late List<MacGuffin> _macGuffins;
  int? _selectedIndex;

  MacGuffinCollection(int numMacGuffins) {
    var wordgen = WordGenerator();
    var rng = Random();
    _macGuffins = List.generate(numMacGuffins,
      (index) => MacGuffin(
        name: 'Mc${wordgen.randomName()}',
        description: wordgen.randomSentence(4),
        price: rng.nextDouble() * 100.0,
      )
    );
  }

  int get length => _macGuffins.length;

  int? get selectedIndex => _selectedIndex;
  set selectedIndex(int? index) {
    _selectedIndex = index;
    notifyListeners();
  }

  MacGuffin operator [](int index) => _macGuffins[index];

  void update(int index, MacGuffin macGuffin) {
    _macGuffins[index] = macGuffin;
    notifyListeners();
  }
}
