// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:ievent/view/Sobrenos.dart';
import 'package:ievent/view/widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'tela principal',
    home: TelaPrincipal(),
  ));
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final containerHeight =
        screenHeight * 0.7 - 120; // subtrai a altura da imagem do EzPrice

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 24, 117, 1),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0),
            ),
            child: Center(),
          ),
          Positioned(
            top: screenHeight * 0.1,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                'lib/images/logo.jpg',
                height: 120,
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 50),
              child: Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.4), width: 1.5)),
                  height: containerHeight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Widgets().widgetEmail(),
                        SizedBox(height: 10),
                        Widgets().widgetSenha(),
                        SizedBox(height: 2),
                        // Row(
                        //   children: [Widgets().widgetEsqueceSenha(context)],
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        // ),
                        SizedBox(height: 10),
                        Widgets().widgetEntrar(context),
                        SizedBox(height: 25),
                        Widgets().widgetEsqueceSenha(context),
                        SizedBox(height: 25),
                        Widgets().widgetNovoAqui(context)
                      ])),
            ),
          ])
        ],
      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text('gabriellima@gmail.com'),
                accountName: Text('Gabriel Lima'),
                decoration:
                    BoxDecoration(color: Color.fromRGBO(51, 24, 117, 1)),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Color.fromRGBO(51, 24, 117, 0.7),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Sobre nós'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Sobrenos()));
                  })
            ],
          ),
      ),
    );
  }
}
