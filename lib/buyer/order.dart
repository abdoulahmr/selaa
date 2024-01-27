import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaa/buyer/home_buyer.dart';
import 'package:selaa/buyer/notification.dart';
import 'package:selaa/seller/user_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Color latestButtonColor = const Color(0xFF008080);
  Color onProcessingButtonColor = const Color(0xFFF2F4F4);
  Color finishedOrderButtonColor = const Color(0xFFF2F4F4);
  Color latestButtonTextColor = Colors.white;
  Color onProcessingButtonTextColor = const Color(0xFF415B5B);
  Color finishedOrderButtonTextColor = const Color(0xFF415B5B);
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeBuyer(),
    const UserPage(),
    const NotificationPage(),
    const OrderPage(),
  ];

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
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 0;
                          latestButtonColor = const Color(0xFF008080);
                          onProcessingButtonColor = const Color(0xFFF2F4F4);
                          finishedOrderButtonColor = const Color(0xFFF2F4F4);
                          latestButtonTextColor = Colors.white;
                          onProcessingButtonTextColor = const Color(0xFF415B5B);
                          finishedOrderButtonTextColor = const Color(0xFF415B5B);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: latestButtonColor,
                        fixedSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Color(0xFF415B5B)),
                        ),
                      ),
                      child: Text(
                        "Latest",
                        style: TextStyle(color: latestButtonTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 1;
                          latestButtonColor = const Color(0xFFF2F4F4);
                          onProcessingButtonColor = const Color(0xFF008080);
                          finishedOrderButtonColor = const Color(0xFFF2F4F4);
                          latestButtonTextColor = const Color(0xFF415B5B);
                          onProcessingButtonTextColor = Colors.white;
                          finishedOrderButtonTextColor = const Color(0xFF415B5B);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: onProcessingButtonColor,
                        fixedSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Color(0xFF415B5B)),
                        ),
                      ),
                      child: Text(
                        "On Processing",
                        style: TextStyle(color: onProcessingButtonTextColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 2;
                          latestButtonColor = const Color(0xFFF2F4F4);
                          onProcessingButtonColor = const Color(0xFFF2F4F4);
                          finishedOrderButtonColor = const Color(0xFF008080);
                          latestButtonTextColor = const Color(0xFF415B5B);
                          onProcessingButtonTextColor = const Color(0xFF415B5B);
                          finishedOrderButtonTextColor = Colors.white;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: finishedOrderButtonColor,
                        fixedSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Color(0xFF415B5B)),
                        ),
                      ),
                      child: Text(
                        "Finished Order",
                        style: TextStyle(color: finishedOrderButtonTextColor),
                      ),
                    ),
                  ),
                ],
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
                Icons.notifications_active,
                size: 35,
              ),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.sort,
                size: 35,
              ),
              label: "Order",
            ),
          ],
        ),
      ),
    );
  }
}