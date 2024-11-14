import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  double num1 = 0;
  String operand = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _input = "";
        num1 = 0;
        operand = "";
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "×" ||
          buttonText == "÷") {
        num1 = double.parse(_output);
        operand = buttonText;
        _input = _output + buttonText;
        _output = "0";
      } else if (buttonText == "=") {
        double num2 = double.parse(_output);
        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "×") {
          _output = (num1 * num2).toString();
        }
        if (operand == "÷") {
          _output = (num1 / num2).toString();
        }
        _input = "";
        operand = "";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
        _input = _input + buttonText;
      }
    });
  }

  // Membuat tombol dengan warna yang selaras dengan tema dan ukuran yang lebih kecil
  Widget buildButton(String buttonText, Color color, Color textColor) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8), // Menambahkan padding untuk memberi ruang antar tombol
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20), // Padding pada tombol
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Lebih halus
            ),
            elevation: 4, // Sedikit bayangan untuk memberi efek
            foregroundColor: textColor,
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24, // Ukuran font diturunkan
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blue.shade800, // Sesuaikan warna app bar dengan tema login
        elevation: 10,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white], // Sesuaikan dengan gradasi login
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            // Bagian Input dan Output
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.blue.shade800.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            // Grid untuk tombol-tombol kalkulator
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: EdgeInsets.all(16),
                children: [
                  buildButton("7", Colors.blue.shade200, Colors.white),
                  buildButton("8", Colors.blue.shade200, Colors.white),
                  buildButton("9", Colors.blue.shade200, Colors.white),
                  buildButton("÷", Colors.blue.shade400, Colors.white),

                  buildButton("4", Colors.blue.shade200, Colors.white),
                  buildButton("5", Colors.blue.shade200, Colors.white),
                  buildButton("6", Colors.blue.shade200, Colors.white),
                  buildButton("×", Colors.blue.shade400, Colors.white),

                  buildButton("1", Colors.blue.shade200, Colors.white),
                  buildButton("2", Colors.blue.shade200, Colors.white),
                  buildButton("3", Colors.blue.shade200, Colors.white),
                  buildButton("-", Colors.blue.shade400, Colors.white),

                  buildButton("C", Colors.red.shade400, Colors.white),
                  buildButton("0", Colors.blue.shade200, Colors.white),
                  buildButton("=", Colors.green.shade400, Colors.white),
                  buildButton("+", Colors.blue.shade400, Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
