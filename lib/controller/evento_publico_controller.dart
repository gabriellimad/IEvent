import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/evento.dart';
import '../view/util.dart';
import 'login_controller.dart';

class EventoController {
  void adicionar(context, Evento e) {
    FirebaseFirestore.instance
        .collection('eventosPub')
        .add(e.toJson())
        .then((value) => sucesso(context, 'Evento adicionada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, Evento e) {
    FirebaseFirestore.instance
        .collection('eventosPub')
        .doc(id)
        .update(e.toJson())
        .then((value) => sucesso(context, 'Evento atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('eventosPub')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Evento excluído com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('eventosPub')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
