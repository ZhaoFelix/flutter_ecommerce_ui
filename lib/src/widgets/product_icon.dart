import 'package:flutter/material.dart';
import '../model/category.dart';
import '../themes/light_color.dart';
import '../themes/theme.dart';
import '../widgets/title_text.dart';

class ProductIcon extends StatelessWidget {
  final Category category;
  ProductIcon({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return category.id == null
        ? Container(width: 5)
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: category.isSelected
                    ? LightColor.background
                    : Colors.transparent,
                border: Border.all(
                  color:
                      category.isSelected ? LightColor.orange : LightColor.grey,
                  width: category.isSelected ? 2 : 1,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: category.isSelected
                          ? Color(0xfffbf2ef)
                          : Colors.white,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(5, 5))
                ]),
            child: Row(children: <Widget>[
              category.image != null ? Image.asset(category.image) : SizedBox(),
              category.name == null
                  ? Container()
                  : Container(
                      child: TitleText(
                      text: category.name,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ))
            ]),
          );
  }
}
