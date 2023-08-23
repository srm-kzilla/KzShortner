import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class resultScreen extends StatefulWidget {
  const resultScreen({super.key});

  @override
  State<resultScreen> createState() => _resultScreenState();
}

class _resultScreenState extends State<resultScreen> {
  bool isCustomise = true;

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
              image: ResizeImage(AssetImage('assets/icon.png'),
                  width: 50, height: 50)),
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
                  'My Links',
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
    return Visibility(
      visible: isCustomise,
      child: Text(
        "An uninterrupted \nURL shrinker",
        style: TextStyle(fontSize: 40),
      ),
    );
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
            labelText: 'https://dripai1.framer.ai',
            labelStyle: TextStyle(color: Color(0xff000000), fontSize: 26)),
      ),
    );
  }

  Widget customsearchBox() {
    TextEditingController _textEditingController = TextEditingController();
    bool isCustomise = true; // Set this value based on your logic

    return Visibility(
      visible: isCustomise,
      child: Container(
        height: 65,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  border: InputBorder.none,
                  hintText: 'custom code...',
                  hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 26),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                final String text = _textEditingController.text;
                if (text.isNotEmpty) {
                  // Copy the text to the clipboard
                  Clipboard.setData(ClipboardData(text: text));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget analyticsBox() {
    return Visibility(
      visible: isCustomise,
      child: Container(
        height: 65,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Stack(
          children: [
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15),
                border: InputBorder.none,
                hintText: 'analytics code...',
                hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 26),
              ),
            ),
            Positioned(
              right: 2,
              top: 10,
              child: IconButton(
                icon: Icon(Icons.analytics),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.only(left: 0),
          width: 180,
          height: 70,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.black),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 12)),
              Text(
                'shrink another \nURL',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Spacer(),
        Container(
          width: 170,
          height: 68,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.black),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 21)),
              Text(
                'QR Code',
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
              flex: 5,
            ),
            centertext(),
            SizedBox(
              height: 150,
            ),
            searchBox(),
            SizedBox(
              height: 50,
            ),
            customsearchBox(),
            SizedBox(
              height: 10, // Add some spacing here
            ),
            analyticsBox(),
            SizedBox(
              height: 85, // Add some spacing here
            ),
            // Add the third text box
            buttons(),
            Spacer(
              flex: 10,
            ),
            credits(context),
          ],
        ),
      ),
    );
  }
}

class _textEditingController {}
