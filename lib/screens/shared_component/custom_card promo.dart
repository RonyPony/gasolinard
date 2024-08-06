import 'package:flutter/material.dart';
import 'package:gasolinard/screens/getHistory/historyScreen.dart';
import 'package:gasolinard/screens/shared_component/textAnimation.dart';

class CustomCardPromo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _createState();
}

class _createState extends State<CustomCardPromo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    ChangingTextWidget()
                    // Text(
                    //   "CONFIABLE",
                    //   style: TextStyle(color: Colors.white, fontSize: 35),
                    // )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Del pueblo y para el pueblo",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, HistoryFuels.routeName);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue, Colors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 3, bottom: 3),
                            child: Text(
                              "REPÚBLICA DOMINICANA",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                Image.asset(
                  "assets/fuel1.png",
                  scale: 4,
                )
              ],
            )
          ],
        )); // Card(
    //   color: Colors.red,
    //   child: Column(
    //     children: [Image.asset("assets/fuel1.png")],
    //   ),
    // );
  }
}
