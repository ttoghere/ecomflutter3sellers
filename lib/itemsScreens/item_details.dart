import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomflutter3sellers/global/global.dart';
import 'package:ecomflutter3sellers/models/items.dart';
import 'package:ecomflutter3sellers/splashScreen/my_splash_screen.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  Items? model;

  ItemDetails({
    this.model,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  deleteItem() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(widget.model!.brandID)
        .collection("items")
        .doc(widget.model!.itemID)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection("items")
          .doc(widget.model!.itemID)
          .delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Item Deleted Successfully.")));
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => SplashScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: boxDecoration,
        ),
        title: Text(
          widget.model!.itemTitle.toString(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.model!.thumbnailUrl.toString(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text(
              widget.model!.itemTitle.toString() + ":",
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.orange,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
            child: Text(
              widget.model!.longDescription.toString(),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.model!.price.toString() + " €",
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.orange,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 320.0),
            child: Divider(
              height: 1,
              thickness: 2,
              color: Colors.orange,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          deleteItem();
        },
        label: const Text("Delete this Item"),
        icon: const Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
