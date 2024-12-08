part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {
  final List<PokemonListData> pokemons;

  PokemonLoading({required this.pokemons});

  @override
  List<Object?> get props => [pokemons];
}

class PokemonLoaded extends PokemonState {
  final List<PokemonListData> pokemons;

  PokemonLoaded({required this.pokemons});

  @override
  List<Object?> get props => [pokemons];
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError({required this.message});

  @override
  List<Object?> get props => [message];
}