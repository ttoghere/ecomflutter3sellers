import 'package:ecomflutter3sellers/components/my_drawer.dart';
import 'package:ecomflutter3sellers/global/global.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: boxDecoration
        ),
        title: const Text(
          "Ecom",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
