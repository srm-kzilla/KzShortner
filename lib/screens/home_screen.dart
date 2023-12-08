import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCustomise = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(
              flex: 1,
            ),
            centertext(),
            const SizedBox(
              height: 96,
            ),
            searchBox(),
            const SizedBox(
              height: 30,
            ),
            customsearchBox(),
            buttons(),
            const Spacer(
              flex: 2,
            ),
            credits(context),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(padding: EdgeInsets.only(top: 110, left: 6)),
        GestureDetector(
          onTap: () {
            setState(() {
              isCustomise = !isCustomise;
            });
          },
          child: Container(
            width: 170,
            height: 68,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.black),
            child: const Column(
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
        ),
        const Spacer(),
        Container(
          width: 170,
          height: 68,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.black),
          child: const Column(
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

  Widget centertext() {
    return const Text(
      "A breezy \nURL shrinker",
      style: TextStyle(fontSize: 40),
    );
  }

  Widget credits(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 15),
        width: MediaQuery.sizeOf(context).width,
        child: const Text(
          "crafted with ❤️ by your friends at SRMKZILLA team",
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ));
  }

  Widget customsearchBox() {
    return Visibility(
      visible: isCustomise,
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(19)),
        child: const TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 15),
              border: InputBorder.none,
              hintText: 'Enter custom code...',
              hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 26)),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(19)),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15),
          border: InputBorder.none,
          hintText: 'Enter your link here...',
          hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 26),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Padding(padding: EdgeInsets.only(left: 0)),
          const Image(
              image: ResizeImage(AssetImage('assets/icon.png'),
                  width: 50, height: 50)),

          // to add space between the two objects in appbar
          const SizedBox(
            width: 200,
          ),
          GestureDetector(
              child: Container(
                height: 50,
                width: 100,
                padding: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black),
                child: const Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 14)),
                    Text(
                      'My Links',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/my_links');
              })
        ],
      ),
    );
  }
}
