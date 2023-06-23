class Eventos {
  final String uid;
  final String titulo;
  final String texto;

  Eventos(this.uid, this.titulo, this.texto);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'titulo': titulo,
      'local': texto,
    };
  }

  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(json['uid'], json['titulo'], json['texto']);
  }
}
