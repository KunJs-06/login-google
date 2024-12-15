class PokemonListData {
  final String name;
  final String url;

  PokemonListData({
    required this.name,
    required this.url
  });

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
  final String name;
  final String weight;
  final String height;
  final ImageDataPokemon? sprites;
  final List<ListTypesDataPokemon> types;

  DataPokemon({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    required this.sprites,
    required this.types,
  });

  factory DataPokemon.fromJson(Map<String, dynamic> json) {
    ImageDataPokemon? sprites;
    List<ListTypesDataPokemon>? types = [];

    try {
      sprites = ImageDataPokemon.fromJson(json['sprites']);
    } catch (e) {
      sprites = null;
    }
    try {
      types = (json['types'] as List).map((i) => ListTypesDataPokemon.fromJson(i)).toList();
    } catch (e) {
      types = [];
    }

    return DataPokemon(
      id: '${json['id']}',
      name: '${json['name']}',
      weight: '${json['weight']}',
      height: '${json['height']}',
      sprites: sprites,
      types: types,
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

class ListTypesDataPokemon {
  final String slot;
  final TypesDataPokemon type;

  ListTypesDataPokemon({
    required this.slot,
    required this.type,
  });

  factory ListTypesDataPokemon.fromJson(Map<String, dynamic> json) {
    TypesDataPokemon? type;

    try {
      type = TypesDataPokemon.fromJson(json['type']);
    } catch (e) {
      type = null;
    }
    return ListTypesDataPokemon(
      slot: '${json['slot']}',
      type: type!,
    );
  }
}

class TypesDataPokemon {
  final String name;
  final String url;

  TypesDataPokemon({
    required this.name,
    required this.url,
  });

  factory TypesDataPokemon.fromJson(Map<String, dynamic> json) {
    return TypesDataPokemon(
      name: '${json['name']}',
      url: '${json['url']}',
    );
  }
}