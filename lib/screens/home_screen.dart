import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kzlinks/model/link.dart';
import 'package:kzlinks/screens/result_screen.dart';
import 'package:kzlinks/services/api_services.dart';
import 'package:kzlinks/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController shortCodeController = TextEditingController();
  TextEditingController linkIdController = TextEditingController();
  bool isCustomise = false;
  late Future<List<KzLink>> links;

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
              height: 20,
            ),
            customsearchBox(),
            const SizedBox(
              height: 10,
            ),
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
              shortCodeController.clear();
              isCustomise = !isCustomise;
            });
          },
          child: Container(
            width: 170,
            height: 68,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.black),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 21)),
                Text(
                  !isCustomise ? 'CUSTOMISE' : 'RANDOMIZE',
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
        GestureDetector(
          onTap: () async {
            showDialog(
              // Show a loading dialog
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text("Creating short link..."),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
            // Call the makeApiRequest function when "SHRINK" button is tapped
            try {
              final linkId = linkIdController.text.trim();
              final shortCode = shortCodeController.text.trim();
              if (linkId.isEmpty || !linkRegex.hasMatch(linkId)) {
                throw Exception('Please enter a valid URL');
              }
              if (isCustomise &&
                  (shortCode.isEmpty || !shortCodeRegex.hasMatch(shortCode))) {
                throw Exception(
                    'Please enter a valid shortcode of minimum 4 alphanumeric characters');
              }
              final link = await KzApi.createShortLink(
                  linkId, isCustomise ? shortCode : null);
              Navigator.of(context).pop(); // Close the loading dialog
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ResultScreen(
                    shortenedLink: link.shortCode,
                    analyticsCode: link.analyticsCode,
                    yourLink: link.longUrl,
                  ),
                ),
              );
            } on DioException catch (e) {
              Navigator.of(context).pop(); // Close the loading dialog
              debugPrint("${e.response!.data}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.response?.statusCode != 409
                      ? "Failed to create short link"
                      : "Shortcode already exists"),
                  backgroundColor: Colors.red.shade600,
                  duration: const Duration(seconds: 2, milliseconds: 500),
                  showCloseIcon: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  dismissDirection: DismissDirection.horizontal,
                ),
              );
            } on Exception catch (e) {
              Navigator.of(context).pop(); // Close the loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(e.toString().replaceAll('Exception:', '').trim()),
                  backgroundColor: Colors.red.shade600,
                  duration: const Duration(seconds: 2, milliseconds: 500),
                  showCloseIcon: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      left: 20,
                      right: 20),
                  dismissDirection: DismissDirection.horizontal,
                ),
              );
            }
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
                  'SHRINK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
        child: TextField(
          style: const TextStyle(fontSize: 20),
          controller: shortCodeController,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 16),
              border: InputBorder.none,
              hintText: 'Enter custom code...',
              hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 22)),
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
      child: TextField(
        controller: linkIdController,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          border: InputBorder.none,
          hintText: 'Enter your link here...',
          hintStyle: TextStyle(color: Color(0xff7C7D7D), fontSize: 22),
        ),
      ),
    );
  }

  @override
  void dispose() {
    linkIdController.dispose();
    shortCodeController.dispose(); // Dispose of the controller when done
    super.dispose();
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
