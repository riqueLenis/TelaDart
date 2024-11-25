import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrarAbastecimentoScreen extends StatefulWidget {
  final String veiculoId;

  RegistrarAbastecimentoScreen({required this.veiculoId});

  @override
  _RegistrarAbastecimentoScreenState createState() =>
      _RegistrarAbastecimentoScreenState();
}

class _RegistrarAbastecimentoScreenState
    extends State<RegistrarAbastecimentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _litrosController = TextEditingController();
  final _kmAtualController = TextEditingController();
  final _kmAnteriorController = TextEditingController();

  void _salvarAbastecimento() async {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('abastecimentos').add({
        'veiculoId': widget.veiculoId,
        'litros': double.parse(_litrosController.text.trim()),
        'kmAtual': int.parse(_kmAtualController.text.trim()),
        'kmAnterior': int.parse(_kmAnteriorController.text.trim()),
        'data': DateTime.now().toString(),
        'userId': userId,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Abastecimento registrado com sucesso!")),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar Abastecimento")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _kmAtualController,
                decoration: InputDecoration(labelText: 'Quilometragem Atual'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Informe a quilometragem atual" : null,
              ),
              TextFormField(
                controller: _kmAnteriorController,
                decoration: InputDecoration(labelText: 'Quilometragem Anterior'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Informe a quilometragem anterior" : null,
              ),
              TextFormField(
                controller: _litrosController,
                decoration: InputDecoration(labelText: 'Litros Abastecidos'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? "Informe a quantidade de litros" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarAbastecimento,
                child: Text("Salvar Abastecimento"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
