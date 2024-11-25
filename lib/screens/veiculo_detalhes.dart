import 'package:controle_abastecimento/screens/registro_abast.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VeiculoDetalhesScreen extends StatelessWidget {
  final DocumentSnapshot veiculo;

  VeiculoDetalhesScreen({required this.veiculo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Veículo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${veiculo['nome']}", style: TextStyle(fontSize: 20)),
            Text("Modelo: ${veiculo['modelo']}"),
            Text("Ano: ${veiculo['ano']}"),
            Text("Placa: ${veiculo['placa']}"),
            SizedBox(height: 20),
            Text("Histórico de Abastecimentos", style: TextStyle(fontSize: 18)),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('abastecimentos')
                    .where('veiculoId', isEqualTo: veiculo.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Text("Nenhum abastecimento registrado.");
                  }
                  final abastecimentos = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: abastecimentos.length,
                    itemBuilder: (context, index) {
                      final abastecimento = abastecimentos[index];
                      final mediaConsumo = (abastecimento['kmAtual'] -
                              abastecimento['kmAnterior']) /
                          abastecimento['litros'];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text("Data: ${abastecimento['data']}"),
                          subtitle: Text(
                              "Litros: ${abastecimento['litros']} - Média: ${mediaConsumo.toStringAsFixed(2)} km/l"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                RegistrarAbastecimentoScreen(veiculoId: veiculo.id),
          ));
        },
      ),
    );
  }
}
