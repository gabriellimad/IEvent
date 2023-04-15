// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ievent/view/widgets.dart';

import '../main.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/gradMorpheu.png'),
                    fit: BoxFit.cover)),
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: const Center(
                    child: Text(
                      'Cadastro',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.9),
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Form(
                        key: formKey,
                        child: Column(children: [
                          Widgets().widgetNomeReceita(),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Widgets().widgetMateriais(),
                              Widgets().widgetPrecoCadastro(),
                              Widgets().widgetQuantidade()
                            ],
                          )
                        ])),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Color.fromRGBO(13, 12, 12, 0.9),
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => TelaPrincipal()));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(0, 0, 0, 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
