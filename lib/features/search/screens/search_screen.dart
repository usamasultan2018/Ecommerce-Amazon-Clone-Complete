import 'package:complete_amazon_clone_flutter/features/home/widgets/address_box.dart';
import 'package:complete_amazon_clone_flutter/features/search/services/search_services.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/loader.dart';
import '../../../constant/global_variables.dart';
import '../../../models/product_model.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../widget/searched_product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;

  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel>? products;
  final SearchServices services = SearchServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchProducts();
  }

  fetchSearchProducts() async{
    products = await services.fetchSearchProducts(
        context: context,  searchQuery:widget.searchQuery);
    setState(() {

    });
  }
  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }

  Widget build(BuildContext context) {
   return   Scaffold(
   appBar:  AppBar(
       flexibleSpace: Container(
         decoration: const BoxDecoration(
           gradient: GlobalVariables.appBarGradient,
         ),
       ),
       title: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             child: Container(
                 margin: const EdgeInsets.only(left: 15),
                 child: Material(
                   borderRadius: BorderRadius.circular(7),
                   elevation: 1,
                   child: TextFormField(
                     onFieldSubmitted: navigateToSearchScreen,
                     decoration: InputDecoration(
                         filled: true,
                         hintText: 'Search',
                         fillColor: Colors.white,
                         contentPadding: const EdgeInsets.only(top: 10),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(7),
                           borderSide: BorderSide.none,
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(7),
                           borderSide: const BorderSide(color: Colors.black38,width: 1),
                         ),
                         prefixIcon: InkWell(
                           onTap: () {},
                           child: const Padding(
                             padding: EdgeInsets.only(left: 6),
                             child: Icon(Icons.search,size: 23,),
                           ),
                         )),
                   ),
                 )),
           ),
           Container(
             color: Colors.transparent,
             height: 42,
             margin: EdgeInsets.symmetric(horizontal: 10),
             child: Icon(Icons.mic,size: 25,),
           )
         ],
       ),
     ),
      body: products == null? const Loader():Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: products!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ProductDetailScreen.routeName,
                      arguments: products![index],
                    );
                  },
                  child: SearchedProduct(
                    product: products![index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
