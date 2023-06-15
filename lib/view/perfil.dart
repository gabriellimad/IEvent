import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controller/login_controller.dart';
import 'login_view.dart';

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
    LoginController().atualizarNomeUsuario(context, novoNome).then((nomeAtualizado) {
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
        backgroundColor: Color.fromARGB(255, 103, 103, 255),
        title: Text('Perfil do Usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              exibirDialogEditarNome();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              deslogar();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.perfilUsuario.fotoPerfilUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              nomeUsuario,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void exibirDialogEditarNome() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(text: nomeUsuario);

        return AlertDialog(
          title: Text('Editar Nome'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Novo Nome',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
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
            ),
          ],
        );
      },
    );
  }
}
