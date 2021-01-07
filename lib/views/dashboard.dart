part of 'pages.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with
        SingleTickerProviderStateMixin,
        WidgetsBindingObserver,
        TickerProviderStateMixin {
  // TabController controller;
  final _navController = Get.put(NavController());
  int index = 0, pageIndex = 0;
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Flutoast.toast('Tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: onWillPop, // prevent click back on device
      child: new Scaffold(
          backgroundColor: Color.fromRGBO(229, 232, 236, 1),
          body: GetBuilder<NavController>(builder: (n) {
            pageIndex = n.navIndex;
            return Stack(
                children: List<Widget>.generate(5, (int index) {
              return IgnorePointer(
                ignoring: index != pageIndex,
                child: Opacity(
                  opacity: pageIndex == index ? 1 : 0,
                  child: Navigator(
                    onGenerateRoute: (RouteSettings settings) {
                      return new MaterialPageRoute(
                        builder: (_) {
                          switch (index) {
                            case 0:
                              return HomePageScreen();
                              break;
                            case 1:
                              return ExplorerPage();
                              break;
                            case 2:
                              return Menu(index);
                              // return BlogPage();
                              break;
                            case 3:
                              // return Menu(index);
                              return CartPage();
                              break;
                            default:
                              return ProfileScreen();
                              // return Menu(index);
                              break;
                          }
                        },
                        settings: settings,
                      );
                    },
                  ),
                ),
              );
            })
                  ..addAll([
                    Navigation(pageIndex,
                        onTap: (i) => _navController.navigate(i)),
                    CenterButton(pageIndex,
                        onTap: (i) => _navController.navigate(i))
                  ]));
          })),
    );
  }
}

class Navigation extends StatelessWidget {
  final indexActive;
  final Function onTap;
  Navigation(this.indexActive, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
            clipper: BottomNavbarClipper(),
            child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (i) {
                      var _color =
                          i == indexActive ? Color(0xff4FBE9F) : Colors.grey;

                      List<String> labels = [
                        'Home',
                        'Explorer',
                        'Blog',
                        'Cart',
                        'Profile'
                      ];
                      List<String> icons = [
                        'home',
                        'discount',
                        'receipt',
                        'chat-typing',
                        'cog'
                      ];

                      return SplashButton(
                        onTap: i == 2
                            ? null
                            : () {
                                onTap(i);
                              },
                        child: Container(
                          width: Get.width / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                  icon: '${icons[i]}.svg',
                                  color: i == 2 ? Colors.transparent : _color),
                              SizedBox(height: 6),
                              Text(labels[i],
                                  style: gfont.copyWith(
                                      fontSize: 12, color: _color))
                            ],
                          ),
                        ),
                      );
                    })))));
  }
}

// class BNBCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = new Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     Path path = Path();
//     path.moveTo(0, 20); // Start
//     path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
//     path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
//     path.arcToPoint(Offset(size.width * 0.60, 20),
//         radius: Radius.circular(20.0), clockwise: false);
//     path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
//     path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(0, 20);
//     canvas.drawShadow(path, Colors.black, 5, true);
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

class BottomNavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double w = size.width / 2;

    path.moveTo(0, 0); // Start

    path.lineTo(w - 28, 0); // dimulai dari titik
    path.quadraticBezierTo(w - 23, 25, w, 25); // 33 -> radius kiri bawah
    path.quadraticBezierTo(w + 23, 25, w + 28, 0); // 33 -> radius kanan bawah
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  // path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
  //     path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
  //     path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
  //     path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
  //     path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Menu extends StatefulWidget {
  final int page;
  Menu(this.page);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Page ${widget.page + 1}',
                style: gfont.copyWith(fontSize: 25)),
            SizedBox(height: 10),
            // Text(lipsum.createWord(numWords: 5), style: gfont)
          ],
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  int navIndex = 0;

  void navigate(int i) {
    navIndex = i;
    update();
  }
}

class CenterButton extends StatelessWidget {
  final int index;
  final Function onTap;
  CenterButton(this.index, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 46,
        width: 46,
        margin: EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: radius50,
                gradient: LinearGradient(
                  colors: [Color(0xff04661d), Color(0xff0ac448)],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 0.8),
                  stops: [0.0, 1.0],
                ),
              ),
              child: SizedBox(
                height: 30,
                width: 23,
                child: SvgIcon(icon: 'receipt.svg', color: Colors.white),
              ),
            ),
            onPressed: () {
              // onTap(2);
              Get.to(BlogPage());
            }),
      ),
    );
  }
}
