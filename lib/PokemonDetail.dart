import 'package:flutter/material.dart';
import '../models/pokemon_model.dart';

class PokemonDetail extends StatelessWidget {
  final List pokemon;

  const PokemonDetail({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Center(
        //       child: Image.network(
        //         pokemon.url,
        //         height: 200,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     const SizedBox(height: 16),
        //     Text(
        //       'Name: ${pokemon.name}',
        //       style: const TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //     // const SizedBox(height: 8),
        //     // Text(
        //     //   'ID: ${pokemon.id}',
        //     //   style: const TextStyle(fontSize: 16),
        //     // ),
        //     // const SizedBox(height: 8),
        //     // Text(
        //     //   'Height: ${pokemon.height}',
        //     //   style: const TextStyle(fontSize: 16),
        //     // ),
        //     // const SizedBox(height: 8),
        //     // Text(
        //     //   'Weight: ${pokemon.weight}',
        //     //   style: const TextStyle(fontSize: 16),
        //     // ),
        //     // const SizedBox(height: 16),
        //     // const Text(
        //     //   'Abilities:',
        //     //   style: TextStyle(
        //     //     fontSize: 18,
        //     //     fontWeight: FontWeight.bold,
        //     //   ),
        //     // ),
        //     // const SizedBox(height: 8),
        //     // Expanded(
        //     //   child: ListView.builder(
        //     //     itemCount: pokemon.abilities.length,
        //     //     itemBuilder: (context, index) {
        //     //       return Text('- ${pokemon.abilities[index]}');
        //     //     },
        //     //   ),
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
