import 'package:flutter/material.dart';

class Evento {
  final String uid;
  final String titulo;
  final String descricao;
  final String local;

  Evento(this.uid, this.titulo, this.descricao, this.local);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'titulo': titulo,
      'descricao': descricao,
      'local': local,
    };
  }

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
      json['uid'],
      json['titulo'],
      json['descricao'],
      json['local']
    );
  }
}
