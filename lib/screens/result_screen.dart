import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kzlinks/components/qr_dialog.dart';
import 'package:kzlinks/screens/analytic_screen.dart'; // For clipboard functionality

class ResultScreen extends StatefulWidget {
  final String shortenedLink;
  final String analyticsCode;
  final String yourLink;

  const ResultScreen({
    Key? key,
    required this.shortenedLink,
    required this.analyticsCode,
    required this.yourLink,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ResultScreen> {
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
            centerText(),
            const SizedBox(
              height: 96,
            ),
            linkBox(),
            const SizedBox(
              height: 30,
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
          child: Container(
            width: 170,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: const Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 21)),
                Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async => await showQRDialog(
            context,
            widget.shortenedLink,
          ),
          child: Container(
            width: 170,
            height: 68,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: const Column(
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
        ),
      ],
    );
  }

  Widget centerText() {
    return const Text(
      "An Uninterrupted \nURL shrinker",
      style: TextStyle(fontSize: 40),
    );
  }

  Widget credits(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      child: const Text(
        "crafted with ❤️ by your friends at SRMKZILLA team",
        style: TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget customsearchBox() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15),
                border: InputBorder.none,
                hintText: widget.analyticsCode,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 26,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AnalyticScreen(
                    analyticCode: widget.analyticsCode,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget linkBox() {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(19),
      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 15),
          border: InputBorder.none,
          hintText: widget.yourLink,
          hintStyle: const TextStyle(
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 15),
                border: InputBorder.none,
                hintText: widget.shortenedLink,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 28,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              final textToCopy = widget.shortenedLink;
              Clipboard.setData(ClipboardData(text: textToCopy));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Text copied to clipboard'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Padding(padding: EdgeInsets.only(left: 0)),
          const Image(
              image: ResizeImage(AssetImage('assets/icon.png'),
                  width: 50, height: 50)),

          // to add space between the two objects in appbar

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
