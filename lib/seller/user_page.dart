import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaa/backend-functions/load_data.dart';
import 'package:selaa/seller/add_poste.dart';
import 'package:selaa/seller/edit_profile.dart';
import 'package:selaa/seller/home_seller.dart';
import 'package:selaa/buyer/notification.dart';
import 'package:selaa/seller/product_page.dart';
import 'package:selaa/buyer/shopping_cart.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  List<Map<String, dynamic>> userInfo = [];
  List<Map<String, dynamic>> userPostes = [];
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeSeller(),
    const UserPage(),
    const NotificationPage(),
    const ShoppingCart(),
  ];

  @override
  void initState() {
    super.initState();
    loadUserInfo(context).then((List<Map<String, dynamic>> user) {
      setState(() {
        userInfo = user;
      });
    });
    loadUserPostes().then((List<Map<String, dynamic>> postes) {
      setState(() {
        userPostes = postes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: ()async{return false;},
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFCCE6E6),
                ),
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
                    if (userInfo.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                userInfo[0]['username'] as String,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: userInfo[0]['profilePicture'] != null
                                  ? NetworkImage(userInfo[0]['profilePicture'])
                                  : const NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/selaa-2ff93.appspot.com/o/profilePicture%2Fkisspng-computer-icons-download-avatar-5b3848b5343f86.741661901530415285214-removebg-preview%20(1).png?alt=media&token=0c01bbf5-f998-4ad9-af94-235ba6fd4ab5',
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (userInfo.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 40,bottom: 20),
                        child: Text(
                          userInfo[0]['bio'],
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    if (userInfo.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 10),
                                Text(
                                  userInfo[0]['address'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.phone),
                                const SizedBox(width: 10),
                                Text(
                                  userInfo[0]['phoneNumber'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.alternate_email_outlined),
                                const SizedBox(width: 10),
                                Text(
                                  userInfo[0]['email'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width*0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(
                            MediaQuery.of(context).size.width * 0.35,
                            MediaQuery.of(context).size.height * 0.06,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF008080)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(color: Color(0xFF415B5B)),
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPoste()));
                      }, 
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 10),
                          Text('Add'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(
                            MediaQuery.of(context).size.width * 0.35,
                            MediaQuery.of(context).size.height * 0.06,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF008080)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: const BorderSide(color: Color(0xFF415B5B)),
                          ),
                        ),
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                      }, 
                      child: const Row(
                        children: [
                          Icon(Icons.edit_square),
                          SizedBox(width: 10),
                          Text('Edit profile'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (userPostes.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userPostes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productID: userPostes[index]['productID'])));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Color(0xFFCCE6E6),
                                borderRadius: BorderRadius.all(Radius.circular(60.0)),
                              ),
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(45.0),
                                      topRight: Radius.circular(45.0),
                                    ),
                                    child: Image.network(
                                      userPostes[index]['imageUrls']?[0]?? 'fallback_url',
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    userPostes[index]['title'],
                                    textAlign: TextAlign.left,                                
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        userPostes[index]['categoryName'],
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${userPostes[index]['price']} DZD",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          );
                        },
                      ),
                    if (userPostes.isEmpty)
                      const Text('No posts available.'),
                  ],
                ),
              ),
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
                Icons.notifications_active,
                size: 35,
              ),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
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