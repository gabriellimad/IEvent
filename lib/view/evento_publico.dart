import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ievent/model/evento.dart';
import 'package:ievent/view/perfil.dart';

import '../controller/evento_publico_controller.dart';
import '../controller/login_controller.dart';
import 'empresa.dart';
import 'maps.dart';

class EventoPublico extends StatefulWidget {
  const EventoPublico({Key? key}) : super(key: key);

  @override
  State<EventoPublico> createState() => _EventoPublicoState();
}

class _EventoPublicoState extends State<EventoPublico> {
  var txtTitulo = TextEditingController();
  var txtLocal = TextEditingController();
  var txtDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 103, 103, 255),
        title: Row(
          children: [
            Expanded(child: Text('Eventos Públicos')),
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
                                email: '',
                                fotoPerfilUrl: '',
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaMapa()),
                );
              },
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/mapa.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5), // Ajuste a opacidade aqui
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: EventoController().listar().snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text('Não foi possível conectar.'),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  final data = snapshot.requireData;
                  if (data.size > 0) {
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, indice) {
                        String id = data.docs[indice].id;
                        dynamic item = data.docs[indice].data();
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.map_outlined),
                            title: Text(item['titulo']),
                            subtitle: Text(item['descricao']),
                            onTap: () {
                              txtTitulo.text = item['titulo'];
                              txtLocal.text = item['local'];
                              txtDescricao.text = item['descricao'];
                              addEvent(context, docId: id);
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    addEvent(context);
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    EventoController().excluir(context, id);
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
                      child: Text('Nenhum evento encontrado.'),
                    );
                  }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEvent(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 103, 103, 255),
      ),
    );
  }

  void addEvent(context, {docId}) {
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
                  controller: txtTitulo,
                  decoration: InputDecoration(
                    labelText: 'Título',
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
                txtTitulo.clear();
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
                var event = Evento(
                  LoginController().idUsuario(),
                  txtTitulo.text,
                  txtLocal.text,
                  txtDescricao.text,
                );
                txtTitulo.clear();
                txtDescricao.clear();
                txtLocal.clear();
                if (docId == null) {
                  EventoController().adicionar(context, event);
                } else {
                  EventoController().atualizar(context, docId, event);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
