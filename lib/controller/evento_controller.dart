import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/tarefa.dart';
import '../view/util.dart';
import 'login_controller.dart';

class EventoController {
  void adicionar(context, Tarefa t) {
    FirebaseFirestore.instance
        .collection('eventos')
        .add(t.toJson())
        .then((value) => sucesso(context, 'Evento adicionada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, Tarefa t) {
    FirebaseFirestore.instance
        .collection('eventos')
        .doc(id)
        .update(t.toJson())
        .then((value) => sucesso(context, 'Evento atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
      .collection('tarefas')
      .doc(id)
      .delete()
      .then((value) => sucesso(context, 'Evento excluído com sucesso'))
      .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
      .whenComplete(() => Navigator.of(context).pop());    
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('tarefas')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
