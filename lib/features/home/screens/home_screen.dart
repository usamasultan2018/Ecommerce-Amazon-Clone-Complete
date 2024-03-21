import 'package:complete_amazon_clone_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constant/global_variables.dart';
import '../../search/screens/search_screen.dart';
import '../widgets/address_box.dart';
import '../widgets/carousel_image.dart';
import '../widgets/deal_of_day.dart';
import '../widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
      ),
      body:SingleChildScrollView(
    child: Column(
    children: const [
    AddressBox(),
    SizedBox(height: 10),
    TopCategories(),
    SizedBox(height: 10),
    CarouselImage(),
    DealOfDay(),
    ],
    ),
      ),
    );
  }
}
