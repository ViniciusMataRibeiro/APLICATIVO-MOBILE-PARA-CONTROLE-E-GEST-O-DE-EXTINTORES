import 'package:cge_app/app/modules/Empresa/perfil_empresa/perfilEmpresa_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/services/auth/service.dart';

class PerfilPage extends GetView<PerfilEmpresaController> {
AuthService aux = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    var obj = aux.user.value;
    var nome = obj!.nome;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/registro.jpeg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4C131A),
                      Color.fromARGB(255, 175, 31, 21),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.person_pin,
                          size: 150, color: Colors.white),
                      Text(
                        nome,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Card(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    color: const Color(0xFFD7CCC8),
                    elevation: 5,
                    child: ListTile(
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading: const Icon(Icons.person_pin, size: 40),
                      trailing: const Icon(Icons.logout, color: Colors.black),
                      onTap: () {
                        controller.goTologout();
                      },
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    color: const Color(0xFFD7CCC8),
                    elevation: 5,
                    child: ListTile(
                      title: const Text(
                        "Consultar Tecnico",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      leading:
                          const Icon(Ionicons.document_text_outline, size: 40),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.black),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
