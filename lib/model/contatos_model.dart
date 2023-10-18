import 'dart:convert';

class ContatoModel {
  String? id;
  String nome;
  String telefone;
  String foto;

  ContatoModel({
    required this.nome,
    required this.telefone,
    required this.foto,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'telefone': telefone,
      'foto': foto,
      if (id != null) 'objectId': id
    };
  }

  factory ContatoModel.fromMap(Map<String, dynamic> map) {
    return ContatoModel(
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      foto: map['foto'] as String,
      id: map['objectId'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContatoModel.fromJson(String source) =>
      ContatoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}