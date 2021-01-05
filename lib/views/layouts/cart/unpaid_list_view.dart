part of '../../pages.dart';

class UnpaidListView extends StatefulWidget {
  final AnimationController animationController;

  const UnpaidListView({Key key, this.animationController}) : super(key: key);
  @override
  _UnpaidListViewState createState() => _UnpaidListViewState();
}

class _UnpaidListViewState extends State<UnpaidListView> {
  final _cartController = Get.put(CartController());
  UnpaidModel unpaidModel;
  bool isLoading = true;

  getInistial() {}
  Future<void> _initializeSlider() async {
    unpaidModel = UnpaidModel.fromJson(await CartServices.getUnpaid());
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _initializeSlider();
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: isLoading == true ? 0 : unpaidModel.data.data.length,
        padding: EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var count = unpaidModel.data.data.length > 10
              ? 10
              : unpaidModel.data.data.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: widget.animationController,
              curve: Interval((1 / count) * index, 1.0,
                  curve: Curves.fastOutSlowIn)));
          widget.animationController.forward();
          return BookingListView(
            callback: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RoomBookingScreen(
              //       hotelName: hotelList[index].titleTxt,
              //     ),
              //   ),
              // );
            },
            unpaidData: unpaidModel.data.data[index],
            animation: animation,
            animationController: widget.animationController,
            isShowDate: true,
          );
        },
      ),
    );
  }
}

class BookingListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final DataUnpaid unpaidData;
  final AnimationController animationController;
  final Animation animation;

  const BookingListView(
      {Key key,
      this.unpaidData,
      this.animationController,
      this.animation,
      this.callback,
      this.isShowDate: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: Column(
                children: <Widget>[
                  isShowDate
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(
                            unpaidData.code +
                                " | " +
                                unpaidData.checkinDate.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        )
                      : SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.getTheme().dividerColor,
                          offset: Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 2,
                                child: Image.network(
                                  urlImage +
                                      "packages/" +
                                      unpaidData.package.defaultImg,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: AppTheme.getTheme().backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                unpaidData.package.name,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    unpaidData.villageName,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Icon(
                                                    La.map_marker,
                                                    size: 12,
                                                    color: AppTheme.getTheme()
                                                        .primaryColor,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${unpaidData.villageId} km to city",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Row(
                                                  children: <Widget>[
                                                    SmoothStarRating(
                                                      allowHalfRating: true,
                                                      starCount: 5,
                                                      rating: unpaidData
                                                          .villageId
                                                          .toDouble(),
                                                      size: 20,
                                                      color: AppTheme.getTheme()
                                                          .primaryColor,
                                                      borderColor:
                                                          AppTheme.getTheme()
                                                              .primaryColor,
                                                    ),
                                                    Text(
                                                      " ${unpaidData.package.review} Reviews",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, top: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "\$${unpaidData.totalPayment}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            "/per night",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey
                                                    .withOpacity(0.8)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: 0,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: AppTheme.getTheme()
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                onTap: () {
                                  try {
                                    callback();
                                  } catch (e) {}
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.getTheme().backgroundColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(32.0),
                                  ),
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          color:
                                              AppTheme.getTheme().primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text("Go To Pay"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
