import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Controle de Abastecimento")),
      drawer: CustomDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('veiculos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Nenhum veículo cadastrado."));
          }
          final veiculos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (context, index) {
              final veiculo = veiculos[index];
              return ListTile(
                title: Text(veiculo['nome']),
                subtitle: Text("${veiculo['modelo']} - ${veiculo['placa']}"),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('veiculos')
                        .doc(veiculo.id)
                        .delete();
                  },
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/veiculo_detalhes',
                    arguments: veiculo,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/adicionar_veiculo');
        },
      ),
    );
  }
}
