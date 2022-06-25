// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// String randomNumber() {
//   var random = Random();
//   String num = random.nextInt(10).toString();
//   print(num);
//   return num;
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final textFieldController = TextEditingController();
//   String _textResult = "Guess the number";
//   String _answer = randomNumber();
//   int _counter = 0;

//   void _incrementCounter() {
//     // increment number when press button
//     setState(() {
//       _counter++;
//     });
//   }

//   void _guessNumber() {
//     //  guess number when press button
//     setState(() {
//       if (_answer == textFieldController.text) {
//         _textResult = "Correct Answer !";
//       } else {
//         _textResult = "Wrong ! the answer is " + _answer;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),

//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             TextField(
//               controller: textFieldController,
//             ),
//             Text(
//               _textResult,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),

//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _incrementCounter,
//       //   tooltip: 'Increment',
//       //   child: const Icon(Icons.add),
//       // ), // This trailing comma makes auto-formatting nicer for build methods.
//       floatingActionButton: FloatingActionButton(
//         onPressed: _guessNumber,
//         child: const Icon(Icons.add),
//       ), // T
//     );
//   }
// }
