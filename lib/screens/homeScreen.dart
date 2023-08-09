import 'package:flutter/material.dart';
import 'package:kzlinks/resources/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: Color.fromRGBO(255, 255, 255, 1),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 1,
            ),
            centertext(),
            SizedBox(
              height: 96,
            ),
            searchBox(),
            buttons(),
            Spacer(
              flex: 2,
            ),
            credits(context),
          ],
        ),
      ),
    );
  }
}

AppBar _buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Padding(padding: EdgeInsets.only(left: 0)),
        Image(
            image: ResizeImage(AssetImage('assets/icon.png'),
                width: 50, height: 50)),

        // to add space between the two objects in appbar
        SizedBox(
          width: 200,
        ),
        Container(
          height: 50,
          width: 100,
          padding: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.black),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 14)),
              Text(
                'My Files',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget centertext() {
  return (Text(
    "A breezy \nURL shrinker",
    style: TextStyle(fontSize: 40),
  ));
}

Widget searchBox() {
  return Container(
    height: 65,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
        color: Color(0xffF5F5F5), borderRadius: BorderRadius.circular(2)),
    child: TextField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15),
          border: InputBorder.none,
          hintText: 'Enter your link here...',
          hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 26)),
    ),
  );
}

Widget buttons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Padding(padding: EdgeInsets.only(top: 110, left: 6)),
      Container(
        width: 170,
        height: 68,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 21)),
            Text(
              'Customise',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      SizedBox(width: 40),
      Container(
        width: 170,
        height: 68,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 21)),
            Text(
              'SHRINK',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget credits(BuildContext context) {
  return Container(
      padding: EdgeInsets.only(bottom: 15),
      width: MediaQuery.sizeOf(context).width,
      child: Text(
        "crafted with ❤️ by your friends at SRMKZILLA team",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ));
}
