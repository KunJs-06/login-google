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