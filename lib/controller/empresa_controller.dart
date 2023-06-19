import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/empresa.dart';
import '../view/util.dart';
import 'login_controller.dart';

class EmpresaController {
  void adicionar(context, Empresa e) {
    FirebaseFirestore.instance
        .collection('empresas')
        .add(e.toJson())
        .then((value) => sucesso(context, 'Empresa adicionada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

  void atualizar(context, id, Empresa e) {
    FirebaseFirestore.instance
        .collection('empresas')
        .doc(id)
        .update(e.toJson())
        .then((value) => sucesso(context, 'Empresa atualizada com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  void excluir(context, id) {
    FirebaseFirestore.instance
        .collection('empresas')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'Empresa excluído com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  listar() {
    return FirebaseFirestore.instance
        .collection('empresas')
        .where('uid', isEqualTo: LoginController().idUsuario());
  }
}
