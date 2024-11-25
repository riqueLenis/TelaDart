//a tela de perfil vai exibir as informacoes do usuario e vai perimitir atualizar as mesmas

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    _nomeController.text = user.displayName ?? "";
    _emailController.text = user.email ?? "";
  }

  void _atualizarPerfil() async {
    final user = FirebaseAuth.instance.currentUser!;
    try {
      await user.updateDisplayName(_nomeController.text.trim());
      await user.reload();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar perfil: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
              readOnly: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _atualizarPerfil,
              child: Text('Atualizar Perfil'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
