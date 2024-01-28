import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:selaa/functions.dart';
import 'package:selaa/seller/home_seller.dart';
import 'package:selaa/buyer/notification.dart';
import 'package:selaa/seller/product_page.dart';
import 'package:selaa/seller/user_page.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Map<String, dynamic>> userInfo = [];
  List<Map<String, dynamic>> shoppingCart = [];
  int totalPrice = 0;
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
    loadCartItems(context).then((List<Map<String, dynamic>> items) {
      setState(() {
        shoppingCart = items;
      });
    });
    calculateTotalPrice(context).then((int price) {
      setState(() {
        totalPrice = price;
      });
    });
    loadUserInfo(context).then((List<Map<String, dynamic>> info) {
      setState(() {
        userInfo = info;
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.15,
              margin: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 239, 239),
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        userInfo.isNotEmpty
                            ? "Credit : ${userInfo[0]['balance'].toString()} DZD"
                            : "Credit : N/A",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Total : "+totalPrice.toString()+" DZD",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width * 0.4,
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
                    child: const Text('Confirm Order'),
                    onPressed: () {
                      if(totalPrice>userInfo[0]['balance']){
                        QuickAlert.show(
                          context: context, 
                          type: QuickAlertType.error,
                          title: "Not enough credit",
                          text: "You don't have enough credit to confirm this order",
                        );
                      }else{
                        print(shoppingCart);
                      }
                    }
                  ),
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                itemCount: shoppingCart.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(productID: shoppingCart[index]['productDetails']['productID']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 230, 230),
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                            child: Image.network(
                              shoppingCart[index]['productDetails']['imageUrls'][0],
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              shoppingCart[index]['productDetails']["title"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              shoppingCart[index]['quantity'].toString(),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (index < shoppingCart.length) {
                                deleteItemFromCart(shoppingCart[index]['productDetails']['productID'],context);
                                setState(() {
                                  shoppingCart.removeAt(index);
                                  calculateTotalPrice(context).then((int price) {
                                    setState(() {
                                      totalPrice = price;
                                    });
                                  });
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
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
