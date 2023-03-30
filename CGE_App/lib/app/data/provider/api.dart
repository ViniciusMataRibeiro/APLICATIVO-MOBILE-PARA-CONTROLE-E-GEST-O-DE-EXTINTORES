import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/tecnico_request.dart';
import '../Models/user.dart';
import '../Models/user_login_request.dart';
import '../Models/user_login_response.dart';
import '../services/config/service.dart';

class Api {
  final _configService = Get.find<ConfigService>();
  final baseUrl = "http://192.168.10.44:8000";

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    var url = Uri.parse("$baseUrl/login");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return UserLoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserLoginResponseModel(token: '', expiresAt: data['message']);
    }
  }

  Future<UserModel> getUser() async {
    var url = Uri.parse("$baseUrl/auth/me");
    var response = await http
        .get(url, headers: {'authorization': 'Bearer ${_configService.token}'});
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel(nome: '', email: '', tipo: '');
    }
  }

  Future<void> logout() async {
    var url = Uri.parse("$baseUrl/logout?token=${_configService.token}");
    var response = await http.post(url);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed');
    }
  }

  Future<bool> insertTecnico(TecnicoRequestModel data) async {
    var url = Uri.parse("$baseUrl/tecnico");
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTecnico(TecnicoRequestModel data) async {
    var url = Uri.parse("$baseUrl/tecnico/${data.id}");
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${_configService.token}',
        },
        body: jsonEncode(data.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getTecnico() async {
    var url = Uri.parse("$baseUrl/Tecnicos");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${_configService.token}',
    });
    if (response.statusCode == 200) {
      List d = [];
      List dados = await jsonDecode(response.body);
        await Future.forEach(dados, (element) {
        Map<String, dynamic> t = Map.from(element);
        d.add(t);
      });

      return d;
    } else {
      throw Exception('Failed');
    }
  }
}
