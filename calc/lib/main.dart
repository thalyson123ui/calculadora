import 'package:flutter/material.dart';
import '../controllers/calculator_controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = CalculatorController();

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          setState(() {
            if (text == 'C') {
              controller.clear();
            } else if (text == '=') {
              controller.calculate();
            } else {
              controller.addValue(text);
            }
          });
        },
        child: Text(text, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculadora')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                controller.expression,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(24),
            child: Text(
              controller.result,
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton('7'),
                  buildButton('8'),
                  buildButton('9'),
                  buildButton('÷', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('4'),
                  buildButton('5'),
                  buildButton('6'),
                  buildButton('×', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('1'),
                  buildButton('2'),
                  buildButton('3'),
                  buildButton('-', color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('0'),
                  buildButton('.'),
                  buildButton('C'),
                  buildButton('+', color: Colors.orange),
                ],
              ),
              Row(children: [buildButton('=', color: Colors.green)]),
            ],
          ),
        ],
      ),
    );
  }
}
