class EventosSalvos {
  final String uid;
  final String titulo;
  final String texto;

  EventosSalvos(this.uid, this.titulo, this.texto);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'titulo': titulo,
      'texto': texto,
    };
  }

  factory EventosSalvos.fromJson(Map<String, dynamic> json) {
    return EventosSalvos(json['uid'], json['titulo'], json['texto']);
  }
}
