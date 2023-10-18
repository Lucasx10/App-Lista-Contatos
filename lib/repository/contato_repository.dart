import 'package:app_lista_contatos/model/contatos_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContatoRepository {
  final Dio _dio = Dio();

  Future<bool> addContato(ContatoModel contato) async {
    try {
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("BACK4APPAPPLICATIONID");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("BACK4APPRESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";
      _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
      await _dio.post('/Contatos', data: contato.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateContato(ContatoModel contato) async {
    try {
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("BACK4APPAPPLICATIONID");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("BACK4APPRESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";
      _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
      await _dio.put('/Contatos/${contato.id}', data: contato.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteContato(String id) async {
    try {
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("BACK4APPAPPLICATIONID");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("BACK4APPRESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";
      _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
      await _dio.delete('/Contatos/$id');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ContatoModel>> getAll() async {
    try {
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("BACK4APPAPPLICATIONID");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("BACK4APPRESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";
      _dio.options.baseUrl = dotenv.get("BACK4APPBASEURL");
      Response response = await _dio.get('/Contatos');

      List<ContatoModel> contatos = [];

      if (response.data['results'] != null &&
          response.data['results'] is List) {
        contatos = response.data['results']
            .map<ContatoModel>(
              (e) => ContatoModel.fromMap(e),
            )
            .toList();
      }

      return contatos;
    } catch (e) {
      return [];
    }
  }
}
