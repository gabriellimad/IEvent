import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ievent/model/evento.dart';
import 'package:ievent/view/perfil.dart';

import '../controller/empresa_controller.dart';
import '../controller/login_controller.dart';
import 'maps.dart';

class EmpresaView extends StatefulWidget {
  const EmpresaView({Key? key}) : super(key: key);

  @override
  State<EmpresaView> createState() => _EmpresaViewState();
}

class _EmpresaViewState extends State<EmpresaView> {
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
            Expanded(child: Text('Eventos Privados')),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: EmpresaController().listar().snapshots(),
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
                final dados = snapshot.requireData;
                if (dados.size > 0) {
                  return ListView.builder(
                    itemCount: dados.size,
                    itemBuilder: (context, index) {
                      String id = dados.docs[index].id;
                      dynamic item = dados.docs[index].data();
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.map_outlined),
                          title: Text(item['titulo']),
                          subtitle: Text(item['descricao']),
                          onTap: () {
                            txtTitulo.text = item['titulo'];
                            txtDescricao.text = item['descricao'];
                            salvarEvento(context, docId: id);
                          },
                          onLongPress: () {
                            EmpresaController().excluir(context, id);
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          salvarEvento(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void salvarEvento(context, {docId}) {
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
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: txtLocal,
                  decoration: InputDecoration(
                    labelText: 'Local',
                    prefixIcon: Icon(Icons.description),
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
              child: Text("Fechar"),
              onPressed: () {
                txtTitulo.clear();
                txtDescricao.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Salvar"),
              onPressed: () {
                var t = Evento(
                  LoginController().idUsuario(),
                  txtTitulo.text,
                  txtLocal.text,
                  txtDescricao.text,
                );
                txtTitulo.clear();
                txtDescricao.clear();
                if (docId == null) {
                  // EmpresaController().adicionar(context, t);
                } else {
                  // EmpresaController().atualizar(context, docId, t);
                }
              },
            ),
          ],
        );
      },
    );
  }
}