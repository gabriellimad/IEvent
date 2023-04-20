// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ievent/view/widgets.dart';
import '../main.dart';

class CadastroUser extends StatelessWidget {
  const CadastroUser({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: Stack(children: [
      Container(
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
                  'Cadastro de Usuário',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 30),
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Form(
                      key: formKey,
                      child: Column(children: [
                        SizedBox(height: 3),
                        Widgets().widgetNomeUser(),
                        SizedBox(height: 3),
                        Widgets().widgetEmailUser(),
                        SizedBox(height: 3),
                        Widgets().widgetCPF(),
                        SizedBox(height: 3),
                        Widgets().widgetSenha(),
                        SizedBox(height: 3),
                        Widgets().widgetConfirmaSenha()
                      ]))),
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
      )
    ]));
  }
}