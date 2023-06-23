import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ievent/view/perfil.dart';
import '../controller/evento_controller.dart';
import '../controller/login_controller.dart';
import '../model/evento.dart';
import 'evento_salvo.dart';
import 'maps.dart';

enum TipoEvento { Publico, Privado }

class EventosView extends StatefulWidget {
  @override
  _EventosViewState createState() => _EventosViewState();
}

class _EventosViewState extends State<EventosView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;
  TipoEvento _tipoEventoSelecionado = TipoEvento.Publico;
  var txtNome = TextEditingController();
  var txtLocal = TextEditingController();
  var txtDescricao = TextEditingController();
  var txtVisibilidade = TextEditingController();

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
            Expanded(child: Text('Seus Eventos')),
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
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: ListTile(
                          leading: Icon(Icons.map_outlined),
                          title: Text(item['nome']),
                          subtitle: Text(item['visibilidade']),
                          onTap: () {
                            txtNome.text = item['nome'];
                            txtDescricao.text = item['visibilidade'];
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  txtNome.text = item['nome'];
                                  txtLocal.text = item['local'];
                                  txtDescricao.text = item['descricao'];
                                  txtVisibilidade.text = item['visibilidade'];
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
          addEvent(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addEvent(context, {eventId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Cadastro de eventos'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: txtNome,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: txtLocal,
                    decoration: InputDecoration(
                      labelText: 'Local',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: txtDescricao,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: txtVisibilidade,
                    decoration: InputDecoration(
                      labelText: 'Visibilidade',
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          var event = Eventos(
                            LoginController().idUsuario(),
                            txtNome.text,
                            txtLocal.text,
                            txtDescricao.text,
                            txtVisibilidade.text,
                          );
                          txtNome.clear();
                          txtDescricao.clear();
                          txtLocal.clear();
                          txtVisibilidade.clear();
                          if (eventId == null) {
                            EventosController().adicionar(context, event);
                          } else {
                            EventosController()
                                .atualizar(context, eventId, event);
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text('Salvar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Fechar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
