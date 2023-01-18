import 'package:app_cge/app/data/models/user_login_request.dart';
import 'package:app_cge/app/data/services/auth/repository.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {

  AuthRepository _repository;

  AuthService(this._repository);

  Future login(UserLoginRequestModel userLoginRequest) {
   var data = _repository.login(userLoginRequest);

   return data;
  }
}