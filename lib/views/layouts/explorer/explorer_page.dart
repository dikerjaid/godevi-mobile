part of '../../pages.dart';

class ExplorerPage extends StatefulWidget {
  ExplorerPage({Key key}) : super(key: key);

  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  ScrollController _scrollController = new ScrollController();
  final _keywordController = new TextEditingController();
  final _packageController = new PackageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 50.0),
          child: CustomAppbar(
              child: Component.appBar(context,
                  title: 'Explorer',
                  color: Color(0xFFFFFFFF),
                  canBack: false))),
      body: Column(
        children: [
          Expanded(
            child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, top: 8, bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppTheme.getTheme().backgroundColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(38.0),
                                    ),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color:
                                              AppTheme.getTheme().dividerColor,
                                          offset: Offset(0, 2),
                                          blurRadius: 8.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 4, bottom: 4),
                                    child: TextField(
                                      controller: _keywordController,
                                      onChanged: (String txt) {
                                        _packageController.setLoading(true);
                                        _packageController.searchData(txt);
                                        print(txt);

                                        setState(() {});
                                      },
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                      cursorColor:
                                          AppTheme.getTheme().primaryColor,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search...",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppTheme.getTheme().primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(38.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AppTheme.getTheme().dividerColor,
                                      offset: Offset(0, 2),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  // borderRadius: BorderRadius.all(
                                  //   Radius.circular(32.0),
                                  // ),
                                  onTap: () {
                                    print("sadasd");

                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(La.search,
                                        size: 20,
                                        color: AppTheme.getTheme()
                                            .backgroundColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }, childCount: 1),
                  ),
                  // SliverPersistentHeader(
                  //   pinned: true,
                  //   floating: true,
                  //   delegate: ContestTabHeader(getFilterBarUI()),
                  // ),
                ];
              },
              body: Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    _packageController.searchData(_keywordController.text);
                  },
                  child: Container(
                    color: AppTheme.getTheme().backgroundColor,
                    child: GetBuilder<PackageController>(builder: (state) {
                      return state.isLoading
                          ? Component.spiner()
                          : ListView.builder(
                              itemCount: state.package.data.length,
                              padding: EdgeInsets.only(top: 8, bottom: 80.0),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return ListItemView(
                                  callback: () => Get.to(DetailPackage(
                                    packageData: state.package.data[index],
                                  )),
                                  packageData: state.package.data[index],
                                );
                              },
                            );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
