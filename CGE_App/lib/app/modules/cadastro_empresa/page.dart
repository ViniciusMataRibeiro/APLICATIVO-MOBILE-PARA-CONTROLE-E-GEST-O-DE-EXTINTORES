import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

class CadastroEmpresaPage extends GetView<CadastroEmpresaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 30),
                width: 40,
                height: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    'assets/image/cge.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text('Cadastro Empresa',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      ),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/registro.jpeg'),
                      fit: BoxFit.cover)),
              child: ListView(children: [
                Center(
                    child: Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(top: 60),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/cge.jpeg'),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                        ),
                      ]),
                )),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  margin:
                      const EdgeInsets.only(bottom: 100, left: 40, right: 40),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 0, top: 8),
                          padding: const EdgeInsets.only(bottom: 0),
                  ),
                  Form(
                    child: TextFormField(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,                       
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                        labelText: 'Nome',
                    ),
                  ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Email',
                      ),
                    ),
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Senha',
                      ),
                    )
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Telefone',
                      ),
                    )
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // ignore: prefer_const_constructors
                    Center(
                      child: const Text('Endereço',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      ),
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Cidade',
                      ),
                    )
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Cep',
                      ),
                    )
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Bairro',
                      ),
                    )
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Rua',
                      ),
                    )
                    ),
                    Form(
                    child: TextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                        ),
                        labelText: 'Numero',
                      ),
                    )
                    ),
                  ],
                ),
              ),
            ])
        )));
  }
}