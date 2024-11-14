import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double _bmiResult = 0;
  String _bmiCategory = '';
  String _gender = 'Male'; // Default gender to Male

  void _calculateBMI() {
    double height = double.parse(_heightController.text) / 100; // Convert to meters
    double weight = double.parse(_weightController.text);

    // Calculate BMI
    double bmi = weight / (height * height);
    String category = '';

    // Modify BMI categorization based on gender
    if (_gender == 'Female') {
      // For women, we use slightly different BMI categories (optional)
      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 24) { // Adjusted upper bound for normal weight for women
        category = 'Normal';
      } else if (bmi >= 24 && bmi < 30) {
        category = 'Overweight';
      } else {
        category = 'Obese';
      }
    } else {
      // For men, we use the standard BMI categories
      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi >= 18.5 && bmi < 25) {
        category = 'Normal';
      } else if (bmi >= 25 && bmi < 30) {
        category = 'Overweight';
      } else {
        category = 'Obese';
      }
    }

    setState(() {
      _bmiResult = bmi;
      _bmiCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
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
              // Gender Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: Text(
                      'Male',
                      style: TextStyle(
                        color: _gender == 'Male' ? Colors.white : Colors.blue.shade800,
                      ),
                    ),
                    selected: _gender == 'Male',
                    onSelected: (bool selected) {
                      setState(() {
                        _gender = selected ? 'Male' : _gender;
                      });
                    },
                    selectedColor: Colors.blue.shade800,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(width: 10),
                  ChoiceChip(
                    label: Text(
                      'Female',
                      style: TextStyle(
                        color: _gender == 'Female' ? Colors.white : Colors.pink.shade800,
                      ),
                    ),
                    selected: _gender == 'Female',
                    onSelected: (bool selected) {
                      setState(() {
                        _gender = selected ? 'Female' : _gender;
                      });
                    },
                    selectedColor: Colors.pink.shade800,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ],
              ),
              SizedBox(height: 30),
              
              // Height input field
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.height, color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              
              // Weight input field
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.line_weight, color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              
              // Calculate button
              ElevatedButton(
                onPressed: _calculateBMI,
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white, // Set text color to white for better contrast
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Display BMI result if it's calculated
              _bmiResult > 0
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
                              'Your BMI:',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              _bmiResult.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            Text(
                              'Category: $_bmiCategory',
                              style: TextStyle(fontSize: 20),
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
