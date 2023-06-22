import 'package:flutter/material.dart';

import 'eventos_view.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  TextEditingController _nomeController = EventosView().createState().txtNome;
  TextEditingController _localController = EventosView().createState().txtLocal;
  TextEditingController _descricaoController =
      EventosView().createState().txtDescricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _localController,
              decoration: InputDecoration(
                labelText: 'Local',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para salvar os dados
                    String nome = _nomeController.text;
                    String local = _localController.text;
                    String descricao = _descricaoController.text;

                    // Faça o que desejar com os dados (por exemplo, salvar no banco de dados)
                  },
                  child: Text('Salvar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fechar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
