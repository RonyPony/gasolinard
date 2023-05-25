import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasolinard/screens/shared_component/custom_card.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: EdgeInsets.only(
            top: baseSize.height * .05,
            left: baseSize.width * .1,
            right: baseSize.width * .1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                Text(
                  "Find your course",
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
                SizedBox(
                  width: baseSize.width * .2,
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
              child: CustomCard(),
            ),
            SizedBox(
              height: baseSize.height * .04,
            ),
            Text(
              "Combustibles",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Shortcut(
                      texxt: "Gasolina Premium",
                      value: 137.60,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Shortcut(
                      texxt: "Gasolina Regular",
                      value: 169.40,
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Shortcut(
                      texxt: "Gasoil Premium",
                      value: 119.60,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Shortcut(
                      texxt: "Gasoil Regular",
                      value: 177.60,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Text(
                        "Otros Combustibles",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
