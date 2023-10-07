/* Topics demonstrated:
 * - Common list -> detail drill-down pattern
 * - "Editing" and returning new data from a detail page
 * - `async`/`await` syntax
 */

import 'package:flutter/material.dart';
import '../models/macguffin.dart';

class App3 extends StatelessWidget {
  const App3({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App 2',
      home: MacGuffinsListPage(50),
    );
  }
}


class MacGuffinsListPage extends StatefulWidget {
  final int numMacGuffins;

  const MacGuffinsListPage(this.numMacGuffins, {super.key});

  @override
  State<MacGuffinsListPage> createState() => _MacGuffinsListPageState();
}

class _MacGuffinsListPageState extends State<MacGuffinsListPage> {
  late List<MacGuffin> data;

  @override
  void initState() {
    super.initState();

    // In a real app, this data would be fetched from a database or API
    data = List.generate(widget.numMacGuffins,
      (index) => MacGuffin(name: 'MacGuffin ${index + 1}')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MacGuffins')),
      body: ListView.builder(
        itemCount: data.length, 
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].name),
            onTap: () {
              _editMacGuffin(context, index);
            },
          );
        }
      )
    );
  }

  Future<void> _editMacGuffin(BuildContext context, int index) async {
    // `await` suspends execution until the `DetailPage` is popped off the
    // navigation stack, at which point it returns the value passed to
    // `Navigator.pop` (if any)
    var result = await Navigator.of(context).push(
      MaterialPageRoute<MacGuffin>(
        builder: (context) {
          return MacGuffinEditPage(data[index]);
        }
      ),
    );

    // Check that this state object is still associated with a mounted widget
    // for the same reason as discussed before (i.e., the "async gap").
    if (!mounted) return;

    // Check that the result isn't null and is different from the original
    if (result != null && result != data[index]) {
      // Update the model data & rebuild the widget
      setState(() {
        data[index] = result;
      });
    }
  }
}


class MacGuffinEditPage extends StatefulWidget {
  final MacGuffin macguffin;

  const MacGuffinEditPage(this.macguffin, {super.key});

  @override
  State<MacGuffinEditPage> createState() => _MacGuffinEditPageState();
}

class _MacGuffinEditPageState extends State<MacGuffinEditPage> {
  late MacGuffin editedMacGuffin;

  @override
  void initState() {
    super.initState();
    // make a copy of the MacGuffin for editing
    editedMacGuffin = MacGuffin.from(widget.macguffin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit MacGuffin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                initialValue: editedMacGuffin.name,
                decoration: const InputDecoration(hintText: 'Name'),
                onChanged: (value) => editedMacGuffin.name = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextFormField(
                initialValue: editedMacGuffin.description,
                decoration: const InputDecoration(hintText: 'Description'),
                onChanged: (value) => editedMacGuffin.description = value,
              ),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                // Pop the current screen off the navigation stack, and pass
                // the new name back to the previous screen
                Navigator.of(context).pop(editedMacGuffin);
              },
            ),
          ],
        ),
      )
    );
  }
}
