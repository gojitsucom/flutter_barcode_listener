import "package:flutter/material.dart";
import "package:flutter_barcode_listener/flutter_barcode_listener.dart";
import "package:visibility_detector/visibility_detector.dart";

import "second_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Barcode Scanner Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: "Barcode Scanner Demo"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String? _barcode;
  late bool visible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Add visiblity detector to handle barcode
        // values only when widget is visible
        child: VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: const Key("visible-detector-key"),
          child: BarcodeKeyboardListener(
            bufferDuration: const Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) {
              if (!visible) return;
              // ignore: avoid_print
              print(barcode);
              setState(() {
                _barcode = barcode;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _barcode == null ? "SCAN BARCODE" : "BARCODE: $_barcode",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SecondScreen(),
                      ),
                    ),
                    child: const Center(child: Text("Second screen")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
