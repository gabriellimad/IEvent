import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/login_controller.dart';
import 'login_view.dart';
import 'maps.dart';

class PerfilUsuario {
  final String nome;
  final String email;
  final String fotoPerfilUrl;

  PerfilUsuario({
    required this.nome,
    required this.email,
    required this.fotoPerfilUrl,
  });
}

class PerfilUsuarioScreen extends StatefulWidget {
  final PerfilUsuario perfilUsuario;

  const PerfilUsuarioScreen({required this.perfilUsuario});

  @override
  _PerfilUsuarioScreenState createState() => _PerfilUsuarioScreenState();
}

class _PerfilUsuarioScreenState extends State<PerfilUsuarioScreen> {
  late String nomeUsuario;

  @override
  void initState() {
    super.initState();
    nomeUsuario = widget.perfilUsuario.nome;
  }

  void atualizarNomeUsuario(String novoNome) {
    LoginController()
        .atualizarNomeUsuario(context, novoNome)
        .then((nomeAtualizado) {
      setState(() {
        nomeUsuario = nomeAtualizado;
      });
    }).catchError((e) {
      print('Erro ao atualizar o nome: $e');
    });
  }

  void deslogar() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Perfil do Usuário', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              exibirDialogEditarNome();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              deslogar();
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(widget.perfilUsuario.fotoPerfilUrl),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nomeUsuario,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Eventos visitados: 52',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildPublicationContainer(
            'Visitou Museu Dumont -em Dumont-SP',
            'Evento organizado para todos o públicos, em comemoração ao aniversário da cidade.',
          ),
          _buildPublicationContainer(
            'Título da publicação',
            'descrição',
          ),
          _buildPublicationContainer(
            'Título da publicação',
            'Descrição.',
          ),
        ],
      ),
      bottomNavigationBar: _buildCollapsedNavigationBar(),
    );
  }

  Widget _buildPublicationContainer(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(content),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.red),
              SizedBox(width: 8),
              Text('123 likes'),
              SizedBox(width: 16),
              Icon(Icons.date_range, color: Colors.blue),
              SizedBox(width: 8),
              Text('dd/mm/aa'),
            ],
          ),
        ],
      ),
    );
  }

  void exibirDialogEditarNome() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller =
            TextEditingController(text: nomeUsuario);

        return AlertDialog(
          title: Text('Editar Nome', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Novo nome',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          backgroundColor: Colors.black,
          actions: [
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                String novoNome = controller.text;
                atualizarNomeUsuario(novoNome);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        );
      },
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
            onPressed: () {},
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.mail),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
