class Block {
  int? id;
  String? name;
  String? row;
  String? model;

  Block({
    this.id,
    this.name,
    this.row,
    this.model,
  }){
    id = id ?? 0;
    row = row ?? '';
    model = model ?? '';
  }

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'name':name,
      'row': row,
      'model':model,
    };
  }

  factory Block.fromMap(Map<String, dynamic> map){
    return Block(id: map['id'],name: map['name'], row: map['row'], model: map['model']);
  }

  @override
  List<Object?> get props => [
    id, name, row, model
  ];
}
