import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/util.dart';

class LoginController {
  criarConta(context, nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then((resultado) {
      //Conta Criada com Sucesso
      FirebaseFirestore.instance.collection('usuarios').add({
        'uid': resultado.user!.uid,
        'nome': nome,
      });

      sucesso(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
    }).catchError((e) {
      //Não foi possível criar a conta
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }
  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      sucesso(context, 'Usuário autenticado com sucesso.');
      Navigator.pushNamed(context, 'principal');
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }
  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      sucesso(context, 'Email enviado com sucesso.');
    } else {
      erro(context, 'Informe o email para recuperar a conta.');
    }
    Navigator.pop(context);
  }
  logout() {
    FirebaseAuth.instance.signOut();
  }
  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
  Future<String> usuarioLogado() async {
    var usuario = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario())
        .get()
        .then(
      (resultado) {
        usuario = resultado.docs[0].data()['nome'] ?? '';
      },
    );
    return usuario;
  }

  Future<String> atualizarNomeUsuario(BuildContext context, novoNome) async {
    var nomeNovo = novoNome;
    var userId = await idUsuario();

  FirebaseFirestore.instance
      .collection('usuarios')
      .doc(idUsuario())
      .set({'nome': novoNome}, SetOptions(merge: true))
      .then((result) {
    sucesso(context, 'Nome do usuário atualizado com sucesso.');
  }).catchError((e) {
    erro(context, 'Erro na atualização: ${e.toString()}');
  });

  return nomeNovo;
}  
}
