part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchPokemonEvent extends PokemonEvent {
  final int offset;
  final int limit;

  FetchPokemonEvent({required this.offset, required this.limit});
}

class IncreaseCountEvent extends PokemonEvent {
  final int index;

  IncreaseCountEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class DecreaseCountEvent extends PokemonEvent {
  final int index;

  DecreaseCountEvent(this.index);

  @override
  List<Object?> get props => [index];
}
