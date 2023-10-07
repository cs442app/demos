/// Demonstrates the use of Flexible and Expanded widgets,
/// and how they interpret the "flex" property.

// From the docs: 
//
// flex: The flex factor to use for this child. If null or zero, the child is
// inflexible and determines its own size. If non-zero, the amount of space the
// child's can occupy in the main axis is determined by dividing the free space 
// (after placing the inflexible children) according to the flex factors of the
// flexible children.
//
// Expanded: A widget that expands a child of a Row, Column, or Flex so that 
// the child fills the available space.
// 
// Flexible: ... unlike Expanded, Flexible does not require the child to fill
// the available space.


import 'package:flutter/material.dart';

class App1 extends StatelessWidget {
  // try change the following two properties
  final Axis direction       = Axis.vertical;
  final List<int> flexValues = const [1, 1, 2];

  get childDirection => direction == Axis.horizontal 
                        ? Axis.vertical 
                        : Axis.horizontal;

  const App1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Flex(
          direction: direction,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlexibleChildren(childDirection, flexValues),
            ExpandedChildren(childDirection, flexValues),
            FlexibleAndExpandedChildren(childDirection, flexValues),
          ],
        )
      ),
    );
  }
}


class FlexibleChildren extends StatelessWidget {
  final Axis direction;
  final List<int> flexValues;

  const FlexibleChildren(
    this.direction, this.flexValues, 
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Flex(
        direction: direction,
        children: [
          Flexible(
            flex: flexValues[0],
            child: Container(
              color: Colors.blue,
              child: const Text('Flexible'),
            ),
          ),
          Flexible(
            flex: flexValues[1],
            child: Container(
              color: Colors.green,
              child: const Text('Flexible'),
            ),
          ),
          Flexible(
            flex: flexValues[2],
            child: Container(
              color: Colors.yellow,
              child: const Text('Flexible'),
            ),
          ),
        ],
      ),
    );
  }
}


class ExpandedChildren extends StatelessWidget {
  final Axis direction;
  final List<int> flexValues;

  const ExpandedChildren(
    this.direction, this.flexValues,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Flex(
        direction: direction,
        children: [
          Expanded(
            flex: flexValues[0],
            child: Container(
              color: Colors.blue,
              child: const Text('Expanded'),
            ),
          ),
          Expanded(
            flex: flexValues[1],
            child: Container(
              color: Colors.green,
              child: const Text('Expanded'),
            ),
          ),
          Expanded(
            flex: flexValues[2],
            child: Container(
              color: Colors.yellow,
              child: const Text('Expanded'),
            ),
          ),
        ],
      ),
    );
  }
}


class FlexibleAndExpandedChildren extends StatelessWidget {
  final Axis direction;
  final List<int> flexValues;

  const FlexibleAndExpandedChildren(
    this.direction, this.flexValues,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Flex(
        direction: direction,
        children: [
          Flexible(
            flex: flexValues[0],
            child: Container(
              color: Colors.blue,
              child: const Text('Flexible'),
            ),
          ),
          Expanded(
            flex: flexValues[1],
            child: Container(
              color: Colors.green,
              child: const Text('Expanded'),
            ),
          ),
          Flexible(
            flex: flexValues[2],
            child: Container(
              color: Colors.yellow,
              child: const Text('Flexible'),
            ),
          ),
        ],
      ),
    );
  }
}
