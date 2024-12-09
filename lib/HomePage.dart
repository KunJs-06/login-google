import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_google/PokemonDetail.dart';
import 'package:login_google/bloc/Authentication/authentication_bloc.dart';
import 'package:login_google/bloc/pokemon_list/pokemon_bloc.dart';
import 'package:login_google/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonBloc _pokemonBloc = PokemonBloc();
  final ScrollController _scrollController = ScrollController();
  int offset = 0;
  final int limit = 10;

  @override
  void initState() {
    super.initState();
    _loadPokemonData();
    _scrollController.addListener(_onScroll);
  }

  void _loadPokemonData() {
    _pokemonBloc.add(FetchPokemonEvent(offset: offset, limit: limit));
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels == _scrollController.position.maxScrollExtent;
      if (isBottom) {
        offset += limit;
        _loadPokemonData();
      }
    }
  }

  @override
  void dispose() {
    _pokemonBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Pokémon',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_outlined,color: Colors.white),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                SignOutRequested(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        bloc: _pokemonBloc,
        builder: (context, state) {
          if (state is PokemonLoading && (state.pokemons == null || state.pokemons.isEmpty)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PokemonLoaded) {
           return Padding(
             padding: const EdgeInsets.all(5.0),
             child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: state.pokemons.length + 1, // +1 for loading indicator
                itemBuilder: (context, index) {
                  if (index < state.pokemons.length) {
                    final pokemon = state.pokemons[index];
                    return FutureBuilder(
                      future: getPokemonImage(pokemon.url),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final imageUrl = snapshot.data?.data_image;
                          print('imageUrl imageUrl:${imageUrl?.image}');
                          return GestureDetector(
                            onTap: (){
                            },
                            child: Card(
                              surfaceTintColor: Colors.red,
                              shadowColor:Colors.red,
                              elevation: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network('${imageUrl?.image}'),
                                  Text(pokemon.name),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Center(child: Text('No Image'));
                        }
                      },
                    );
                  }
                },
              ),
           );
          } else if (state is PokemonError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
