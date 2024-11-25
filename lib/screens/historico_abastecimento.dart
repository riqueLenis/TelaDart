import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historico de Abastecimentos")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('abastecimentos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Nenhum abastecimento registrado."));
          }
          final abastecimentos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: abastecimentos.length,
            itemBuilder: (context, index) {
              final abastecimento = abastecimentos[index];
              return ListTile(
                title: Text("Litros: ${abastecimento['litros']}"),
                subtitle: Text(
                    "Quilometragem: ${abastecimento['km']} - Data: ${abastecimento['data']}"),
              );
            },
          );
        },
      ),
    );
  }
}
