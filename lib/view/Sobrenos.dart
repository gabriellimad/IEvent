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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesAutor(
                          nome: 'Giovana Rozolin',
                          idade: 21,
                          email: 'giovanarozolin@gmail.com',
                          numero: '(16) 981878505',
                          areaProfissional: 'Dev estagiária',
                          faculdade: 'FATEC',
                          professor: 'Rodrigo Plotze',
                          imageUrl: 'lib/images/perfilgiovana.jpg',
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('lib/images/perfilgiovana.jpg'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Giovana',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Espaço entre os dois ícones
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesAutor(
                          nome: 'Maria',
                          idade: 30,
                          email: 'maria@example.com',
                          numero: '987654321',
                          areaProfissional: 'Design',
                          faculdade: 'Universidade XYZ',
                          professor: 'Professor Y',
                          imageUrl: 'lib/images/foto_perfil_2.jpg',
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('lib/images/foto_perfil_2.jpg'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gabriel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
