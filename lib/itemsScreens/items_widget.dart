import 'package:ecomflutter3sellers/models/items.dart';
import 'package:flutter/material.dart';


class ItemsWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsWidget({this.model, this.context,});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}




class _ItemsWidgetState extends State<ItemsWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        /*Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(
          model: widget.model,
        )));*/
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

                const SizedBox(height: 2,),

                Text(
                  widget.model!.itemTitle.toString(),
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 2,),

                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 4,),

                Text(
                  widget.model!.itemInfo.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
