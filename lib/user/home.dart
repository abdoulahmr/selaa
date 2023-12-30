import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:selaa/functions.dart';
import 'package:selaa/user/notification.dart';
import 'package:selaa/user/product_page.dart';
import 'package:selaa/user/shopping_cart.dart';
import 'package:selaa/user/user_page.dart';
import 'options_menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String profilePicture = '';
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Home(),
    const UserPage(),
    const NotificationPage(),
    const ShoppingCart(),
  ];

  List<Map<String, dynamic>> postes = [];

  Future<void> loadProfilePicture() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        setState(() {
          profilePicture = data?['profilePicture'] ?? '';
        });
      } else {
        // Handle case when snapshot doesn't exist
      }
    } else {
      // Handle case when user is null
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfilePicture();
    loadAllPostes().then((List<Map<String, dynamic>> data) {
      setState(() {
        postes = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        fixedSize: MaterialStateProperty.all(
                          Size(
                            MediaQuery.of(context).size.width * 0.04,
                            MediaQuery.of(context).size.height * 0.05,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF008080)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Color(0xFF415B5B)),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const OptionsMenu()));
                      },
                      child: const Icon(Icons.menu),
                    ),
                    const Image(
                      image: AssetImage(
                        'assets/images/2-removebg-preview-removebg-preview.png',
                      ),
                      width: 120,
                      height: 120,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: profilePicture.isNotEmpty
                              ? NetworkImage(profilePicture)
                              : const NetworkImage('https://firebasestorage.googleapis.com/v0/b/selaa-2ff93.appspot.com/o/profilePicture%2Fkisspng-computer-icons-download-avatar-5b3848b5343f86.741661901530415285214-removebg-preview%20(1).png?alt=media&token=0c01bbf5-f998-4ad9-af94-235ba6fd4ab5'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 199, 199, 199),
                ),
                child: const Text(
                  "ADS SPACE",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Electronics");
                                    },
                                    icon : Icon(Icons.devices),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "Electronics",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Fashion");
                                    },
                                    icon: Icon(Icons.checkroom),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "Fashion",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Furniture");
                                    },
                                    icon : Icon(Icons.chair_outlined),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "Furniture",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Sport");
                                    },
                                    icon: Icon(Icons.sports_basketball_outlined),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "sport",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("toys");
                                    },
                                    icon: Icon(Icons.smart_toy_outlined),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "Toys",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Food");
                                    },
                                    icon: Icon(Icons.fastfood_outlined),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "Food",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /6,
                                height: MediaQuery.of(context).size.height / 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFCCE6E6),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      print("Books");
                                    },
                                    icon: Icon(Icons.book_online_outlined),
                                    iconSize: 30,
                                    color: Color(0xFF008080),
                                  ),
                                ),
                              ),
                              const Text(
                                "Books",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width /6,
                          height: MediaQuery.of(context).size.height / 15,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                print(postes);
                              },
                              child: const Text(
                                "See More",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF008080),
                                ),
                              ),
                            ),
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left:10),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (postes.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * 2;
                    int endIndex = startIndex + 1;
                    if (endIndex >= postes.length) {
                      endIndex = postes.length - 1;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productID: postes[index]['productID'])));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFCCE6E6),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                            width: MediaQuery.of(context).size.width*0.45,
                            height: MediaQuery.of(context).size.height*0.35,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                  child: Image.network(
                                    postes[startIndex]['imageUrls'][0],
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    postes[startIndex]['title'],
                                    textAlign: TextAlign.left,                                
                                    style: const TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.03,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    postes[startIndex]['price']+" DZ",
                                    textAlign: TextAlign.center,                                
                                    style: const TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productID: postes[endIndex]['productID'])));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFCCE6E6),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                            width: MediaQuery.of(context).size.width*0.45,
                            height: MediaQuery.of(context).size.height*0.35,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(25.0),
                                    topRight: Radius.circular(25.0),
                                  ),
                                  child: Image.network(
                                    postes[endIndex]['imageUrls'][0],
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.07,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    postes[endIndex]['title'],
                                    textAlign: TextAlign.left,                                
                                    style: const TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.03,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    postes[endIndex]['price']+" DZ",
                                    textAlign: TextAlign.center,                                
                                    style: const TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFFCCE6E6),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF008080),
          unselectedItemColor: const Color(0xFF008080),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _pages[index]),
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 35,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 35,
              ),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 35,
              ),
              label: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}