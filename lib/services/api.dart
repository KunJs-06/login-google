import 'dart:convert';
import 'package:login_google/models/pokemon_model.dart';
import 'package:http/http.dart' as http;

const String host = "https://pokeapi.co/";
const String errorInternetConnection = "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้ กรุณาลองอีกครั้ง";
const String errorDataNotFound = "ไม่พบข้อมูล";
const String errorSomethingWentWrong = "เกิดข้อผิดพลาดในการทำงาน กรุณาลองใหม่อีกครั้ง";
const String progressWaitMessage = "กรุณารอสักครู่...";

class DefaultReturnWithData<Class> {
  final Class? results;

  DefaultReturnWithData({this.results});

  factory DefaultReturnWithData.fromJson(Map<String, dynamic> json, Function(dynamic) callback) {
    Class? temp;
    String? error;
    try {
      temp = callback(json['results']);
    } catch (e) {
      temp = null;
      error = errorInternetConnection;
    }
    return DefaultReturnWithData(results: temp);
  }
}

Future<DefaultReturnWithData<Class>> defaultApiGetNoLoadList<Class>(String url, Function(dynamic) jsonConvert, Future<bool> Function(DefaultReturnWithData<Class>) onSuccess,) async {
  http.Response response;
  DefaultReturnWithData<Class> responseData;
  try {
    response = await http.get(
      Uri.parse(host + url ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    responseData = DefaultReturnWithData<Class>.fromJson(json.decode(response.body), jsonConvert);
  } catch (e) {
    print("e ${e}");
    throw errorInternetConnection;
  }
  if (responseData.results != [] || responseData.results != null) {
    if (await onSuccess(responseData)) {
      return responseData;
    }
    throw errorSomethingWentWrong;
  }
  throw responseData;
}

Future<DefaultReturnWithData<List<PokemonListData>>> getPokemonDataList(int offset, int limit) async {
  return defaultApiGetNoLoadList<List<PokemonListData>>( "api/v2/pokemon?offset=${offset}&limit=${limit}",
        (data) => (data as List).map((i) => PokemonListData.fromJson(i)).toList(),
        (returnData) async {
      if (returnData.results == null || returnData.results == []) {
        return false;
      }
      return true;
    },
  );
}

//------------------------------------------------------------------------------------------------------//

Future<DataPokemon> getPokemonImage(urlImage) async {
  try {
    final response = await http.get(
      Uri.parse(urlImage),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return DataPokemon.fromJson(data);
    } else {
      throw Exception("Failed to load Pokémon detail. Error: ${response.statusCode}");
    }
  } catch (error) {
    throw Exception("Error fetching Pokémon detail: $error");
  }
}

