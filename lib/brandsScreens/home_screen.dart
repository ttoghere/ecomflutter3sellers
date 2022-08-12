import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomflutter3sellers/brandsScreens/components/brands_ui_design_widget.dart';
import 'package:ecomflutter3sellers/brandsScreens/components/text_delegate_header.dart';
import 'package:ecomflutter3sellers/brandsScreens/upload_brands_screen.dart';
import 'package:ecomflutter3sellers/components/my_drawer.dart';
import 'package:ecomflutter3sellers/global/global.dart';
import 'package:ecomflutter3sellers/models/brands.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/brandshomescreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: boxDecoration,
        ),
        title: const Text(
          "Multi Vendor",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => UploadBrandsScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child:

            //1. write query
            //2  model
            //3. ui design widget

            Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: boxDecoration,
              child: Center(
                child: Text(
                  "My Brands",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white,fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("brands")
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot dataSnapshot) {
                if (dataSnapshot.hasData) //if brands exists
                {
                  //display brands
                  return SizedBox(
                    height: MediaQuery.of(context).size.height - 150,
                    width: double.infinity,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Brands brandsModel = Brands.fromJson(
                          dataSnapshot.data.docs[index].data()
                              as Map<String, dynamic>,
                        );
                        return BrandsUiDesignWidget(
                          model: brandsModel,
                          context: context,
                        );
                      },
                      itemCount: dataSnapshot.data.docs.length,
                    ),
                  );
                } else //if brands NOT exists
                {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "No brands exists",
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
