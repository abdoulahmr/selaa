import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../functions.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, required this.productID}) : super(key: key);

  final String productID;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> userInfo = [];
  List<Map<String, dynamic>> posteInfo = [];

  @override
  void initState() {
    super.initState();
    loadUserInfo().then((List<Map<String, dynamic>> user) {
      setState(() {
        userInfo = user;
      });
    });
    loadPosteInfo(widget.productID).then((List<Map<String, dynamic>> poste) {
      setState(() {
        posteInfo = poste;
      });
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 50, left: 30),
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: userInfo.isNotEmpty && userInfo[0]['profilePicture'] != null
                        ? NetworkImage(userInfo[0]['profilePicture'])
                        : const NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/selaa-2ff93.appspot.com/o/profilePicture%2Fkisspng-computer-icons-download-avatar-5b3848b5343f86.741661901530415285214-removebg-preview%20(1).png?alt=media&token=0c01bbf5-f998-4ad9-af94-235ba6fd4ab5',
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      userInfo[0]['username'],
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Color(0xFFF2F4F4)),
              child: posteInfo.isNotEmpty && posteInfo[0]['imageUrls'] != null
                ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: posteInfo[0]['imageUrls'].length,
                    itemBuilder: (context, index) {
                      return Image.network(posteInfo[0]['imageUrls'][index]);
                    },
                  ),
                )
                : const Text('No images available'),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  posteInfo[0]['title'],
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F4),
                borderRadius: const  BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: const Color(0xFF001A1A),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF008080),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    posteInfo[0]['description'],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F4),
                borderRadius: const  BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: const Color(0xFF001A1A),
                ),
              ),
              child: Text(
                "${posteInfo[0]['price']} DA",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F4),
                borderRadius: const  BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: const Color(0xFF001A1A),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.mapMarkerAlt,
                    color: Color(0xFF008080),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    posteInfo[0]['location'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
