class Evento {
  final String uid;
  final String titulo;
  final String local;
  final String descricao;

  Evento(this.uid, this.titulo, this.local, this.descricao);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'titulo': titulo,
      'local': local,
      'descricao': descricao
    };
  }

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
        json['uid'], json['titulo'], json['local'], json['descricao']);
  }
}
