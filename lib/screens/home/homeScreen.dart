import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasolinard/models/fuels.model.dart';
import 'package:gasolinard/providers/fuels.provider.dart';
import 'package:gasolinard/screens/allFuels.dart/allFuelsScreen.dart';
import 'package:gasolinard/screens/shared_component/custom_card.dart';
import 'package:provider/provider.dart';

import '../shared_component/custom_card promo.dart';
import '../shared_component/shorcut.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/homeScreen";

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bienvenido",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                const Text(
                  "CombustibleRD",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(
                  width: baseSize.width * .3,
                ),
                CupertinoButton(
                  padding: EdgeInsets.only(
                      left: baseSize.width * .02, right: baseSize.width * .02),
                  onPressed: () {},
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  color: Colors.white,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: baseSize.height * .05),
              child: CustomCardPromo(),
            ),
            SizedBox(
              height: baseSize.height * .04,
            ),
            const Text(
              "Precios de esta semana",
              style: TextStyle(fontSize: 28, color: Colors.white),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AllFuelsScreen.routeName);
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
                                "Otros Combustibles",
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
