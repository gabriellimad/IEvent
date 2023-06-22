class Eventos {
  final String uid;
  final String nome;
  final String local;
  final String descricao;

  Eventos(this.uid, this.nome, this.local, this.descricao);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'local': local,
      'descricao': descricao
    };
  }

  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(
        json['uid'], json['nome'], json['local'], json['descricao']);
  }
}
