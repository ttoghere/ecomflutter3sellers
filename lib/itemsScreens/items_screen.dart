import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomflutter3sellers/global/global.dart';
import 'package:ecomflutter3sellers/itemsScreens/items_widget.dart';
import 'package:ecomflutter3sellers/itemsScreens/upload_items_screen.dart';
import 'package:ecomflutter3sellers/models/items.dart';
import 'package:flutter/material.dart';
import '../brandsScreens/components/brands_ui_design_widget.dart';
import '../brandsScreens/components/text_delegate_header.dart';
import '../models/brands.dart';

class ItemsScreen extends StatefulWidget {
  Brands? model;

  ItemsScreen({
    this.model,
  });

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => UploadItemsScreen(
                            model: widget.model,
                          )));
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("sellers")
              .doc(sharedPreferences!.getString("uid"))
              .collection("brands")
              .doc(widget.model!.brandID)
              .collection("items")
              .orderBy("publishedDate", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot dataSnapshot) {
            if (dataSnapshot.hasData) //if brands exists
            {
              //display brands
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (context, index) {
                  Items itemsModel = Items.fromJson(
                    dataSnapshot.data.docs[index].data()
                        as Map<String, dynamic>,
                  );

                  return ItemsWidget(
                    model: itemsModel,
                    context: context,
                  );
                },
                itemCount: dataSnapshot.data.docs.length,
              );
            } else //if brands NOT exists
            {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "No items exists",
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
