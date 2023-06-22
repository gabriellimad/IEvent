import 'package:flutter/material.dart';
import 'package:ievent/view/perfil.dart';
import '../controller/evento_publico_controller.dart';
import '../controller/login_controller.dart';
import 'evento_salvo.dart';
import 'maps.dart';

enum TipoEvento { Publico, Privado }

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;
  TipoEvento _tipoEventoSelecionado = TipoEvento.Publico;

  List<String> nomesUsuarios = ['@maria', '@leticia', '@gabriel', '@giovana', '@marcia'];

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

  void _onTipoEventoChanged(TipoEvento? value) {
    if (value != null) {
      setState(() {
        _tipoEventoSelecionado = value;
      });
    }
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
      backgroundColor: Colors.black,
      body: TabBarView(
        controller: _tabController,
        children: [
          // Conteúdo da aba "Eventos"
          ListView(),
          // Conteúdo da aba "Seguindo"
          ListView.builder(
            itemCount: nomesUsuarios.length, // Número de publicações
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(197, 255, 255, 255),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Cabeçalho da publicação
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('lib/images/iconperfil.jpg'),
                            radius: 24,
                          ),
                          SizedBox(width: 16),
                          Text(
                            '${nomesUsuarios[index]}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    // Opção de curtida
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              // Ação de curtir a publicação
                            },
                          ),
                          SizedBox(width: 8),
                          Text(
                            '0 Curtidas',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleExpand();
        },
        child: Icon(_isExpanded ? Icons.close : Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _isExpanded
          ? _buildExpandedNavigationBar()
          : _buildCollapsedNavigationBar(),
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

  Widget _buildExpandedNavigationBar() {
    return Container(
      color: Colors.grey[900],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              _toggleExpand();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Ação para adicionar evento
            },
            child: Container(
              color: Colors.grey[900],
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Criar Evento',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Ação para "Populares"
            },
            child: Container(
              color: Colors.grey[900],
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Eventos mais populares do momento',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
