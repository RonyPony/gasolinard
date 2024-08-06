import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasolinard/screens/home/homeScreen.dart';
import 'package:provider/provider.dart';

import '../../models/fuels.model.dart';
import '../../providers/fuels.provider.dart';
import '../shared_component/shorcut.dart';

class AllFuelsScreen extends StatefulWidget {
  const AllFuelsScreen({super.key});
  static String routeName = "/allFuelsScreen";
  @override
  State<AllFuelsScreen> createState() => _AllFuelsScreenState();
}

class _AllFuelsScreenState extends State<AllFuelsScreen> {
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    final fuelsProvider = Provider.of<FuelProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: EdgeInsets.only(
            top: baseSize.height * .05,
            left: baseSize.width * .03,
            right: baseSize.width * .03),
        child: Column(
          children: [
            Text(
              "CombustibleRD",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            Text(
              "Todos los Combustibles",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: baseSize.height * .05,
            ),
            FutureBuilder<Fuels>(
              future: fuelsProvider.getAll(),
              builder: (context, snapshot) {
                print(snapshot.hasError);
                print(snapshot.hasData);
                print(snapshot.connectionState);
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
                  Combustibles gpremiun = snapshot.data!.combustibles!
                      .where((element) => element.nombre == "Gasolina Premium")
                      .first;
                  Combustibles gregular = snapshot.data!.combustibles!
                      .where((element) => element.nombre == "Gasolina Regular")
                      .first;
                  Combustibles oilopti = snapshot.data!.combustibles!
                      .where((element) => element.nombre == "Gasoil Óptimo")
                      .first;
                  Combustibles oilRegular = snapshot.data!.combustibles!
                      .where((element) => element.nombre == "Gasoil Regular")
                      .first;

                  Combustibles glp = snapshot.data!.combustibles!
                      .where((element) =>
                          element.nombre == "Gas Licuado de Petroleó (GLP)")
                      .first;
                  Combustibles natural = snapshot.data!.combustibles!
                      .where((element) =>
                          element.nombre == "Gas Natural (GNL-GNC)")
                      .first;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Shortcut(
                            texxt: "Gasolina Premium",
                            value: gpremiun.precio,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Shortcut(
                            texxt: "Gasolina Regular",
                            value: gregular.precio,
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
                            value: oilopti.precio,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Shortcut(
                            texxt: "Gasoil Regular",
                            value: oilRegular.precio,
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
                            value: glp.precio,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Shortcut(
                            texxt: "Gas Natural",
                            value: natural.precio,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
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
                }
                return Text("err");
              },
            )
          ],
        ),
      ),
    );
  }
}
