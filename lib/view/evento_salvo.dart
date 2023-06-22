import 'package:flutter/material.dart';
import 'maps.dart';

class EventosSalvosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Eventos Salvos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          // Conteúdo da tela de eventos salvos
        ],
      ),
      bottomNavigationBar: _buildCollapsedNavigationBar(context),
    );
  }

  Widget _buildCollapsedNavigationBar(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventosSalvosScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaMapa()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              // Ação para favoritos
            },
          ),
          IconButton(
            icon: Icon(Icons.mail),
            color: Colors.white,
            onPressed: () {
              // Ação para mensagens
            },
          ),
        ],
      ),
    );
  }
}
