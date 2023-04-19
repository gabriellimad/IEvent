// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ievent/view/widgets.dart';

import '../main.dart';

class EsqueceSenha extends StatelessWidget {
  const EsqueceSenha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Center(
                    child: Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        color: Colors.black,
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
                          Widgets().widgetNovaSenha(),
                          SizedBox(height: 10),
                          Widgets().widgetConfirmaSenha(),
                          SizedBox(height: 10),
                          Widgets().widgetEntrar(context)
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
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
