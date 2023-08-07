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
        padding: const EdgeInsets.only(left: 15, right: 15, top: 400),
        child: Column(
          children: [
            searchBox(),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Color(0xffF5F5F5), borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 15),
            border: InputBorder.none,
            hintText: 'Enter your link here...',
            hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 26)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      title: Row(
        children: [
          Image(
            image: ResizeImage(AssetImage('assets/icon.png'),
                width: 50, height: 50),
            //image: AssetImage('icon.png'),
          )
        ],
      ),
    );
  }
}
