import 'package:flutter/material.dart';

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

class PerfilUsuarioScreen extends StatelessWidget {
  final PerfilUsuario perfilUsuario;

  const PerfilUsuarioScreen({required this.perfilUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(perfilUsuario.fotoPerfilUrl),
            ),
            SizedBox(height: 16),
            Text('Nome: ${perfilUsuario.nome}'),
            Text('E-mail: ${perfilUsuario.email}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação do botão de sair
                // Realizar o logout do usuário e voltar para a tela de login
                Navigator.pushReplacementNamed(context, 'login');
              },
              child: Text('Sair da conta'),
            ),
          ],
        ),
      ),
    );
  }
}
