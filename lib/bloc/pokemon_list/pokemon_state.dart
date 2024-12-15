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
  final List<PokemonListData> listGroupPokemon;
  final List<int> counts;

  PokemonLoaded({
    required this.pokemons,
    required this.listGroupPokemon,
    required this.counts,
  });
  PokemonLoaded copyWith({List<PokemonListData>? pokemons, List<int>? counts,List<PokemonListData>? listGroupPokemon}) {
    return PokemonLoaded(
      pokemons: pokemons ?? this.pokemons,
      listGroupPokemon: listGroupPokemon ?? this.listGroupPokemon,
      counts: counts ?? this.counts,
    );
  }

  @override
  List<Object?> get props => [pokemons,counts,listGroupPokemon];
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError({required this.message});

  @override
  List<Object?> get props => [message];
}


