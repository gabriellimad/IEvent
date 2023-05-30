import 'package:flutter/material.dart';

import 'detalhes_autor.dart';

class Sobrenos extends StatelessWidget {
  const Sobrenos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/sobre.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Center(
                child: Text(
                  'Quem somos nós?',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesAutor(
                      nome: 'João',
                      idade: 25,
                      email: 'joao@example.com',
                      numero: '123456789',
                      areaProfissional: 'Desenvolvimento',
                      faculdade: 'FATEC',
                      professor: 'Professor X',
                      imageUrl: 'lib/images/foto_perfil.jpg',
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('lib/images/foto_perfil.jpg'),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    ' \t\t Este App está sendo desenvolvido na matéria de dispositivos móveis em Flutter, na FATEC-RP! \n Nosso aplicativo permite que você cadastre eventos e encontre facilmente eventos próximos a você. Com nossa plataforma, você terá acesso a uma lista de eventos\t\t ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
