import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'IMC Calc',
    home: App()
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = 'Informe seus dados!';

  void _resetFields() {
    weightController.text = '';
    heightController.text = '';
    _formKey = GlobalKey<FormState>();
    _updateInfoTextState('Informe seus dados!');
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);

    if (imc < 18.6) {
      _updateInfoTextState('Abaixo do Peso (IMC: ${imc.toStringAsPrecision(3)})');
    } else if (imc >= 18.6 && imc < 24.9) {
      _updateInfoTextState('Peso Ideal (IMC: ${imc.toStringAsPrecision(3)})');
    } else if (imc >= 24.9 && imc < 29.9) {
      _updateInfoTextState('Levemente Acima do Peso (IMC: ${imc.toStringAsPrecision(3)})');
    } else if (imc >= 29.9 && imc < 34.9) {
      _updateInfoTextState('Obesidade Grau I (IMC: ${imc.toStringAsPrecision(3)})');
    } else if (imc >= 34.9 && imc < 39.9) {
      _updateInfoTextState('Obesidade Grau II (IMC: ${imc.toStringAsPrecision(3)})');
    } else if (imc >= 40) {
      _updateInfoTextState('Obesidade Grau III (IMC: ${imc.toStringAsPrecision(3)})');
    }
  }

  void _updateInfoTextState(String text) {
    setState(() {
      _infoText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calc'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 128, color: Colors.green),
              TextFormField(
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'O peso é obrigatório!';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              TextFormField(
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'A altura é obrigatória!';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text('Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25.0),)
            ],
          ),
        ),
      ),
    );
  }
}
