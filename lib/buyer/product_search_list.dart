import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';
import 'package:selaa/seller/product_page.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductSearchPageState createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<Map<String, dynamic>> _productList = [];

  void _performSearch(String query) {
    setState(() {
      _searchResults = _productList
          .where((product) =>
              product['title']
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              product['price']
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    loadAllPostes(context).then((List<Map<String, dynamic>> data) {
      setState(() {
        _productList = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF415B5B),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.06,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for a product',
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF415B5B),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF415B5B)),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onChanged: (query) {
                    _performSearch(query);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]['title']),
                  subtitle: Text(_searchResults[index]['price']+" DZ"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(productID: _searchResults[index]['productID'])));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
