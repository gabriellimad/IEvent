class Eventos {
  final String uid;
  final String nome;
  final String local;
  final String descricao;
  final String visibilidade;

  Eventos(this.uid, this.nome, this.local, this.descricao, this.visibilidade);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'local': local,
      'descricao': descricao,
      'visibilidade': visibilidade
    };
  }

  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(json['uid'], json['nome'], json['local'], json['descricao'],
        json['visibilidade']);
  }
}
