import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/evento_salvo.dart';
import '../view/util.dart';
import 'login_controller.dart';

class EventosSalvosController {
  void adicionar(context, EventosSalvos e) {
    FirebaseFirestore.instance
        .collection('eventoSalvo')
        .add(e.toJson())
        .then((value) => sucesso(context, 'Evento adicionado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, EventosSalvos e) {
    FirebaseFirestore.instance
        .collection('eventoSalvo')
        .doc(id)
        .update(e.toJson())
        .then((value) => sucesso(context, 'Evento atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('eventoSalvo')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Evento excluído com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('eventoSalvo')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
