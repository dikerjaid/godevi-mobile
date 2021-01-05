part of 'widgets.dart';

class SplashButton extends StatelessWidget {
  SplashButton(
      {this.key,
      this.child,
      this.elevation: 0,
      this.onTap,
      this.onLongPress,
      this.padding,
      this.color,
      this.splash,
      this.highlightColor,
      this.radius,
      this.margin,
      this.shape,
      this.enableSplash: true,
      this.border});

  final Key key;
  final Widget child;
  final Function onTap;
  final Function onLongPress;
  final EdgeInsetsGeometry padding, margin;
  final Color color, splash, highlightColor;
  final BorderRadiusGeometry radius;
  final BoxBorder border;
  final double elevation;
  final ShapeBorder shape;
  final bool enableSplash;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      child: Material(
        key: key,
        elevation: elevation,
        color: color ?? Colors.transparent,
        // color: color == null ? Colors.transparent : color,
        borderRadius: radius,
        shape: shape,
        child: InkWell(
            onLongPress: onLongPress,
            splashColor: !enableSplash
                ? Colors.transparent
                : splash == null
                    ? Color.fromRGBO(0, 0, 0, .03)
                    : splash,
            highlightColor: !enableSplash
                ? Colors.transparent
                : highlightColor == null
                    ? Color.fromRGBO(0, 0, 0, .03)
                    : highlightColor,
            onTap: onTap,
            borderRadius: radius,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  border: border,
                  // color: color,
                ),
                padding: padding == null ? EdgeInsets.all(0) : padding,
                child: child)),
      ),
    );
  }
}

class SvgIcon extends StatelessWidget {
  final double size;
  final String icon;
  final Color color;

  SvgIcon({this.size: 17, @required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('$assetIcon/$icon',
        color: color, height: size, width: size);
  }
}

class FocusOff extends StatelessWidget {
  final Widget child;
  FocusOff({@required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Fn.focus(context, FocusNode());
      },
      child: child,
    );
  }
}

class FlipH extends StatelessWidget {
  final Widget icon;
  FlipH(this.icon);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: icon);
  }
}

enum TranzType { zoomIn, slideLeft, slideRight, slideUp, slideDown }

class Tranzition extends StatefulWidget {
  final Widget child;
  final TranzType type;
  final int delay;
  final double speed;

  Tranzition({this.child, this.type: TranzType.zoomIn, this.delay, this.speed});

  @override
  _TranzitionState createState() => _TranzitionState();
}

class _TranzitionState extends State<Tranzition>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AnimationController controller;
  Animation<double> scaleAnimation;

  AnimationController _animController;
  Animation<Offset> _animOffset;

  __run() {
    if (widget.type == TranzType.zoomIn) {
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 250));
      scaleAnimation =
          CurvedAnimation(parent: controller, curve: Curves.decelerate);
      controller.forward();
    } else {
      _animController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 300));
      final curve =
          CurvedAnimation(curve: Curves.decelerate, parent: _animController);

      switch (widget.type) {
        case TranzType.slideLeft:
          _animOffset =
              Tween<Offset>(begin: Offset(widget.speed, 0.0), end: Offset.zero)
                  .animate(curve);
          break;
        case TranzType.slideRight:
          _animOffset =
              Tween<Offset>(begin: Offset(-widget.speed, 0.0), end: Offset.zero)
                  .animate(curve);
          break;
        case TranzType.slideUp:
          _animOffset =
              Tween<Offset>(begin: Offset(0.0, widget.speed), end: Offset.zero)
                  .animate(curve);
          break;
        default:
          _animOffset =
              Tween<Offset>(begin: Offset(0.0, -widget.speed), end: Offset.zero)
                  .animate(curve);
          break;
      }

      widget.delay == null
          ? _animController.forward()
          : Timer(Duration(milliseconds: widget.delay), () {
              if (mounted) _animController.forward();
            });
    }
  }

  @override
  void initState() {
    super.initState();
    __run();
  }

  @override
  void dispose() {
    _animController?.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == TranzType.zoomIn
        ? ScaleTransition(
            key: _scaffoldKey, scale: scaleAnimation, child: widget.child)
        : FadeTransition(
            child: SlideTransition(position: _animOffset, child: widget.child),
            opacity: _animController);
  }
}

class ScrollConfig extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class PreventScrollGlow extends StatelessWidget {
  final Widget child;
  PreventScrollGlow({this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfig(),
      child: child,
    );
  }
}

class Component {
  static appBar(context,
      {Color color,
      title,
      bool center: false,
      canBack: true,
      double elevation: .5,
      double spacing: 0,
      Function onBack,
      List<Widget> actions: const [],
      Widget leading}) {
    return AppBar(
      backgroundColor: color ??= Colors.white,
      title: title is String
          ? Text(title,
              style: gfont.copyWith(fontSize: 20, color: Colors.black))
          : title,
      titleSpacing: !canBack ? NavigationToolbar.kMiddleSpacing : spacing,
      elevation: elevation,
      centerTitle: center,
      automaticallyImplyLeading: leading != null,
      leading: !canBack
          ? null
          : leading ??= IconButton(
              onPressed: () {
                if (onBack != null) {
                  onBack();
                } else {
                  Navigator.pop(context);
                }
              },
              icon: Icon(La.arrow_left, color: Colors.white)),
      actions: actions,
    );
  }

  static modal(context,
      {@required Widget child,
      bool wrap: true,
      double radius: 5,
      double height,
      Function then,
      Color backgroundColor}) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return !wrap
              ? Container(
                  margin: EdgeInsets.only(top: Screen.statusBar(context)),
                  height: height == null ? Screen.height(context) : height,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                      child: child))
              : ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  ),
                  child: Container(
                    color: backgroundColor ?? Colors.white,
                    child: Wrap(children: <Widget>[child]),
                  ),
                );
        }).then((value) {
      if (then != null) then(value);
    });
  }

  static spiner(
      {EdgeInsetsGeometry margin,
      Color color,
      double stroke: 2,
      double size: 18}) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: margin ??= EdgeInsets.all(0),
        child: SizedBox(
          child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation(color ??= Color(0xff4A44AC)),
              strokeWidth: stroke),
        ),
        height: size,
        width: size,
      ),
    ]));
  }

  static showIndicator(BuildContext context,
      {String message, bool dismiss: true, Function then}) async {
    showDialog(
        context: context,
        barrierDismissible: dismiss,
        builder: (_) => CenterDialog(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                        strokeWidth: 2),
                  ),
                  message == null
                      ? SizedBox.shrink()
                      : Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(message ?? '',
                              style: gfont.copyWith(color: Colors.white)))
                ],
              ),
            )).then((value) {
      if (then != null) then(value);
    });
  }

  static Widget noData({double size: 130, String message, Function onRefresh}) {
    Widget _noData = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('$assetImage/no-data.png')))),
          message == null
              ? SizedBox.shrink()
              : Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(message, style: gfont))
        ],
      ),
    );

    return onRefresh == null
        ? _noData
        : RefreshIndicator(
            onRefresh: onRefresh,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [_noData],
              ),
            ));
  }

  static confirm(BuildContext context,
      {String message, Function(int i) onTap}) {
    showDialog(
        context: Get.overlayContext,
        builder: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ConfirmationWidget(message: message, onTap: onTap)]));
  }
}

class ConfirmationWidget extends StatelessWidget {
  final Function(int i) onTap;
  final String message;

  ConfirmationWidget({this.onTap, this.message});

  @override
  Widget build(BuildContext context) {
    return Tranzition(
      child: Container(
        padding: EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: radius10,
          child: Material(
            color: Colors.transparent,
            child: Column(children: [
              Container(
                  padding: EdgeInsets.all(15),
                  width: Get.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(message ?? '-', style: gfont)),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                    children: List.generate(2, (i) {
                  List<String> labels = ['Batal', 'Ya'];

                  return SplashButton(
                      onTap: () {
                        Navigator.pop(context);
                        if (onTap != null) onTap(i);
                      },
                      color: i == 0 ? Color(0xfff1f1f1) : Colors.red[400],
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: (Get.width - 30) / 2,
                          child: Text(labels[i],
                              style: gfont.copyWith(
                                  color:
                                      i == 0 ? Colors.black87 : Colors.white),
                              textAlign: TextAlign.center)));
                })),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
