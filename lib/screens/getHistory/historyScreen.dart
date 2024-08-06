import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/fuels.model.dart';
import '../../providers/fuels.provider.dart';
import '../allFuels.dart/allFuelsScreen.dart';
import '../home/homeScreen.dart';
import '../shared_component/custom_card.dart';
import '../shared_component/shorcut.dart';
import '../shared_component/underconstruction.dart';

class HistoryFuels extends StatefulWidget {
  const HistoryFuels({super.key});
  static String routeName = "/historyScreen";
  @override
  State<HistoryFuels> createState() => _HistoryFuelsState();
}

class _HistoryFuelsState extends State<HistoryFuels> {
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    final fuelsProvider = Provider.of<FuelProvider>(context);
    return Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                  "Volver",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey.shade800,
        body: Padding(
            padding: EdgeInsets.only(
                top: baseSize.height * .05,
                left: baseSize.width * .03,
                right: baseSize.width * .03),
            child: Column(children: [
              Text(
                "CombustibleRD",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              Text(
                "Historico de Combustibles",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: baseSize.height * .05,
              ),
              SizedBox(
                height: baseSize.height * .05,
              ),
              FutureBuilder<List<Fuels>>(
                future: fuelsProvider.getHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: baseSize.height * .4,
                        ),
                        Text("Ups, intentalo mas tarde")
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: baseSize.height * .4,
                        ),
                        const CircularProgressIndicator(
                          color: Color.fromARGB(255, 255, 0, 0),
                        )
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text("Error");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return UnderConstructionWidget();
                    return Container(
                        color: Colors.red,
                        height: baseSize.height * .5,
                        width: baseSize.width,
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Shortcut(
                                      texxt: "Gasolina Premium",
                                      value: '0',
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Shortcut(
                                      texxt: "Gasolina Regular",
                                      value: '0',
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Shortcut(
                                      texxt: "Gasoil Premium",
                                      value: '0',
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Shortcut(
                                      texxt: "Gasoil Regular",
                                      value: '0',
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Shortcut(
                                      texxt: "GLP",
                                      value: '0',
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Shortcut(
                                      texxt: "Gas Natural",
                                      value: '0',
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, HomeScreen.routeName);
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: Text(
                                          "Volver",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ));
                  }
                  return Text("err");
                },
              )
            ])));
  }
}
