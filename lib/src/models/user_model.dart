class User{
  int id;
  String name;
  String email;
  String senha;
  int telefone;
  DateTime data; 
  bool responsavel;

  User(
    this.id,
    this.name,
    this.email,
    this.senha,
    this.telefone,
    this.data,
    this.responsavel,
  );


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'senha': senha,
      'telefone': telefone,
      'data': data,
      'responsavel': responsavel,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, senha: $senha, telefone: $telefone, data: $data, responsavel: $responsavel}';
  }

}
