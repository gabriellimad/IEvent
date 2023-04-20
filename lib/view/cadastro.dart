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
  var txtNome = TextEditingController();
  var txtEndereco = TextEditingController();
  var txtData = TextEditingController();

  @override
  void initState() {
    index = -1;
    lista.add(Evento('Rodeio', '120,00'));
    lista.add(Evento('Teatro', '50,00'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Eventos')),
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
              controller: txtNome,
              decoration: InputDecoration(
                labelText: 'Nome do evento',
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
            
            SizedBox(height: 10),

                      TextField(
              controller: txtEndereco,
              decoration: InputDecoration(
                labelText: 'Endereço',
                labelStyle: TextStyle(fontSize: 18),
                prefixIcon: Icon(Icons.maps_home_work_rounded),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 25),

            //BOTÃO> ElevatedButton; OutlinedButton; TextButton
            ElevatedButton(
              //Evento
              onPressed: () {
                if (txtNome.text.isNotEmpty && txtEndereco.text.isNotEmpty) {
                  if (index == -1) {
                    //Adicionar um novo Evento
                    setState(() {
                      lista.add(
                        Evento(txtNome.text, txtEndereco.text),
                      );
                    });
                    mensagem('Evento adicionado com sucesso!');
                  } else {
                    //Atualizar um Evento existe
                    setState(() {
                      lista[index] = Evento(txtNome.text, txtEndereco.text);
                      index = -1;
                    });
                    mensagem('Evento atualizado com sucesso!');
                  }

                  txtNome.clear();
                  txtEndereco.clear();
                  txtData.clear();
                } else {
                  mensagem(
                    'Os campos do evento precisam ser preenchidos.',
                  );
                }
              },
              //Conteúdo
              child: Text('salvar'),
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
              title: Text(lista[index].Nome),
              subtitle: Text(lista[index].Preco),
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
                  txtNome.text = lista[index].Nome;
                  txtEndereco.text = lista[index].Preco;
                });
              },
              //Alterar a cor do ITEM selecionado
              tileColor: (this.index == index)
                  ? Color.fromARGB(255, 107, 188, 255)
                  : Colors.white,
              onLongPress: () {
                setState(() {
                  this.index = -1;
                  txtNome.clear();
                  txtEndereco.clear();
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
