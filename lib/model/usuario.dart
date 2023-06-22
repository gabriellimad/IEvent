class Usuario {
  final String uid;
  final String nome;
  final String tipo;

  Usuario(this.uid, this.nome, this.tipo);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'tipo': tipo,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        json['uid'], json['nome'], json['tipo']);
  }
}
