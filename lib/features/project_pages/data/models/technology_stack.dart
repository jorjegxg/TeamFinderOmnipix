import 'package:equatable/equatable.dart';

class TechnologyStack extends Equatable {
  String id;
  final String name;

  TechnologyStack({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'TechnologyStack(id: $id, name: $name)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TechnologyStack.fromMap(Map<String, dynamic> map) {
    return TechnologyStack(
      id: map['id'],
      name: map['name'],
    );
  }

  //toJSON and fromJSON methods with convert

  @override
  List<Object?> get props => [id, name];
}
