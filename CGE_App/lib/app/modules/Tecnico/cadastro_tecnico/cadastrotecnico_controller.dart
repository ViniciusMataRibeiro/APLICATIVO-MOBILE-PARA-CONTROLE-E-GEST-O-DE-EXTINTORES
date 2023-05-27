import 'package:cge_app/app/data/Models/tecnico_request.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/services/auth/service.dart';

class CadastroTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();

  var idTecnico = 0;

  var showPassword = true.obs;
  var name = TextEditingController(text: '');
  var email = TextEditingController(text: '');
  var password = TextEditingController(text: '');
  var bloqueado = false.obs;
  var alterando = false;
  late Map _tecnico;

  @override
  void onInit() {
    if (Get.arguments != null) {
      _tecnico = Get.arguments;
      name.text = _tecnico['nome'];
      email.text = _tecnico['email'];
      bloqueado = _tecnico['status'] == 'Inativo' ? true.obs : false.obs;

      idTecnico = _tecnico['id'];

      alterando = true;
    } else {
      alterando = false;
    }

    super.onInit();
  }

  Future<String> goToInsert() async {
    if (name.text == '') {
      return 'Informe o nome';
    }

    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.text);

    if (!emailValid) {
      return 'Informe um email válido';
    }
    if (name.text.length < 6 && password.text != '') {
      return 'A Senha deve conter no mínimo 6 caracteres';
    }

    var tecnicoRequestModel = TecnicoRequestModel(
        id: idTecnico,
        email: email.text,
        password: password.text,
        name: name.text,
        bloqueado: bloqueado.value);

    bool res = false;

    if (idTecnico > 0) {
      res = await _authService.updateTecnico(tecnicoRequestModel);
    } else {
      res = await _authService.insertTecnico(tecnicoRequestModel);
    }

    return res == true ? 'true' : 'Algo deu Errado';
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<bool?> toast(String message) {
    Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
