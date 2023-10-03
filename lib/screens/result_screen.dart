import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For clipboard functionality

class ResultScreen extends StatefulWidget {
  final String shortenedLink;
  final String analyticsLink;
  final String yourLink;

  const ResultScreen({
    Key? key,
    required this.shortenedLink,
    required this.analyticsLink,
    required this.yourLink,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ResultScreen> {
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: ResizeImage(AssetImage('assets/icon.png'), width: 50, height: 50),
          ),
          SizedBox(
            width: 200,
          ),
          Container(
            height: 50,
            width: 100,
            padding: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 14)),
                Text(
                  'My Files',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget centerText() {
    return Text(
      "An Uninterrupted \nURL shrinker",
      style: TextStyle(fontSize: 40),
    );
  }

  Widget linkBox() {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(19),
      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 15),
          border: InputBorder.none,
          hintText: widget.yourLink,
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 26,
          ),
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15),
                border: InputBorder.none,
                hintText: widget.shortenedLink,
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 28,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              final textToCopy = widget.shortenedLink;
              Clipboard.setData(ClipboardData(text: textToCopy));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Text copied to clipboard'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget customsearchBox() {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15),
                border: InputBorder.none,
                hintText: widget.analyticsLink,
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 26,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(padding: EdgeInsets.only(top: 110, left: 6)),
        GestureDetector(
          child: Container(
            width: 170,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 15)),
                Text(
                  'Shrink Another \nURL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          width: 170,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 21)),
              Text(
                'QR Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
      width: MediaQuery.of(context).size.width,
      child: Text(
        "crafted with ❤️ by your friends at SRMKZILLA team",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            centerText(),
            SizedBox(
              height: 96,
            ),
            linkBox(),
            SizedBox(
              height: 30,
            ),
            searchBox(),
            SizedBox(
              height: 30,
            ),
            customsearchBox(),
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
