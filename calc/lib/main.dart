import 'package:flutter/material.dart';

void main() => runApp(CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculadoraTela(),
    );
  }
}

class CalculadoraTela extends StatefulWidget {
  @override
  _CalculadoraTelaState createState() => _CalculadoraTelaState();
}

class _CalculadoraTelaState extends State<CalculadoraTela> {
  String _resultado = '';
  String _entrada = '';

  void _adicionarValor(String valor) {
    setState(() {
      _entrada += valor;
    });
  }

  void _limpar() {
    setState(() {
      _entrada = '';
      _resultado = '';
    });
  }

  void _calcular() {
    try {
      final expressao = _entrada.replaceAll('×', '*').replaceAll('÷', '/');
      final resultadoFinal = _avaliar(expressao);
      setState(() {
        _resultado = resultadoFinal.toString();
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro';
      });
    }
  }

  double _avaliar(String expressao) {
    // Avaliação simples usando a biblioteca 'math_expressions' seria ideal
    // Aqui está uma versão simplificada apenas para demonstração
    return double.parse(expressao); // substitua por parser real
  }

  Widget _botao(String texto, {Color cor = Colors.grey}) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: cor),
        onPressed: () {
          if (texto == 'C') {
            _limpar();
          } else if (texto == '=') {
            _calcular();
          } else {
            _adicionarValor(texto);
          }
        },
        child: Text(texto, style: TextStyle(fontSize: 24)),
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
              child: Text(_entrada, style: TextStyle(fontSize: 32)),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.all(24),
            child: Text(
              _resultado,
              style: TextStyle(
                fontSize: 24,
                color: const Color.fromARGB(255, 175, 246, 9),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _botao('7'),
                  _botao('8'),
                  _botao('9'),
                  _botao('÷', cor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _botao('4'),
                  _botao('5'),
                  _botao('6'),
                  _botao('×', cor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _botao('1'),
                  _botao('2'),
                  _botao('3'),
                  _botao('-', cor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _botao('0'),
                  _botao('.'),
                  _botao('C'),
                  _botao('+', cor: Colors.orange),
                ],
              ),
              Row(
                children: [
                  _botao('=', cor: const Color.fromARGB(255, 4, 255, 201)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
