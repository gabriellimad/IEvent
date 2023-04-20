// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class Sobrenos extends StatelessWidget {
  const Sobrenos({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    ' \t\t Este App está sendo desenvolvido na matéria de dispositivos móveis em Flutter, na FATEC-RP! \n\t\t ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Color.fromRGBO(13, 12, 12, 0.9),
                onPressed: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}