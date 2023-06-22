import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ievent/view/perfil.dart';
import '../controller/evento_publico_controller.dart';
import '../controller/login_controller.dart';
import '../model/evento_publico.dart';
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
  var txtNome = TextEditingController();
  var txtLocal = TextEditingController();
  var txtDescricao = TextEditingController();

  List<String> nomesUsuarios = [
    '@maria',
    '@leticia',
    '@gabriel',
    '@giovana',
    '@marcia'
  ];

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
        title: Row(
          children: [
            Expanded(child: Text('Eventos')),
            FutureBuilder<String>(
              future: LoginController().usuarioLogado(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PerfilUsuarioScreen(
                              perfilUsuario: PerfilUsuario(
                                nome: snapshot.data.toString(),
                                email: 'email@example.com',
                                fotoPerfilUrl: 'URL da Foto',
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.person, size: 14),
                      label: Text(''),
                    ),
                  );
                }
                return Text('');
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: EventosController().listar().snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Não foi possível estabelecer conexão.'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      return Card(
                        color: Color.fromARGB(255, 103, 103, 255),
                        child: ListTile(
                          leading: Icon(Icons.map_outlined),
                          title: Text(item['nome']),
                          subtitle: Text(item['descricao']),
                          onTap: () {
                            txtNome.text = item['nome'];
                            txtDescricao.text = item['descricao'];
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  txtNome.text = item['nome'];
                                  txtLocal.text = item['local'];
                                  txtDescricao.text = item['descricao'];
                                  addEvent(context, eventId: id);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  EventosController().excluir(context, id);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Não há eventos registrados.'),
                  );
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 103, 103, 255),
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
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    color: Color.fromARGB(255, 103, 103, 255),
                    onPressed: () {
                      addEvent(context);
                    },
                    icon: Icon(Icons.add_circle_outline),
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

  void addEvent(context, {eventId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Evento"),
          content: SizedBox(
            height: 250,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: txtNome,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: txtLocal,
                  decoration: InputDecoration(
                    labelText: 'Local',
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: txtDescricao,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          actions: [
            TextButton(
              child: Text(
                "Fechar",
                style: TextStyle(color: Color.fromARGB(255, 103, 103, 255)),
              ),
              onPressed: () {
                txtNome.clear();
                txtDescricao.clear();
                txtLocal.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 103, 103, 255),
              ),
              onPressed: () {
                var event = Eventos(LoginController().idUsuario(), txtNome.text,
                    txtLocal.text, txtDescricao.text);
                txtNome.clear();
                txtDescricao.clear();
                txtLocal.clear();
                if (eventId == null) {
                  EventosController().adicionar(context, event);
                } else {
                  EventosController().atualizar(context, eventId, event);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
