import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String shippingAdress = "";
  List<Map<String, dynamic>> items = [];
  @override
  void initState() {
    super.initState();
    loadUserShippingAddress(context).then((String data){
      shippingAdress = data;
    });
    loadOrderItems(context, widget.orderId).then((List<Map<String, dynamic>> data){
      setState(() {
        items = data;
      });
    });
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Container(
          margin: const EdgeInsets.all(30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Shipping to: ",
              style: TextStyle(
                fontSize: 25
              )  
            ),
            Text(
              items.isNotEmpty ? items[0]['date'] : 'No date available',
              style: const TextStyle(
                fontSize: 20
              ),
              ),
          ],
        ),
        Container(
          child: Column(
            children: [
              Text(items[0]["orderId"].toString()),
              Text(shippingAdress),
              Text(items[0]["status"].toString())
            ],
          ),
        ),
        Container(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Text(index.toString()),
                  Text(items[index]['productName']),
                  Text(items[index]['quantity']),
                  Text(items[index]['unitPrice'])
                ],
              );
            },
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: (){},
              child: Text("Track Order")
            ),
            ElevatedButton(
              onPressed: (){},
              child: Text("Repport")
            )
          ],
        )
      ],
    ),
  );
}

}