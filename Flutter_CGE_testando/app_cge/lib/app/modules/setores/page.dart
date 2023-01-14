import 'package:app_cge/app/modules/setores/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';

class SetorPage extends GetView<SetorController> {
  var number = faker.randomGenerator.integer(50);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/cadSetor');
          },
          backgroundColor: const Color.fromARGB(255, 175, 31, 21),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child: const Icon(Icons.add_rounded, size: 40, color: Colors.white),
        ),
        body: Center(
            child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/registro.jpeg'),
                  fit: BoxFit.cover)),
          child: ListView(
            children: [
              for (var i = 1; i <= 10; i++) ...[
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    surfaceTintColor: const Color.fromARGB(255, 201, 201, 201),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(faker.lorem.words(2).join(' '),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 131, 30, 23),
                                  fontStyle: FontStyle.italic)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 25, color: Colors.green),
                                        Expanded(
                                          child: Text('Extintores Funcional',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black45,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 25,
                                            color: Colors.greenAccent),
                                        Expanded(
                                          child: Text('Extintores a Vencer',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black45,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.circle,
                                            size: 25,
                                            color: Colors.yellowAccent),
                                        Expanded(
                                          child: Text('Extintores Vencidos',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black45,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 150,
                                width: 120,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      'https://picsum.photos/250?image=${i + number}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        )));
  }
}
