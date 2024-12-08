import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_google/models/pokemon_model.dart';
import 'package:login_google/services/api.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial()) {
    on<FetchPokemonEvent>(_onFetchPokemon);
  }

  Future<void> _onFetchPokemon(FetchPokemonEvent event, Emitter<PokemonState> emit) async {
    if (state is PokemonLoading) return; // Prevent multiple simultaneous requests

    final currentState = state;
    List<PokemonListData> existingPokemons = [];
    if (currentState is PokemonLoaded) {
      existingPokemons = currentState.pokemons;
    }

    try {
      final pokemonDataList = await getPokemonDataList(event.offset, event.limit);
      final newPokemons = pokemonDataList.results!;
      emit(PokemonLoaded(pokemons: [...existingPokemons, ...newPokemons]));
    } catch (e) {
      emit(PokemonError(message: e.toString()));
    }
  }
}