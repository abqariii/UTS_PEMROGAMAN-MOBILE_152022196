import 'package:flutter/material.dart';

class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final _temperatureController = TextEditingController();
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double _result = 0;

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _convertTemperature() {
    double input = double.parse(_temperatureController.text);
    double result = 0;

    // Convert to Celsius first
    double celsius;
    if (_fromUnit == 'Celsius') {
      celsius = input;
    } else if (_fromUnit == 'Fahrenheit') {
      celsius = (input - 32) * 5 / 9;
    } else { // Kelvin
      celsius = input - 273.15;
    }

    // Convert from Celsius to target unit
    if (_toUnit == 'Celsius') {
      result = celsius;
    } else if (_toUnit == 'Fahrenheit') {
      result = (celsius * 9 / 5) + 32;
    } else { // Kelvin
      result = celsius + 273.15;
    }

    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
        backgroundColor: Colors.blue.shade800,
        elevation: 10,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Temperature input field
              TextField(
                controller: _temperatureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter Temperature',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.thermostat, color: Colors.blue),
                ),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),

              // Units Dropdown
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _fromUnit,
                      decoration: InputDecoration(
                        labelText: 'From',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: _units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromUnit = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _toUnit,
                      decoration: InputDecoration(
                        labelText: 'To',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      items: _units.map((unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _toUnit = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Convert Button
              ElevatedButton(
                onPressed: _convertTemperature,
                child: Text('Convert'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800, // Set background color
                  foregroundColor: Colors.white, // Set text color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Display result if it's calculated
              _result != 0
                  ? Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Result:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              '${_result.toStringAsFixed(2)} $_toUnit',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
