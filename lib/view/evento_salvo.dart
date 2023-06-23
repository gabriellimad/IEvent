import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ievent/view/perfil.dart';
import '../controller/evento_controller.dart';
import '../controller/evento_salvo_controller.dart';
import '../controller/login_controller.dart';
import '../model/evento.dart';
import 'criar_evento.dart';
import 'evento_salvo.dart';
import 'maps.dart';

enum TipoEvento { Publico, Privado }

class EventosSalvosView extends StatefulWidget {
  @override
  _EventosSalvosViewState createState() => _EventosSalvosViewState();
}

class _EventosSalvosViewState extends State<EventosSalvosView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExpanded = false;
  TipoEvento _tipoEventoSelecionado = TipoEvento.Publico;
  var txtTitulo = TextEditingController();
  var txtTexto = TextEditingController();

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
            Expanded(child: Text('Eventos Salvos')),
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
          stream: EventosSalvosController().listar().snapshots(),
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
                          title: Text(item['titulo']),
                          subtitle: Text(item['texto']),
                          onTap: () {
                            txtTitulo.text = item['titulo'];
                            txtTexto.text = item['texto'];
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  EventosSalvosController()
                                      .excluir(context, id);
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
    );
  }
}
