import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdicionarVeiculoScreen extends StatefulWidget {
  @override
  _AdicionarVeiculoScreenState createState() => _AdicionarVeiculoScreenState();
}

class _AdicionarVeiculoScreenState extends State<AdicionarVeiculoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _placaController = TextEditingController();

  void _salvarVeiculo() async {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('veiculos').add({
      'nome': _nomeController.text.trim(),
      'modelo': _modeloController.text.trim(),
      'ano': _anoController.text.trim(),
      'placa': _placaController.text.trim(),
      'userId': userId,
    });
    Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adicionar Veículo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Veículo'),
                validator: (value) =>
                    value!.isEmpty ? "O nome é obrigatório" : null,
              ),
              TextFormField(
                controller: _modeloController,
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) =>
                    value!.isEmpty ? "O modelo é obrigatório" : null,
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: 'Ano'),
                validator: (value) =>
                    value!.isEmpty ? "O ano é obrigatório" : null,
              ),
              TextFormField(
                controller: _placaController,
                decoration: InputDecoration(labelText: 'Placa'),
                validator: (value) =>
                    value!.isEmpty ? "A placa é obrigatória" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarVeiculo,
                child: Text("Salvar Veículo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
