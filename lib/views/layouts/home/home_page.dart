part of '../../pages.dart';

class HomePageScreen extends StatefulWidget {

  const HomePageScreen({Key key}) : super(key: key);
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  final _sliderController = Get.put(SliderController());
  final _villageController = Get.put(VillageController());
  final _packageController = Get.put(PackageController());

  @override
  void initState() {

    _sliderController.initData();
    _packageController.initData();
    _villageController.initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Container(
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
                    
                                if (index == 0) {
                                  return TitleView(
                                    titleTxt: 'Explore Village',
                                    subTxt: '',
                                  );
                                } else if (index == 1) {
                                  return Padding(
                                      padding:
                                          const EdgeInsets.only(top: 8),
                                      child: ExploreVillageWidget(
                                        callBack: (index) {},
                                      ));
                                } else if (index == 2) {
                                  return TitleView(
                                    titleTxt: 'Tour Packages',
                                    subTxt: 'View all',
                                    isLeftButton: true,
                                  );
                                } else {
                                  return TourPackageWidget();
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
