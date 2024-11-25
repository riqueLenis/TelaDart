import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_abastecimento/screens/perfil.dart';
/*import 'package:controle_abastecimento/screens/veiculo_detalhes.dart';*/
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:controle_abastecimento/screens/login.dart';
import 'package:controle_abastecimento/screens/home.dart';
import 'package:controle_abastecimento/screens/add_veiculos.dart';
import 'package:controle_abastecimento/screens/historico_abastecimento.dart';
/*import 'package:controle_abastecimento/screens/perfil.dart';*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/adicionar_veiculo': (context) => AdicionarVeiculoScreen(),
        '/historico': (context) => HistoricoScreen(),
        '/perfil': (context) => PerfilScreen(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.veiculo,
  });

  final DocumentSnapshot<Object?> veiculo;

  @override
  Widget build(BuildContext context) {
    return NewWidget(veiculo: veiculo);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
