class EventoPrivado {
  final String uid;
  final String nome;
  final String local;
  final String descricao;

  EventoPrivado(this.uid, this.nome, this.local, this.descricao);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'local': local,
      'descricao': descricao
    };
  }

  factory EventoPrivado.fromJson(Map<String, dynamic> json) {
    return EventoPrivado(
        json['uid'], json['nome'], json['local'], json['descricao']);
  }
}
