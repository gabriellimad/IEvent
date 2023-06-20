import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/evento_privado.dart';
import '../view/util.dart';
import 'login_controller.dart';

class EventoPrivadoController {
  void adicionar(context, EventoPrivado e) {
    FirebaseFirestore.instance
        .collection('eventosPri')
        .add(e.toJson())
        .then((value) => sucesso(context, 'Evento adicionado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, EventoPrivado e) {
    FirebaseFirestore.instance
        .collection('eventosPri')
        .doc(id)
        .update(e.toJson())
        .then((value) => sucesso(context, 'Evento atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('eventosPri')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Evento excluído com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('eventosPri')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
