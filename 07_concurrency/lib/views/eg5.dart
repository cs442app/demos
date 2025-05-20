import 'dart:async';
import 'dart:isolate';

class BackgroundProcessor {
  Isolate? _isolate;
  late SendPort _sendPort;
  final _responseController = StreamController<dynamic>();

  Stream<dynamic> get responses => _responseController.stream;

  Future<void> start() async {
    final receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_entryPoint, receivePort.sendPort);

    // used to wait for the SendPort from the new isolate
    final completer = Completer<SendPort>();

    receivePort.listen((message) {
      // The first message should be the SendPort from the new isolate.
      if (message is SendPort) {
        _sendPort = message;

        // signal that we have the SendPort
        completer.complete(message);
      } else {
        _responseController.add(message);
      }
    });

    // don't proceed until we have the SendPort
    await completer.future;
  }

  // Send data to the isolate.
  void send(dynamic message) {
    _sendPort.send(message);
  }

  void dispose() {
    _responseController.close();
    _isolate?.kill(priority: Isolate.immediate);
  }

  // Entry point for the isolate.
  static void _entryPoint(SendPort sendPort) {
    final port = ReceivePort();
    // Send the send port of this isolate back to the main isolate.
    sendPort.send(port.sendPort);
    port.listen((message) {
      // Here you could perform any computation. For now, we just echo the message.
      // In a real-world scenario, insert your heavy or stateful computation here.
      sendPort.send('Processed: $message');
    });
  }
}

void main() async {
  final processor = BackgroundProcessor();
  await processor.start();

  // Send a message to the isolate.
  processor.send("Hello, Isolate!");

  // Listen for responses from the isolate.
  processor.responses.listen((data) {
    print(data); // Should print "Processed: Hello, Isolate!"
  });

  // Remember to dispose of the processor when done.
  // processor.dispose();
}
