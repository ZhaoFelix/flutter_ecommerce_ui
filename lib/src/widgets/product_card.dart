import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui/src/widgets/title_text.dart';
import '../model/category.dart';
import '../model/product.dart';
import '../themes/light_color.dart';
import '../themes/theme.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  ProductCard({this.product});
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Product model;
  @override
  void initState() {
    // TODO: implement initState
    model = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail');
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
            color: LightColor.background,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10)
            ]),
        margin: EdgeInsets.symmetric(vertical: !model.isSelected ? 20 : 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(
                    model.isLiked ? Icons.favorite : Icons.favorite_border,
                    color:
                        model.isLiked ? LightColor.red : LightColor.iconColor),
                onPressed: () {
                  setState(() {
                    model.isLiked = !model.isLiked;
                  });
                },
              )),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: model.isSelected ? 15 : 0),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: LightColor.orange.withAlpha(40),
                    ),
                    Image.asset(model.image),
                  ],
                ),
                TitleText(
                    text: model.name, fontSize: model.isSelected ? 16 : 14),
                TitleText(
                  text: model.category,
                  fontSize: model.isSelected ? 14 : 12,
                  color: LightColor.orange,
                ),
                TitleText(
                    text: model.price.toString(),
                    fontSize: model.isSelected ? 18 : 16)
              ])
        ]),
      ),
    );
  }
}
