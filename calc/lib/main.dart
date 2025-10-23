import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  // Variável que armazena o texto exibido no visor
  String _displayText = "0";

  // Função chamada quando qualquer botão é pressionado
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Limpa o visor
        _displayText = "0";
      } else if (buttonText == "=") {
        // Calcula o resultado
        try {
          // A biblioteca math_expressions faz a mágica aqui
          Parser p = Parser();
          Expression exp = p.parse(_displayText);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          // Formata o resultado para remover ".0" se for um inteiro
          _displayText = eval.toString();
          if (_displayText.endsWith(".0")) {
            _displayText = _displayText.substring(0, _displayText.length - 2);
          }
        } catch (e) {
          // Se a expressão for inválida (ex: "5++3"), mostra "Erro"
          _displayText = "Erro";
        }
      } else {
        // Concatena o texto do botão ao visor
        if (_displayText == "0" && buttonText != ".") {
          _displayText = buttonText;
        } else if (_displayText == "Erro") {
          _displayText = buttonText;
        } else {
          _displayText = _displayText + buttonText;
        }
      }
    });
  }

  // Função auxiliar para construir os botões
  Widget buildButton(String buttonText, {Color? color, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              color: (color == null || color == Colors.grey[300])
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora Flutter")),
      body: Column(
        children: <Widget>[
          // --- VISOR DA CALCULADORA ---
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _displayText,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const Divider(height: 1.0),

          // --- TECLADO DA CALCULADORA ---
          Column(
            children: [
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("*", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("C", color: Colors.redAccent),
                  buildButton("0"),
                  buildButton("."),
                  buildButton("+", color: Colors.orange),
                ],
              ),
              Row(
                children: [
                  // O botão de igual ocupa a largura inteira (flex: 4)
                  buildButton("=", color: Colors.green, flex: 4),
                ],
              ),
              const SizedBox(height: 10), // Um pequeno espaço na parte inferior
            ],
          ),
        ],
      ),
    );
  }
}
