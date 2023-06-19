class Empresa {
  final String id;
  final String nome;
  final String localizacao;
  final String descricao;

  Empresa(this.id, this.nome, this.localizacao, this.descricao);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'localizacao': localizacao,
      'descricao': descricao
    };
  }

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
        json['id'], json['nome'], json['localizacao'], json['descricao']);
  }
}
