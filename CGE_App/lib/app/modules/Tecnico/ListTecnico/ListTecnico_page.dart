// ignore_for_file: file_names
import '../../../data/services/auth/service.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'ListTecnico_controller.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

List dados = [];
bool ativo = true;

class ListTecnico extends GetView<ListTecnicoController> {
  const ListTecnico({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ListTecnicoState(
            title: '',
          )),
    );
  }
}

class ListTecnicoState extends StatefulWidget {
  const ListTecnicoState({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ListTecnicoPage createState() => ListTecnicoPage();
}

class ListTecnicoPage extends State<ListTecnicoState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();

  final ListTecnicoController controller = Get.put(ListTecnicoController());
  // ignore: unused_field
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future dadosTecnico;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    dadosTecnico = controller.getTecnico();
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  buildContainer() {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: dadosTecnico,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dados = temp['dados'];
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Get.offAllNamed('/dashboard');
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: size.width * 0.08,
                          height: 40,
                        ),
                        const Text(
                          'Lista de Tecnicos',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 116, 7, 7),
              // shape: const RoundedRectangleBorder(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(25),
              //     bottomRight: Radius.circular(25),
              //   ),
              // ),
            ),
            body: _mostraDados(
                dados: dados, controllerTecnico: controller),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _mostraDados(
      {required List dados, required ListTecnicoController controllerTecnico}) {
    return ListView.builder(
      itemCount: dados.length,
      itemBuilder: (context, index) {
        var size = MediaQuery.of(context).size;
        Map item = dados[index];
        return GestureDetector(
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       contentPadding: EdgeInsets.zero,
            //       content: Container(
            //         padding: const EdgeInsets.all(10.0),
            //         height: 255,
            //         decoration: BoxDecoration(
            //           image: const DecorationImage(
            //             image: AssetImage('assets/image/modal.png'),
            //             fit: BoxFit.cover,
            //           ),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Align(
            //               alignment: Alignment.bottomCenter,
            //               child: Text(
            //                 item['nome'],
            //                 style: const TextStyle(
            //                     fontSize: 20,
            //                     fontStyle: FontStyle.italic,
            //                     fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             const Divider(
            //               color: Colors.black54,
            //               thickness: 2,
            //             ),
            //             Container(
            //               margin: EdgeInsets.only(left: size.width * 0.05),
            //               child: ListTile(
            //                 contentPadding: EdgeInsets.zero,
            //                 leading: const Icon(
            //                   Icons.email_rounded,
            //                   color: Colors.black54,
            //                   size: 35,
            //                 ),
            //                 title: const Text(
            //                   'E-mail',
            //                   style: TextStyle(
            //                       color: Colors.black54,
            //                       fontStyle: FontStyle.italic,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 15),
            //                 ),
            //                 subtitle: Text(
            //                   item['email'],
            //                   style: const TextStyle(
            //                       color: Colors.black54,
            //                       fontStyle: FontStyle.italic,
            //                       fontSize: 15),
            //                 ),
            //               ),
            //             ),
            //             // Container(
            //             //   margin: EdgeInsets.only(left: size.width * 0.05),
            //             //   child: const ListTile(
            //             //     contentPadding: EdgeInsets.zero,
            //             //     leading: Icon(
            //             //       Icons.phone_rounded,
            //             //       color: Colors.black54,
            //             //       size: 35,
            //             //     ),
            //             //     title: Text(
            //             //       'Telefone',
            //             //       style: TextStyle(
            //             //           color: Colors.black54,
            //             //           fontStyle: FontStyle.italic,
            //             //           fontWeight: FontWeight.bold,
            //             //           fontSize: 15),
            //             //     ),
            //             //     subtitle: Text('(35) 9 9999-9999'),
            //             //   ),
            //             // ),
            //             // Container(
            //             //   margin: EdgeInsets.only(left: size.width * 0.05),
            //             //   child: ListTile(
            //             //     contentPadding: EdgeInsets.zero,
            //             //     leading: const Icon(
            //             //       Icones_Personalizado.fire_extinguisher,
            //             //       color: Colors.black54,
            //             //       size: 35,
            //             //     ),
            //             //     title: const Text(
            //             //       'Quantidade de Vistorias',
            //             //       style: TextStyle(
            //             //           color: Colors.black54,
            //             //           fontStyle: FontStyle.italic,
            //             //           fontWeight: FontWeight.bold,
            //             //           fontSize: 15),
            //             //     ),
            //             //     subtitle: Text(
            //             //       item['qtdVistorias'],
            //             //     ),
            //             //   ),
            //             // ),
            //             // Container(
            //             //   margin: EdgeInsets.only(left: size.width * 0.05),
            //             //   child: const ListTile(
            //             //     contentPadding: EdgeInsets.zero,
            //             //     leading: Icon(
            //             //         Icones_Personalizado.fire_extinguisher,
            //             //         color: Colors.black54,
            //             //         size: 35),
            //             //     title: Text(
            //             //       'Extintores Responsáveis',
            //             //       style: TextStyle(
            //             //           color: Colors.black54,
            //             //           fontStyle: FontStyle.italic,
            //             //           fontWeight: FontWeight.bold,
            //             //           fontSize: 15),
            //             //     ),
            //             //     subtitle: Text('2'),
            //             //   ),
            //             // ),
            //             Container(
            //               margin: EdgeInsets.only(left: size.width * 0.05),
            //               child: const ListTile(
            //                 contentPadding: EdgeInsets.zero,
            //                 leading: Icon(Icons.trending_up_outlined,
            //                     color: Colors.black54, size: 35),
            //                 title: Text(
            //                   'Exntitores Vencidos',
            //                   style: TextStyle(
            //                       color: Colors.black54,
            //                       fontStyle: FontStyle.italic,
            //                       fontWeight: FontWeight.bold,
            //                       fontSize: 15),
            //                 ),
            //                 subtitle: Text('2'),
            //               ),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //               children: [
            //                 ElevatedButton(
            //                   style: ElevatedButton.styleFrom(
            //                     backgroundColor:
            //                         const Color.fromARGB(255, 116, 7, 7),
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(100),
            //                     ),
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 30, vertical: 10),
            //                   ),
            //                   onPressed: () {
            //                     Get.toNamed(
            //                       '/cadTecnico',
            //                       arguments: item,
            //                     );
            //                   },
            //                   child: const Text(
            //                     'Editar',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 18,
            //                       fontStyle: FontStyle.italic,
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: size.height * 0.05,
            //                   child: const VerticalDivider(
            //                     thickness: 2,
            //                     color: Colors.black54,
            //                   ),
            //                 ),
            //                 ElevatedButton(
            //                   style: ElevatedButton.styleFrom(
            //                     backgroundColor:
            //                         const Color.fromARGB(255, 116, 7, 7),
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(100),
            //                     ),
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 30, vertical: 10),
            //                   ),
            //                   onPressed: () {},
            //                   child: const Text('Excluir',
            //                       style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: 18,
            //                           fontStyle: FontStyle.italic)),
            //                 ),
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //     );
            //  },
            // );
          },
          child: Container(
            height: 120,
            margin: const EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 7, left: 7, top: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/cadTecnico',
                              arguments: item,
                            );
                          },
                          child: const Icon(Icons.edit, size: 30),
                        ),
                        InkWell(
                          onTap: () {
                            {
                              controller.gotoDeleteTecnico(item['id']);
                            }
                          },
                          child: const Icon(
                            Ionicons.close_outline,
                            size: 30,
                            color: Color.fromARGB(255, 116, 7, 7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        _icone(item),
                        const SizedBox(width: 10),
                        _nome(item),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _icone(Map item) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        width: 8,
        color: const Color.fromARGB(255, 175, 31, 21),
      ),
    ),
    child: const Column(
      children: [
        Icon(
          Icons.person,
          size: 50,
          color: Color.fromARGB(255, 175, 31, 21),
        ),
      ],
    ),
  );
}

Widget _nome(Map item) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item['nome'] ?? 'Sem informação',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );
}

// Widget _detalhes(Map item, ListTecnicoController controllerTecnico) {
//   return Card(
//     color: const Color.fromARGB(255, 242, 242, 242),
//     margin: const EdgeInsets.all(10),
//     child: Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         children: [
//           const SizedBox(height: 10),
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: Text(
//                   "Status Extintor",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 30),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Flexible(
//                 flex: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Extintores Expirando",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         item['qtdVistorias'] ?? 'Sem informação',
//                         style: const TextStyle(
//                           fontSize: 50,
//                           color: Color.fromARGB(255, 255, 204, 77),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Flexible(
//                 flex: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Extintores Expirados",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         item['qtdVistorias'] ?? 'Sem informação',
//                         style: const TextStyle(
//                           fontSize: 50,
//                           color: Color.fromARGB(255, 255, 0, 0),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
