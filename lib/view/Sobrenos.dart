import 'package:flutter/material.dart';

import 'detalhes_autor.dart';

class Sobrenos extends StatelessWidget {
  const Sobrenos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                    color: Color.fromRGBO(255, 255, 255, 1),
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
                        backgroundImage:
                            AssetImage('lib/images/perfilgiovana.jpg'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Giovana',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 250, 250),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesAutor(
                          nome: 'Gabriel',
                          idade: 22,
                          email: 'Gabriel@gmail.com',
                          numero: '16987654321',
                          areaProfissional: 'Software',
                          faculdade: 'Fatec RP',
                          professor: 'Plotze',
                          imageUrl: 'lib/images/perfilgabriel.jpg',
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('lib/images/perfilgabriel.jpg'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Gabriel',
                        style: TextStyle(
                          color: Color.fromARGB(255, 241, 241, 241),
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
                      color: Color.fromARGB(255, 241, 241, 241),
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
