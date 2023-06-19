import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/evento_publico.dart';
import '../view/util.dart';
import 'login_controller.dart';

class EventoPublicoController {
  void adicionar(context, EventoPublico e) {
    FirebaseFirestore.instance
        .collection('eventosPub')
        .add(e.toJson())
        .then((value) => sucesso(context, 'Evento adicionado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, EventoPublico e) {
    FirebaseFirestore.instance
        .collection('eventosPub')
        .doc(id)
        .update(e.toJson())
        .then((value) => sucesso(context, 'Evento atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('eventosPub')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Evento excluído com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('eventosPub')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
