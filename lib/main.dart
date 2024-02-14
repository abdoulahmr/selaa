import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:selaa/buyer/home_buyer.dart';
import 'package:selaa/buyer/my_orders.dart';
import 'package:selaa/buyer/notification.dart';
import 'package:selaa/buyer/product_search_list.dart';
import 'package:selaa/buyer/shopping_cart.dart';
import 'package:selaa/register/choice_auth.dart';
import 'package:selaa/register/forget_password.dart';
import 'package:selaa/register/login.dart';
import 'package:selaa/register/redirect_login.dart';
import 'package:selaa/register/pre_register.dart';
import 'package:selaa/register/signup_buyer.dart';
import 'package:selaa/register/signup_seller.dart';
import 'package:selaa/seller/add_poste.dart';
import 'package:selaa/seller/edit_profile.dart';
import 'package:selaa/seller/home_seller.dart';
import 'package:selaa/seller/order.dart';
import 'package:selaa/seller/user_page.dart';
import 'package:selaa/settings/buyer_options_menu.dart';
import 'package:selaa/settings/change_password.dart';
import 'package:selaa/settings/phone_number.dart';
import 'package:selaa/settings/seller_option_menu.dart';
import 'package:selaa/settings/settings_list.dart';
import 'package:selaa/settings/shipping_adress.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/homeBuyer':(context) => const HomeBuyer(),
        '/myOrder':(context) => const MyOrdersPage(),
        '/notification':(context) => const NotificationPage(),
        '/productSearchList':(context) => const ProductSearchPage(),
        '/shoppingCart':(context) => const ShoppingCart(),
        '/choiceAuth':(context) => const ChoiceAuthPage(),
        '/forgetPassword':(context) => ForgotPasswordScreen(),
        '/login':(context) => Login(),
        '/preRegister':(context) => const PreRegister(),
        '/redirectLogin':(context) => const RedirectLogin(),
        '/signupBuyer':(context) => const SignUpBuyer(),
        '/signupSeller':(context) => const SignUpSeller(),
        '/addProduct':(context) => const AddPoste(),
        '/editProfile':(context) => const EditProfile(),
        '/homeSeller':(context) => const HomeSeller(),
        '/sellerOrders':(context) => const OrderPage(),
        '/sellerPage':(context) => const UserPage(),
        '/buyerOptionMenu':(context) => const BuyerOptionsMenu(),
        '/changePassword':(context) => ChangePasswordPage(),
        '/phoneNumber':(context) => const AddPhoneNumberPage(),
        '/sellerOptionMenu':(context) => const OptionsMenu(),
        '/settingsList':(context) => const SettingsList(),
        '/shippingAdress':(context) => const ShippingAddressPage()
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else {
            if (snapshot.hasData) {
              return const RedirectLogin();
            } else {
              return const PreRegister();
            }            
          }
        },
      ),
    );
  }
}