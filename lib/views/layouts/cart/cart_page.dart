part of '../../pages.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    Key key,
  }) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  final _unpaidController = Get.put(CartController());

  Widget indexView = Container();
  TopBarType topBarType = TopBarType.Unpaid;
  @override
  void initState() {
    super.initState();
    _unpaidController.initData();
    indexView = UnpaidListView();
    topBarType = TopBarType.Unpaid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Container(child: appBar()),
        ),
        tabViewUI(topBarType),
        Expanded(
          child: indexView,
        ),
      ],
    );
  }

  void tabClick(TopBarType tabType) {
    if (tabType != topBarType) {
      topBarType = tabType;

      if (tabType == TopBarType.Unpaid) {
        setState(() {
          indexView = UnpaidListView();
        });
      } else if (tabType == TopBarType.Finished) {
        setState(() {
          indexView = FinishTripView();
        });
      } else if (tabType == TopBarType.Favorites) {
        setState(() {
          indexView = FavoritesListView();
        });
      }
    }
  }

  Widget tabViewUI(TopBarType tabType) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          color: AppTheme.getTheme().dividerColor.withOpacity(0.05),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      highlightColor: Colors.transparent,
                      splashColor:
                          AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        _unpaidController.initData();
                        tabClick(TopBarType.Unpaid);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16),
                        child: Center(
                          child: Text(
                            "Unpaid",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tabType == TopBarType.Unpaid
                                    ? AppTheme.getTheme().primaryColor
                                    : AppTheme.getTheme().disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      highlightColor: Colors.transparent,
                      splashColor:
                          AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(TopBarType.Finished);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16),
                        child: Center(
                          child: Text(
                            "Finished",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tabType == TopBarType.Finished
                                    ? AppTheme.getTheme().primaryColor
                                    : AppTheme.getTheme().disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      highlightColor: Colors.transparent,
                      splashColor:
                          AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(TopBarType.Favorites);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16),
                        child: Center(
                          child: Text(
                            "Favorites",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tabType == TopBarType.Favorites
                                    ? AppTheme.getTheme().primaryColor
                                    : AppTheme.getTheme().disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).padding.bottom,
            // )
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24 + 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Reservations",
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

enum TopBarType { Unpaid, Finished, Favorites }
