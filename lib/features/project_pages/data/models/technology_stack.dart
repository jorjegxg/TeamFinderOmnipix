import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'technology_stack.g.dart';

@HiveType(typeId: 2)
class TechnologyStack extends Equatable {
  @HiveField(0)
  String id;
  @HiveField(1)
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
