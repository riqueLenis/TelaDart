import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Usuário"),
            accountEmail: Text("email@exemplo.com"),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.car_repair),
            title: Text('Meus Veículos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar Veículo'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Histórico'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
