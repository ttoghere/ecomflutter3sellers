// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecomflutter3sellers/global/global.dart';
import 'package:flutter/material.dart';

class TextDelegateHeader extends SliverPersistentHeaderDelegate {
  String? title;
  TextDelegateHeader({
    this.title,
  });
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overLapsContent,
  ) {
    return InkWell(
      child: Container(
        decoration: boxDecoration,
        height: 82,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: InkWell(
          child: Text(
            title.toString(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              letterSpacing: 3,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
