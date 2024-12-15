import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_google/models/pokemon_model.dart';
import 'package:login_google/services/api.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial()) {
    on<FetchPokemonEvent>(_onFetchPokemon);
    on<IncreaseCountEvent>(_onIncreaseCountEvent);
    on<DecreaseCountEvent>(_onDecreaseCountEvent);

  }

  Future<void> _onFetchPokemon(FetchPokemonEvent event, Emitter<PokemonState> emit) async {
    if (state is PokemonLoading) return;
    final currentState = state;
    List<PokemonListData> existingPokemons = [];
    List<PokemonListData> listGroupPokemon = [];
    if (currentState is PokemonLoaded) {
      existingPokemons = currentState.pokemons;
    }

    try {
      final pokemonDataList = await getPokemonDataList(event.offset, event.limit);
      final newPokemons = pokemonDataList.results!;
      final currentCounts = (state is PokemonLoaded) ? (state as PokemonLoaded).counts : [];
      emit(PokemonLoaded(
        pokemons: [...existingPokemons, ...newPokemons],
        counts: [...currentCounts, ...List.filled(newPokemons.length, 0)],
        listGroupPokemon: listGroupPokemon = newPokemons,
      ));
    } catch (e) {
      emit(PokemonError(message: e.toString()));
    }
  }

  void _onIncreaseCountEvent(IncreaseCountEvent event, Emitter<PokemonState> emit,) {
    if (state is PokemonLoaded) {
      final currentState = state as PokemonLoaded;
      final updatedCounts = List<int>.from(currentState.counts);
      updatedCounts[event.index]++;
      emit(currentState.copyWith(counts: updatedCounts));
    }
  }

  void _onDecreaseCountEvent(DecreaseCountEvent event, Emitter<PokemonState> emit,) {
    if (state is PokemonLoaded) {
      final currentState = state as PokemonLoaded;
      final updatedCounts = List<int>.from(currentState.counts);
      if (updatedCounts[event.index] > 0) {
        updatedCounts[event.index]--;
        emit(currentState.copyWith(counts: updatedCounts));
      }
    }
  }
}