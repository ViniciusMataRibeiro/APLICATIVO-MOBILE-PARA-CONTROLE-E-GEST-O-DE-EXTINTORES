// ignore_for_file: file_names
import '../../../data/services/auth/service.dart';
import 'package:cge_app/app/routes/routes.dart';
import 'package:get/get.dart';

class ListTecnicoController extends GetxController {
  final _authService = Get.find<AuthService>();

  bool get isAtivo => true;

  Future<Map> getTecnico() async {
    Map t = await _authService.getTecnico();

    return t;
  }

  Future<void> gotoEditTecnico(Map item) async {
    await Get.toNamed(Routes.cadTecnico, arguments: item);
  }

  Future<void> gotoDeleteTecnico(int idTecnico) async {
    await _authService.deleteTecnico(idTecnico);
  }
}
