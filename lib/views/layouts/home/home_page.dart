part of '../../pages.dart';

class HomePageScreen extends StatefulWidget {
  final AnimationController animationController;

  const HomePageScreen({Key key, this.animationController}) : super(key: key);
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  final _sliderController = Get.put(SliderController());
  final _villageController = Get.put(VillageController());
  final _packageController = Get.put(PackageController());
  AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    getSlider();
    getVillage();
    getPackagePopular();
    animationController..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  getSlider() async {
    _sliderController.setLoading(true);
    final response = await SliderServices.getSlider(refresh: true);
    _sliderController.setLoading(false);
    _sliderController.initData(SliderModel.fromJson(response));
  }

  getVillage() async {
    _villageController.setLoading(true);
    final response = await VillageServices.getVillage(refresh: true);
    _villageController.setLoading(false);
    _villageController.initData(VillageModel.fromJson(response));
  }

  getPackagePopular() async {
    _packageController.setLoading(true);
    final response = await PackageServices.getPopular(refresh: true);
    _packageController.setLoading(false);
    _packageController.initData(PackageModels.fromJson(response));
    return await PackageServices.getPopular(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animationController,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - animationController.value), 0.0),
            child: Container(
              child: Scaffold(
                backgroundColor: AppTheme.getTheme().backgroundColor,
                body: Stack(
                  children: <Widget>[
                    GetBuilder<SliderController>(builder: (state) {
                      return state.isLoading
                          ? Component.spiner()
                          : NestedScrollView(
                              headerSliverBuilder: (BuildContext context,
                                  bool innerBoxIsScrolled) {
                                return <Widget>[
                                  SliverPersistentHeader(
                                    pinned: true,
                                    floating: true,
                                    delegate:
                                        ContestTabHeader((Get.width * 1.3)),
                                  ),
                                ];
                              },
                              body: Container(
                                color: AppTheme.getTheme().backgroundColor,
                                child: ListView.builder(
                                  itemCount: 4,
                                  padding: EdgeInsets.only(top: 32, bottom: 16),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var count = 4;
                                    var animation =
                                        Tween(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                        parent: animationController,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn),
                                      ),
                                    );
                                    if (index == 0) {
                                      return TitleView(
                                        titleTxt: 'Explore Village',
                                        subTxt: '',
                                        animation: animation,
                                        animationController:
                                            animationController,
                                      );
                                    } else if (index == 1) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: ExploreVillageWidget(
                                            animationController:
                                                animationController,
                                            callBack: (index) {},
                                          ));
                                    } else if (index == 2) {
                                      return TitleView(
                                        titleTxt: 'Tour Packages',
                                        subTxt: 'View all',
                                        animation: animation,
                                        isLeftButton: true,
                                        animationController:
                                            animationController,
                                      );
                                    } else {
                                      return TourPackageWidget(
                                        animation: animation,
                                        animationController:
                                            widget.animationController,
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                    }),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [
                            AppTheme.getTheme()
                                .backgroundColor
                                .withOpacity(0.4),
                            AppTheme.getTheme()
                                .backgroundColor
                                .withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 0,
                      right: 0,
                      child: searchUI(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getTheme().backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          // border: Border.all(
          //   color: HexColor("#757575").withOpacity(0.6),
          // ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(38)),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                  // );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      La.search,
                      size: 18,
                      color: AppTheme.getTheme().primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        onTap: () {
                          //  Navigator.push(
                          //    context,
                          //    MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                          //  );
                        },
                        enabled: false,
                        onChanged: (String txt) {},
                        style: TextStyle(
                          fontSize: 16,
                          // color: AppTheme.dark_grey,
                        ),
                        cursorColor: AppTheme.getTheme().primaryColor,
                        decoration: new InputDecoration(
                          errorText: null,
                          border: InputBorder.none,
                          hintText: "Where are you going?",
                          hintStyle: TextStyle(
                              color: AppTheme.getTheme().disabledColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
