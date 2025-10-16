import 'package:equatable/equatable.dart';

/// Entidade de domínio para Ability
class Ability extends Equatable {
  final String name;
  final String url;
  
  const Ability({
    required this.name,
    required this.url,
  });
  
  @override
  List<Object?> get props => [name, url];
  
  @override
  String toString() => 'Ability(name: $name, url: $url)';
}
