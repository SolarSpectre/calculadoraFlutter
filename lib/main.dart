import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _numero1Controller = TextEditingController();
  final TextEditingController _numero2Controller = TextEditingController();
  double _resultado = 0;
  String _operacion = '';

  @override
  void dispose() {
    _numero1Controller.dispose();
    _numero2Controller.dispose();
    super.dispose();
  }

  void _calcular(String operacion) {
    setState(() {
      _operacion = operacion;
      double num1 = double.tryParse(_numero1Controller.text) ?? 0;
      double num2 = double.tryParse(_numero2Controller.text) ?? 0;
      
      switch (operacion) {
        case '+':
          _resultado = num1 + num2;
          break;
        case '-':
          _resultado = num1 - num2;
          break;
        case '*':
          _resultado = num1 * num2;
          break;
        case '/':
          if (num2 != 0) {
            _resultado = num1 / num2;
          } else {
            _resultado = double.infinity;
          }
          break;
      }
    });
  }

  void _limpiar() {
    setState(() {
      _numero1Controller.clear();
      _numero2Controller.clear();
      _resultado = 0;
      _operacion = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _calcular method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display del resultado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _operacion.isNotEmpty 
                        ? '${_numero1Controller.text} $_operacion ${_numero2Controller.text}'
                        : '0',
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _resultado == double.infinity 
                        ? 'Error: División por cero'
                        : _resultado.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Campos de entrada
            TextField(
              controller: _numero1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Primer número',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            
            const SizedBox(height: 16),
            
            TextField(
              controller: _numero2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Segundo número',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.numbers),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Botones de operaciones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOperationButton('+', Icons.add, Colors.green),
                _buildOperationButton('-', Icons.remove, Colors.red),
                _buildOperationButton('*', Icons.close, Colors.blue),
                _buildOperationButton('/', CupertinoIcons.divide, Colors.orange),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Botón limpiar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _limpiar,
                icon: const Icon(Icons.clear),
                label: const Text('Limpiar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOperationButton(String operacion, IconData icon, Color color) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        onPressed: () => _calcular(operacion),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Icon(icon, size: 30),
      ),
    );
  }
}
