import 'package:flutter/material.dart';
import 'package:ievent/view/eventos_view.dart';
import 'package:ievent/view/perfil.dart';

import '../controller/evento_salvo_controller.dart';
import '../controller/login_controller.dart';
import '../model/evento_salvo.dart';
import 'evento_salvo.dart';
import 'maps.dart';

class TelaPrincipalView extends StatefulWidget {
  @override
  _TelaPrincipalViewState createState() => _TelaPrincipalViewState();
}

class _TelaPrincipalViewState extends State<TelaPrincipalView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;
  var txtNome = TextEditingController();
  var txtLocal = TextEditingController();
  var txtDescricao = TextEditingController();

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

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('iEvent'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilUsuarioScreen(
                    perfilUsuario: PerfilUsuario(
                      nome: 'Nome',
                      email: 'email@example.com',
                      fotoPerfilUrl: 'URL da Foto',
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Eventos'),
            Tab(text: 'Seguindo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSeguindoTab(),
          _buildParaVoceTab(),
        ],
      ),
      bottomNavigationBar: _buildCollapsedNavigationBar(),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildSeguindoTab() {
    return ListView(
      children: [
        _buildPublicacao(
          nome: 'Rodeio',
          texto:
              'Evento country, montaria, ambiente descontraído, Animação, cultura e música country.',
          local: "Arena do café",
          likes: 600,
          comentarios: 325,
          onSave: () {
            var e = EventosSalvos(LoginController().idUsuario(), 'Rodeio',
                'Evento country, montaria, ambiente descontraído, Animação, cultura e música country.');
            EventosSalvosController().adicionar(context, e);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventosSalvosView()),
            );
          },
        ),
        _buildPublicacao(
          nome: 'Festa São João',
          texto: 'Evento cultural, músicas e comidas típicas!',
          local: "Av Peraboles",
          likes: 254,
          comentarios: 48,
          onSave: () {
            var e = EventosSalvos(
                LoginController().idUsuario(),
                'Festa São João',
                'Evento cultural, músicas e comidas típicas!');
            EventosSalvosController().adicionar(context, e);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventosSalvosView()),
            );
          },
        ),
        _buildPublicacao(
          nome: 'Festa de crianças',
          texto: 'Evento lúdico, músicas e comidas típicas!',
          local: "Av Luzitana",
          likes: 254,
          comentarios: 48,
          onSave: () {
            var e = EventosSalvos(
                LoginController().idUsuario(),
                'Festa de crianças',
                'Evento lúdico, músicas e comidas típicas!');
            EventosSalvosController().adicionar(context, e);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventosSalvosView()),
            );
          },
        ),
        _buildPublicacao(
          nome: 'Festa do Arraia',
          texto: 'Evento junino para toda a família',
          local: "Jd Marchesi",
          likes: 254,
          comentarios: 48,
          onSave: () {
            var e = EventosSalvos(LoginController().idUsuario(),
                'Festa do Arraia', 'Evento junino para toda a família');
            EventosSalvosController().adicionar(context, e);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventosSalvosView()),
            );
          },
        ),
        _buildPublicacao(
          nome: 'Festa do boi morto',
          texto: 'Evento cultural, músicas e comidas típicas!',
          local: "Av Peraboles",
          likes: 254,
          comentarios: 48,
          onSave: () {
            var e = EventosSalvos(
                LoginController().idUsuario(),
                'Festa do boi morto',
                'Evento cultural, músicas e comidas típicas!');
            EventosSalvosController().adicionar(context, e);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventosSalvosView()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildParaVoceTab() {
    return ListView(
      children: [],
    );
  }

  Widget _buildPublicacao({
    required String nome,
    required String local,
    required String texto,
    required int likes,
    required int comentarios,
    required VoidCallback onSave,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            texto,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: onSave,
              ),
              SizedBox(width: 4),
              Text('$likes', style: TextStyle(color: Colors.black)),
              SizedBox(width: 16),
              Icon(Icons.comment, color: Colors.blue),
              SizedBox(width: 4),
              Text('$comentarios', style: TextStyle(color: Colors.black)),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.save, color: Color.fromARGB(255, 0, 56, 22)),
                onPressed: onSave,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedNavigationBar() {
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
                MaterialPageRoute(builder: (context) => EventosSalvosView()),
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
            icon: Icon(Icons.heart_broken_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaMapa()),
              );
            },
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Criar publicação'),
                  value: 'criar_publicacao',
                ),
                PopupMenuItem(
                  child: Text('Criar evento'),
                  value: 'criar_evento',
                ),
                PopupMenuItem(
                  child: Text('Eventos mais populares'),
                  value: 'eventos_populares',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'criar_publicacao') {
              } else if (value == 'criar_evento') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventosView()),
                );
              } else if (value == 'eventos_populares') {}
            },
          ),
        ],
      ),
    );
  }
}
