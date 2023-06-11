import 'package:flutter/material.dart';
import 'package:ievent/view/perfil.dart';
import '../controller/login_controller.dart';
import 'filtros.dart';

class PrincipalView extends StatelessWidget {
  const PrincipalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 103, 103, 255),
        title: Text('Eventos'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PerfilUsuarioScreen(
                    perfilUsuario: PerfilUsuario(
                      nome: '', // Insira o nome do usuário aqui
                      email: '', // Insira o email do usuário aqui
                      fotoPerfilUrl: '', // Insira a URL da foto de perfil do usuário aqui
                    ),
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  '', // Insira a URL da foto de perfil do usuário aqui
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Filtros()),
              );
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/mapa.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Criar evento"),
                content: SizedBox(
                  height: 250,
                  width: 300,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Evento',
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 15),
                      TextField(
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
                    child: Text("fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text("salvar"),
                    onPressed: () {
                      // Lógica para salvar o evento
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
