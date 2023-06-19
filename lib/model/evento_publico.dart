class EventoPublico {
  final String uid;
  final String nome;
  final String local;
  final String descricao;

  EventoPublico(this.uid, this.nome, this.local, this.descricao);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'local': local,
      'descricao': descricao
    };
  }

  factory EventoPublico.fromJson(Map<String, dynamic> json) {
    return EventoPublico(
        json['uid'], json['nome'], json['local'], json['descricao']);
  }
}
