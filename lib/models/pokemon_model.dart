class PokemonListData {
  final String name;
  final String url;

  PokemonListData({
    required this.name,
    required this.url});

  factory PokemonListData.fromJson(Map<String, dynamic> json) {
    return PokemonListData(
      name: json['name'],
      url: json['url'],
    );
  }
}

/*------------------------------------------------------------------*/
class DataPokemon{
  final String id;
  final ImageDataPokemon? data_image;

  DataPokemon({
    required this.id,
    required this.data_image,
  });

  factory DataPokemon.fromJson(Map<String, dynamic> json) {
    ImageDataPokemon? data_image;

    try {
      data_image = ImageDataPokemon.fromJson(json['sprites']);
    } catch (e) {
      data_image = null;
    }

    return DataPokemon(
      id: '${json['id']}',
      data_image: data_image,
    );
  }

}

class ImageDataPokemon {
  final String image;

  ImageDataPokemon({
    required this.image,
  });

  factory ImageDataPokemon.fromJson(Map<String, dynamic> json) {
    return ImageDataPokemon(
      image: '${json['front_default']}',
    );
  }
}