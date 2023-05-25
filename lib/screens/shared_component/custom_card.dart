import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _createState();
}

class _createState extends State<CustomCard> {
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
                    Text(
                      "Historial",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Feb 14 - Mar 20",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: Text(
                            "Ver mas",
                            style: TextStyle(color: Colors.white),
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
