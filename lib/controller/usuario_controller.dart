import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ievent/model/usuario.dart';

import '../view/util.dart';

class UsuarioController{
    void alterar(context, Usuario l) {
    FirebaseFirestore.instance
        .collection('usuario')
        .add(l.toJson())
        .then((value) => sucesso(context, 'Não foi possivel alterar o nome'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'))
        .whenComplete(() => Navigator.of(context).pop());
  }

}
