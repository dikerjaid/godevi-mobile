part of '../../pages.dart';

class DetailPackage extends StatefulWidget {
  final PackageData packageData;
  DetailPackage({Key key, this.packageData}) : super(key: key);

  @override
  _DetailPackageState createState() => _DetailPackageState();
}

class _DetailPackageState extends State<DetailPackage>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  var hoteltext1 =
      "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum...";
  var hoteltext2 =
      "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum";
  bool isFav = false;
  bool isReadless = false;
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            controller: scrollController,
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: ContestTabHeaderDetail(
                    (MediaQuery.of(context).size.height),
                    widget.packageData,
                    () {
                      scrollController.animateTo(
                          MediaQuery.of(context).size.height -
                              MediaQuery.of(context).size.height / 5,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    },
                    getHotelDetails(),
                  ),
                ),
              ];
            },
            body: ListView(
              padding: EdgeInsets.only(top: 24),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: getHotelDetails(isInList: true),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Summary",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !isReadless ? hoteltext1 : hoteltext2,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTheme().disabledColor,
                          ),
                          recognizer: new TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless ? ' Read more' : " less",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTheme().primaryColor,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  child: RatingView(packageData: widget.packageData),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Photos",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'View all',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 38,
                                  width: 26,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GaleryPhotoList(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Reviews (8)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {
                            Get.to(ReviewsListScreen());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ReviewsListScreen(),
                            //       fullscreenDialog: true),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'View all',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 38,
                                  width: 26,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ReviewsView(
                  reviewsList: HotelListData.reviewsList[0],
                ),
                ReviewsView(
                  reviewsList: HotelListData.reviewsList[1],
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.asset(
                        "assets/images/mapImage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 34, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.getTheme().primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            La.map_pin,
                            color: AppTheme.getTheme().backgroundColor,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.getTheme().primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.getTheme().dividerColor,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => RoomBookingScreen(
                          //       hotelName: widget.hotelData.titleTxt,
                          //     ),
                          //     fullscreenDialog: true,
                          //   ),
                          // );
                        },
                        child: Center(
                          child: Text(
                            "Book now",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              height: AppBar().preferredSize.height,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: Container(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        decoration: BoxDecoration(
                            color: AppTheme.getTheme()
                                .disabledColor
                                .withOpacity(0.4),
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              if (scrollController.offset != 0.0) {
                                scrollController.animateTo(0.0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOutQuad);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back,
                                  color: AppTheme.getTheme().backgroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, right: 8),
                      child: Container(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        decoration: BoxDecoration(
                            color: AppTheme.getTheme().backgroundColor,
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppTheme.getTheme().primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelDetails({bool isInList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.packageData.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.white
                    // color: isInList
                    //     ? AppTheme.getTheme().textTheme.body1.color
                    //     : Colors.white,
                    ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   widget.ReviewsListScreen.subTxt,
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     color: isInList ? AppTheme.getTheme().disabledColor.withOpacity(0.5) : Colors.white,
                  //   ),
                  // ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    La.map_pin,
                    size: 12,
                    color: AppTheme.getTheme().primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.packageData.id.toStringAsFixed(1)} km to city",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: isInList
                            ? AppTheme.getTheme().disabledColor.withOpacity(0.5)
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              isInList
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          SmoothStarRating(
                            allowHalfRating: true,
                            starCount: 5,
                            rating: widget.packageData.id * 2.0,
                            size: 20,
                            color: AppTheme.getTheme().primaryColor,
                            borderColor: AppTheme.getTheme().primaryColor,
                          ),
                          Text(
                            " ${widget.packageData.review.length} Reviews",
                            style: TextStyle(
                              fontSize: 14,
                              color: isInList
                                  ? AppTheme.getTheme().disabledColor
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "\$${widget.packageData.price}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 22, color: Colors.white
                  // color: isInList
                  //     ? AppTheme.getTheme().textTheme.body1.color
                  //     : Colors.white,
                  ),
            ),
            Text(
              "/per night",
              style: TextStyle(
                fontSize: 14,
                color: isInList
                    ? AppTheme.getTheme().disabledColor.withOpacity(0.5)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContestTabHeaderDetail extends SliverPersistentHeaderDelegate {
  final Widget ui;
  final VoidCallback callback;
  final PackageData packageData;
  final double heightValue;
  ContestTabHeaderDetail(
    this.heightValue,
    this.packageData,
    this.callback,
    this.ui,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var minValue = (shrinkOffset < heightValue - heightValue / 5
        ? shrinkOffset
        : heightValue / 5);
    return Container(
      height: heightValue - minValue,
      decoration: BoxDecoration(
        color: AppTheme.getTheme().primaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getTheme().dividerColor,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                urlImage + '/packages/' + packageData.defaultImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: getOpValue(minValue, heightValue / 5),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      child: new BackdropFilter(
                        filter:
                            new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: Colors.black12,
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8),
                                child: ui,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16, top: 16),
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppTheme.getTheme().primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: AppTheme.getTheme().dividerColor,
                                        blurRadius: 8,
                                        offset: Offset(4, 4),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24.0)),
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => RoomBookingScreen(
                                        //       hotelName: hotelData.titleTxt,
                                        //     ),
                                        //     fullscreenDialog: true,
                                        //   ),
                                        // );
                                      },
                                      child: Center(
                                        child: Text(
                                          "Book now",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      child: new BackdropFilter(
                        filter:
                            new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: Colors.black12,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: AppTheme.getTheme()
                                  .primaryColor
                                  .withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(38)),
                              onTap: () {
                                try {
                                  callback();
                                } catch (e) {}
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 4, bottom: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'More Details',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  double getOpValue(double minValue, double maxValue) {
    var data = (1.0 - (minValue / maxValue));
    if (data < 0.0) {
      return 0.0;
    } else if (data >= 0 && data <= 1) {
      return data;
    } else {
      return 1.0;
    }
  }

  @override
  double get maxExtent => heightValue;

  @override
  double get minExtent => heightValue / 5;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
