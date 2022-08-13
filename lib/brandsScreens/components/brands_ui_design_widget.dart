import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomflutter3sellers/global/global.dart';
import 'package:ecomflutter3sellers/itemsScreens/items_screen.dart';
import 'package:ecomflutter3sellers/models/brands.dart';
import 'package:ecomflutter3sellers/splashScreen/my_splash_screen.dart';
import 'package:flutter/material.dart';

class BrandsUiDesignWidget extends StatefulWidget {
  Brands? model;
  BuildContext? context;

  BrandsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<BrandsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<BrandsUiDesignWidget> {
  deleteBrand(String brandUniqueID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(brandUniqueID)
        .delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Brand Deleted.")));
    Navigator.push(context, MaterialPageRoute(builder: (c) => SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ItemsScreen(
                  model: widget.model,
                )));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.brandTitle.toString(),
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteBrand(widget.model!.brandID.toString());
                      },
                      icon: const Icon(
                        Icons.delete_sweep,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
