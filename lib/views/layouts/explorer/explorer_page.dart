part of '../../pages.dart';

class ExplorerPage extends StatefulWidget {
  ExplorerPage({Key key}) : super(key: key);

  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  ScrollController _scrollController = new ScrollController();
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
                      return Column(
                        children: <Widget>[
                          getSearchBarUI(),
                        ],
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
              body: Container(
                color: AppTheme.getTheme().backgroundColor,
                child: GetBuilder<PackageController>(builder: (state) {
                  return ListView.builder(
                    itemCount: state.package.data.length,
                    padding: EdgeInsets.only(top: 8),
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
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().backgroundColor,
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SearchScreen(),
                      //       fullscreenDialog: true),
                      // );
                    },
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: AppTheme.getTheme().primaryColor,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: "London...",
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
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SearchScreen(),
                  //       fullscreenDialog: true),
                  // );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(La.search,
                      size: 20, color: AppTheme.getTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
