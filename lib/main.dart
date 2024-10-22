import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {

  const BMICalculator({Key? key}) : super(key: key); 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BMICalculatorPage(),
    );
  }
}

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController _heightController = TextEditingController();
  double _bmi = 0;
  bool isMale = true;
  int weight = 70;
  int age = 23;

  void _calculateBMI() {
    double? height = double.tryParse(_heightController.text);

    if (height != null && height > 0) {
      setState(() {
        _bmi = weight / (height * height);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid height')),
      );
    }
  }

  String _getBMIResult() {
    if (_bmi < 18.5) {
      return '${_bmi.toStringAsFixed(1)}\nUnderweight';
    } else if (_bmi < 24.9) {
      return '${_bmi.toStringAsFixed(1)}\nNormal';
    } else if (_bmi < 29.9) {
      return '${_bmi.toStringAsFixed(1)}\nOverweight';
    } else {
      return '${_bmi.toStringAsFixed(1)}\nObese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Welcome 😊\nBMI Calculator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GenderButton(
                    label: 'Male',
                    icon: Icons.male,
                    isSelected: isMale,
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  GenderButton(
                    label: 'Female',
                    icon: Icons.female,
                    isSelected: !isMale,
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  WeightAgeCard(
                    label: 'Weight',
                    value: weight,
                    onDecrement: () {
                      setState(() {
                        if (weight > 1) weight--;
                      });
                    },
                    onIncrement: () {
                      setState(() {
                        weight++;
                      });
                    },
                  ),
                  WeightAgeCard(
                    label: 'Age',
                    value: age,
                    onDecrement: () {
                      setState(() {
                        if (age > 1) age--;
                      });
                    },
                    onIncrement: () {
                      setState(() {
                        age++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (m)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                _bmi == 0 ? 'Enter your details' : _getBMIResult(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateBMI,
                child: Text('Let\'s Go', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
 Widget build(BuildContext context) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue[100] : Colors.transparent, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, size: 50, color: isSelected ? Colors.blue : Colors.grey),
          SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.blue : Colors.grey)),
        ],
      ),
    ),
  );
 }
}

class WeightAgeCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const WeightAgeCard({
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
   return Container(
  height: 200.0, 
  decoration: BoxDecoration(
    color: Colors.white, 
    borderRadius: BorderRadius.circular(12.0), 
  ),
  padding: EdgeInsets.all(16.0), 
  child: Column(
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold, 
        ),
        textAlign: TextAlign.center, 
      ),
     Text(
                '$value',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold, 
                ),
              ),
      Expanded(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0), 
            ),
            child: IconButton(
              icon: Icon(Icons.remove, color: Colors.white), 
              onPressed: onDecrement,
              
            ),
          ),
          SizedBox(width: 20),
              Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0), 
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white), 
              onPressed: onIncrement,
              
            ),
          ),
            ],
          ),
        ),
      ),
    ],
  ),
);
  }
}