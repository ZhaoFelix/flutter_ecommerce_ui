import 'package:flutter/material.dart';
import '../../themes/light_color.dart';
import 'bottom_curved_painter.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final Function(int) onIconPressedCallback;
  CustomBottomNavigationBar({this.onIconPressedCallback});
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController _xController;
  AnimationController _yController;
  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    final inCurve = ElasticInCurve(0.38);
    return CustomPaint(
      painter: BackGroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          Theme.of(context).backgroundColor),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width > 400.0) {
      width = 400;
    }
    return width;
  }

  Widget _icon(IconData icon, bool isEnable, int index) {
    return Expanded(
        child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      onTap: () {
        _handlePress(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        alignment: isEnable ? Alignment.topCenter : Alignment.center,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: isEnable ? 40 : 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isEnable ? LightColor.orange : Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: isEnable ? Color(0xfffeece2) : Colors.white,
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(5, 5),
                )
              ],
              shape: BoxShape.circle),
          child: Opacity(
            opacity: isEnable ? _yController.value : 1,
            child: Icon(icon,
                color: isEnable
                    ? LightColor.background
                    : Theme.of(context).iconTheme.color),
          ),
        ),
      ),
    ));
  }

  void _handlePress(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    widget.onIconPressedCallback(index);
    setState(() {
      _selectedIndex = index;
    });
    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 620));
    Future.delayed(Duration(milliseconds: 500), () {
      _yController.animateTo(1.0, duration: Duration(milliseconds: 1200));
    });
    _yController.animateTo(0.0, duration: Duration(milliseconds: 300));
  }

  double _indexToPosition(int index) {
    const buttonCount = 4.0;
    final appWidth = MediaQuery.of(context).size.width;
    final buttonWidth = _getButtonContainerWidth();
    final startX = (appWidth - buttonWidth) / 2;
    return startX +
        index.toDouble() * buttonWidth / buttonCount +
        buttonWidth / (buttonCount * 2.0);
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height = 60.0;
    return Container(
      width: appSize.width,
      height: 60,
      child: Stack(children: [
        Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground()),
        Positioned(
            left: (appSize.width - _getButtonContainerWidth()) / 2,
            top: 0,
            width: _getButtonContainerWidth(),
            height: height,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _icon(Icons.home, _selectedIndex == 0, 0),
                  _icon(Icons.search, _selectedIndex == 1, 1),
                  _icon(Icons.card_travel, _selectedIndex == 2, 2),
                  _icon(Icons.favorite_border, _selectedIndex == 3, 3)
                ]))
      ]),
    );
  }
}
