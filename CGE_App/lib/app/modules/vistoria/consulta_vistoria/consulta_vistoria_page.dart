import 'package:faker/faker.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Icones/icones_personalizado.dart';
import '../../../core/app_theme.dart';
import '../../../data/services/auth/service.dart';
import '../../Extintor/extintores/extintores_controller.dart';
import 'consulta_vistoria_controller.dart';
import 'dart:ui' as ui;

DateTime selectedDate = DateTime.now();
String updatedDt = DateFormat("dd/MM/y").format(selectedDate);
String updatedDt2 = DateFormat("y-MM-dd").format(selectedDate);
List dados = [];

class ConsultaVistoria extends GetView<ConsultaVistoriaController> {
  const ConsultaVistoria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: const Directionality(
          textDirection: ui.TextDirection.ltr,
          child: ConsultaVistoriaState(
            title: '',
          )),
    );
  }
}

class ConsultaVistoriaState extends StatefulWidget {
  const ConsultaVistoriaState({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  ConsultaVistoriaPage createState() => ConsultaVistoriaPage();
}

class ConsultaVistoriaPage extends State<ConsultaVistoriaState>
    with SingleTickerProviderStateMixin {
  AuthService aux = Get.find<AuthService>();
  ExtintorController controller = Get.put(
    ExtintorController(),
  );

  String obterImagem(String tipoExtintor) {
    switch (tipoExtintor) {
      case 'Tipo A':
        return 'assets/image/ExtintorClassesA.png';
      case 'Tipo B':
        return 'assets/image/ExtintorClassesB.png';
      case 'Tipo ABC':
        return 'assets/image/ExtintorClassesABC.png';
      case 'Tipo AB':
        return 'assets/image/ExtintorClassesAB.png';
      case 'Tipo BC':
        return 'assets/image/ExtintorClassesBC.png';
      case 'Tipo C':
        return 'assets/image/ExtintorClassesC.png';
      case 'Tipo D':
        return 'assets/image/ExtintorClassesD.png';
      case 'Tipo K':
        return 'assets/image/ExtintorClassesK.png';
      default:
        return 'Imagem não encontrada';
    }
  }

  var number = faker.randomGenerator.integer(50);
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Future mapa;

  DateTime selectedDate = DateTime.now();

  // ignore: unused_element
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        cancelText: "CANCELAR",
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  primaryColor: const Color(0xFF4C131A),
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  colorScheme: const ColorScheme.light(
                          primary: Color.fromARGB(255, 190, 0, 0))
                      .copyWith(secondary: const Color(0xFF4C131A))),
              child: child!,
            ));
    if (picked != null && picked != selectedDate) {
      setState(
        () {
          _refresh(data: picked);
        },
      );
    }
  }

  _refresh({DateTime? data}) async {
    try {
      data ??= DateTime.parse(updatedDt2);

      setState(() {
        selectedDate = data!;
        updatedDt = DateFormat("dd/MM/y").format(data);
        updatedDt2 = DateFormat("y-MM-dd").format(data);
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    mapa = controller.getAllExtintor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //var obj = aux.user.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.offAllNamed('/perfil');
                      },
                    ),
                    SizedBox(width: size.width * 0.01),
                    Image.asset(
                      'assets/image/cge.png',
                      fit: BoxFit.contain,
                      height: 45,
                    ),
                    SizedBox(width: size.width * 0.09),
                    Text(
                      textAlign: TextAlign.center,
                      updatedDt,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notification_important, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () => _refresh(),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 190, 0, 0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        // child: FloatingActionBubble(
        //   herotag: UniqueKey(),
        //   items: <Bubble>[
        //     if (obj!.tipo == 'empresa') ...[
        //       Bubble(
        //         title: "Cadastrar Tecnico",
        //         iconColor: Colors.white,
        //         bubbleColor: const Color.fromARGB(255, 190, 0, 0),
        //         icon: Icons.check_circle_outline,
        //         titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
        //         onPress: () {
        //           Get.toNamed('/cadTecnico');
        //         },
        //       ),
        //     ] else ...[
        //       Bubble(
        //         title: "Cadastrar Extintor",
        //         iconColor: Colors.white,
        //         bubbleColor: const Color.fromARGB(255, 190, 0, 0),
        //         icon: Icons.add_rounded,
        //         titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
        //         onPress: () {
        //           Get.toNamed('/cadExtintor');
        //         },
        //       ),
        //       Bubble(
        //         title: "Realizar Vistoria",
        //         iconColor: Colors.white,
        //         bubbleColor: const Color.fromARGB(255, 190, 0, 0),
        //         icon: Icons.check_rounded,
        //         titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
        //         onPress: () {
        //           Get.toNamed('/vistoria');
        //         },
        //       ),
        //     ],
        //   ],
        //   animation: _animation,
        //   onPress: () => _animationController.isCompleted
        //       ? _animationController.reverse()
        //       : _animationController.forward(),
        //   iconColor: Colors.white,
        //   iconData: Icons.handyman_outlined,
        //   backGroundColor: const Color.fromARGB(255, 190, 0, 0),
        // ),
      ),
      body: buildContainer(),
    );
  }

  buildContainer() {
    return FutureBuilder(
      future: mapa,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map temp = snapshot.data;
          dados = temp['dados'];
          if (dados.isNotEmpty) {
            Future.delayed(
              const Duration(minutes: 1),
              () {
                if (mounted) {
                  _refresh();
                }
              },
            );
            return Scaffold(
              body: Center(
                child: _mostradados(dados: dados),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Nenhum dado encontrado'),
              ),
            );
          }
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

  _mostradados({required List dados}) {
    return ListView.builder(
      itemCount: dados.length,
      padding: const EdgeInsets.only(bottom: 52, top: 50),
      itemBuilder: (BuildContext context, index) {
        var size = MediaQuery.of(context).size;
        Map item = dados[index];
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: size.height * 0.6,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/image/modal.png'),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            item['nome'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(
                          color: Colors.black54,
                          thickness: 2,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range_outlined,
                                color: Colors.black54, size: 35),
                            title: const Text(
                              'Ultima Vistoria',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateTime.parse(
                                  item['validadeExtintor'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range_outlined,
                                color: Colors.black54, size: 35),
                            title: const Text(
                              'Validade Extintor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateTime.parse(
                                  item['validadeExtintor'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.date_range_outlined,
                                color: Colors.black54, size: 35),
                            title: const Text(
                              'Venc. Hidrostatico',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy').format(
                                DateTime.parse(
                                  item['validadeCasco'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(
                                Icones_Personalizado.fire_extinguisher,
                                color: Colors.black54,
                                size: 35),
                            title: const Text(
                              'Tipo Extintor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(
                                '${item['tipoExtintor']}\t${item['tamanho']} Kg'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: size.width * 0.05),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.trending_up_outlined,
                                color: Colors.black54, size: 35),
                            title: const Text(
                              'Setor',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            subtitle: Text(item['setor']),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            height: size.height * 0.47,
            child: Stack(
              children: [
                Card(
                  elevation: 4.0,
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/image/modal_vistoria.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(item['validadeCasco']),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          height: 2,
                          color: Colors.grey,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                        ),
                        //SizedBox(height: size.height * 0.01),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, left: size.width * 0.05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //SizedBox(width: size.width * 0.08),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: size.width * 0.01),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icones_Personalizado.fire_extinguisher,
                                        size: 38,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Numero Extintor',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            dados[index]['nome'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.location_on_sharp,
                                        size: 38,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Setor',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            item['setor'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.engineering,
                                        size: 38,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Técnico Responsavel',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            item['setor'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.date_range_outlined,
                                        size: 38,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Proxima Manutenção',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            item['setor'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.check_outlined,
                                        size: 38,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Apto para uso',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            'OK',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              // decoration:
                                              //     TextDecoration.underline,
                                              // decorationColor: Colors.green,
                                              // decorationStyle:
                                              //     TextDecorationStyle.solid,
                                              // decorationThickness: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 3,
                          color: Colors.green,
                          margin: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
