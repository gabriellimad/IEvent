import 'package:flutter/material.dart';
import 'package:ievent/view/perfil.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'iEvent',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PerfilUsuarioScreen(perfilUsuario: PerfilUsuario(nome: 'Nome', email: 'email@example.com', fotoPerfilUrl: 'URL da Foto'))),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              text: 'Publico',
            ),
            Tab(
              text: 'Privado',
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: TabBarView(
        controller: _tabController,
        children: [
          // Conteúdo da aba "Para você"
          ListView(
          ),
          // Conteúdo da aba "Seguindo"
          ListView(
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[900],
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.transparent,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.notifications),
            ),
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.heart_broken),
            ),
            Tab(
              icon: Icon(Icons.mail),
            ),
          ],
        ),
      ),
    );
  }
}
