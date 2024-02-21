import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:selaa/backend-functions/data_manipulation.dart';
import 'package:selaa/backend-functions/load_data.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String shippingAdress = "";
  String _status = "";
  bool _reqDel = false;
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    loadUserShippingAddress(context).then((String data){
      setState(() {
        shippingAdress = data;
      });
    });
    loadOrderItems(context, widget.orderId).then((List<Map<String, dynamic>> data){
      setState(() {
        items = data;
        _status = items[0]["status"];
        _reqDel = items[0]["delivery"];
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
              Expanded(
                child: Container(
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text(
                      "Shipping to: ",
                      style: TextStyle(
                        fontSize: 25
                      )  
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      items.isNotEmpty ? items[0]['date'] : 'No date available',
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFCCE6E6),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(shippingAdress),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(_status)
                      ],
                    ),
                    QrImageView(
                      data: widget.orderId,
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                )
              ),
              Expanded(   
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFCCE6E6),
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  index.toString(),
                                  style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                  )
                                )
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  items[index]['productName'],
                                  style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  items[index]['quantity'].toString(),
                                  style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                  )
                                )
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(
                                  "${items[index]['unitPrice']} DZD",
                                  style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                  )
                                )
                              )
                            ],
                          ),
                          const Divider()
                        ]
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(_reqDel==false){
                        addDeliveryForOrder(context, widget.orderId);
                      } else{
                        print("true");
                      }
                    },
                    style: ButtonStyle(
                      // fixedSize: MaterialStateProperty.all(
                      //   Size(MediaQuery.of(context).size.width*0.85, MediaQuery.of(context).size.height*0.06),
                      // ),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF008080)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Color(0xFF415B5B)),
                        ),
                      ),
                    ),
                    child: _reqDel
                      ? const Text("track order")
                      : const Text("Ask for delivery")
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: const Text("Repport")
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}