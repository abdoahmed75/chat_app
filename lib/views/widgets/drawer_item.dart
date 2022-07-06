import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_text.dart';

class DrawerItem extends StatelessWidget {
  final String nameItem;
  final double size;
  final Function action;
  final bool needDivider;

  const DrawerItem(
      {required this.nameItem,
      required this.action,
      this.size = 22.0,
      this.needDivider = true});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var scaleFactor=MediaQuery.of(context).textScaleFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            action();
          },
          child: ListTile(
            dense: true,
            title: Padding(
              padding: const EdgeInsets.only(left: .05,right: 15),
              child: CustomText(
                text: nameItem,
                fontSize: w*.05,
                color: Colors.white,
              ),
            ),

          ),
        ),
        needDivider
            ? Container(
                width: 200,
                child: Divider(
                  color: Colors.white,
                  height: h*.04,
                  thickness: 0.2,
                ),
                margin: EdgeInsets.only(bottom: 2, right: 14, left: 14),
              )
            : SizedBox()
      ],
    );
  }
}
