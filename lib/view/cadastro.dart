// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../model/evento.dart';



//STATEFUL stf+TAB
class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Atributos
  List<Evento> lista = [];
  var index;
  var txtEndereco = TextEditingController();
  var txtData = TextEditingController();

  @override
  void initState() {
    index = -1;
    lista.add(Evento('Rua Marechal Deodoro', '18/04/2024'));
    lista.add(Evento('Rua Andrades da Silva', '18/05/2024'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Eventos'),
      backgroundColor: Color.fromRGBO(0, 0, 0, 1)
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: adicionar(),
          ),
          Expanded(
            flex: 2,
            child: listar(),
          ),
        ],
      ),
      //BARRA DE STATUS
      persistentFooterButtons: [
        Text('Total de Eventos: ${lista.length}'),
      ],
    );
  }

  //
  // ADICIONAR EventoS
  //
  adicionar() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            //CAMPO DE TEXTO
            TextField(
              controller: txtEndereco,
              decoration: InputDecoration(
                labelText: 'Endereco do evento',
                labelStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(Icons.local_activity),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            //CAMPO DE TEXTO
            TextField(
              controller: txtData,
              decoration: InputDecoration(
                labelText: 'Data',
                labelStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(Icons.event),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            //BOTÃO> ElevatedButton; OutlinedButton; TextButton
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              //Evento
              onPressed: () {
                if (txtEndereco.text.isNotEmpty && txtData.text.isNotEmpty) {
                  if (index == -1) {
                    //Adicionar um novo Evento
                    setState(() {
                      lista.add(
                        Evento(txtEndereco.text, txtData.text),
                      );
                    });
                    mensagem('Evento adicionado com sucesso!');
                  } else {
                    //Atualizar um Evento existe
                    setState(() {
                      lista[index] = Evento(txtEndereco.text, txtData.text);
                      index = -1;
                    });
                    mensagem('Evento atualizado com sucesso!');
                  }

                  txtEndereco.clear();
                  txtData.clear();
                } else {
                  mensagem(
                    'Os campos do evento precisam ser preenchidos.',
                  );
                }
              },
              //Conteúdo
              child: Text('Salvar', style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  // LISTAR EventoS
  //
  listar() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blueGrey.shade50,
      child: ListView.builder(
        //Definir a quantidade de elementos
        itemCount: lista.length,
        //Definir a aparência dos elementos
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.event),
              title: Text(lista[index].Endereco),
              subtitle: Text(lista[index].Data),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  //REMOVER
                  setState(() {
                    lista.removeAt(index);
                  });
                  mensagem('Evento removido com sucesso.');
                },
              ),
              //Selecionar um ITEM da lista
              onTap: () {
                setState(() {
                  //Armazenar a posição da lista
                  this.index = index;
                  txtEndereco.text = lista[index].Endereco;
                  txtData.text = lista[index].Data;
                });
              },
              //Alterar a cor do ITEM selecionado
              tileColor: (this.index == index)
                  ? Color.fromARGB(255, 107, 188, 255)
                  : Colors.white,
              onLongPress: () {
                setState(() {
                  this.index = -1;
                  txtEndereco.clear();
                  txtData.clear();
                });
              },
            ),
          );
        },
      ),
    );
  }

  //
  // EXIBIR MENSAGEM
  //
  mensagem(msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      content: Text(msg),
    ));
  }
}
