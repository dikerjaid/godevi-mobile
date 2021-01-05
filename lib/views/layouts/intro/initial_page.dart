part of '../../pages.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  _initialize() async {
    // Timer(Duration(seconds: 3), () {
    //   Fn.navigate(context, IntroductionScreen());
    // });

    String logged = await Storage.read('logged_at');
    Navigator.of(context).popUntil((route) => route.isFirst);

    if (logged != null) {
      Timer(Duration(seconds: 1), () => Get.to(DashboardPage()));
//          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Dashboard())));
    } else {
      Timer(Duration(seconds: 1), () => Get.to(IntroductionScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 123,
              width: 123,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('$assetImage/intro.gif'))),
            ),
            Text('Initialisasi, mohon menunggu...', style: gfont),
          ],
        ),
      ),
    );
  }
}
