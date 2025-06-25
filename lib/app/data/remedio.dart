class Remedio {
  int? id;
  String nome;
  String descricao;
  int quantidade;
  DateTime? dataValidade;
  String? medida;

  Remedio({this.id, required this.nome, required this.descricao, required this.quantidade, this.dataValidade, this.medida});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'descricao': descricao,
      'quantidade': quantidade,
      'data_validade': dataValidade,
      'medida': medida ?? 'capsulas',
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory Remedio.fromMap(Map<String, dynamic> map) {
    return Remedio(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      quantidade: map['quantidade'],
      dataValidade: map['data_validade'] != null ? DateTime.parse(map['data_validade']) : null,
      medida: map['medida'] ?? 'unidade',
    );
  }
}
