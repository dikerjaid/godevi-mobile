part of '../../pages.dart';

class ReviewsListScreen extends StatefulWidget {
  @override
  _ReviewsListScreenState createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<ReviewsListScreen>
    with TickerProviderStateMixin {
  List<HotelListData> reviewsList = HotelListData.reviewsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(child: appBar()),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: 8, bottom: MediaQuery.of(context).padding.bottom + 8),
              itemCount: reviewsList.length,
              itemBuilder: (context, index) {
                return ReviewsView(
                  callback: () {},
                  reviewsList: reviewsList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            "Reviews (20)",
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewsView extends StatelessWidget {
  final VoidCallback callback;
  final HotelListData reviewsList;

  const ReviewsView({
    Key key,
    this.reviewsList,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.getTheme().primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppTheme.getTheme().dividerColor,
                        blurRadius: 8,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        reviewsList.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    reviewsList.titleTxt,
                    style: new TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    reviewsList.dateTxt,
                    style: new TextStyle(
                      fontWeight: FontWeight.w100,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "(${reviewsList.rating})",
                        style: new TextStyle(
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 5,
                        rating: reviewsList.rating / 2,
                        size: 16,
                        color: AppTheme.getTheme().primaryColor,
                        borderColor: AppTheme.getTheme().primaryColor,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              reviewsList.subTxt,
              style: new TextStyle(
                fontWeight: FontWeight.w100,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: <Widget>[
          //     Material(
          //       color: Colors.transparent,
          //       child: InkWell(
          //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
          //         onTap: () {},
          //         child: Padding(
          //           padding: const EdgeInsets.only(left: 8),
          //           child: Row(
          //             children: <Widget>[
          //               Text(
          //                 'Reply',
          //                 textAlign: TextAlign.left,
          //                 style: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 14,
          //                   color: AppTheme.getTheme().primaryColor,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 38,
          //                 width: 26,
          //                 child: Icon(
          //                   Icons.arrow_forward,
          //                   size: 14,
          //                   color: AppTheme.getTheme().primaryColor,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
