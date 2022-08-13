import 'package:ecomflutter3sellers/global/global.dart';
import 'package:ecomflutter3sellers/itemsScreens/upload_items_screen.dart';
import 'package:flutter/material.dart';
import '../brandsScreens/components/text_delegate_header.dart';
import '../models/brands.dart';


class ItemsScreen extends StatefulWidget
{
  Brands? model;

  ItemsScreen({this.model,});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}



class _ItemsScreenState extends State<ItemsScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: boxDecoration,
        ),
        title: const Text(
          "Ecom",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> UploadItemsScreen(
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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeader(title: "My ${widget.model!.brandTitle}'s Items"),
          ),
        ],
      ),
    );
  }
}
