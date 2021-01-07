part of '../../pages.dart';

class TourPackageWidget extends StatefulWidget {
  final Function(int) callBack;

  const TourPackageWidget({Key key, this.callBack}) : super(key: key);
  @override
  _TourPackageWidgetState createState() => _TourPackageWidgetState();
}

class _TourPackageWidgetState extends State<TourPackageWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        builder: (state) => state.isLoading
            ? Component.spiner()
            : Container(
                padding: EdgeInsets.only(bottom: 50.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: state.package.data.length,
                  padding: const EdgeInsets.only(top: 8),
                  itemBuilder: (context, index) {
                    return PackageTourListView(
                      callback: () => Get.to(DetailPackage(
                          packageData: state.package.data[index])),
                      tourPackage: state.package.data[index],
                    );
                  },
                ),
              ));
  }
}

class PackageTourListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final PackageData tourPackage;

  const PackageTourListView(
      {Key key, this.tourPackage, this.callback, this.isShowDate: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getTheme().backgroundColor,
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
          child: AspectRatio(
            aspectRatio: 2.7,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 0.90,
                      child: Image.network(
                        urlImage + '/packages/' + tourPackage.defaultImg,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width >= 360 ? 12 : 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tourPackage.name,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
//                                    Text(
//                                      tourPackage.exclusion,
//                                      style: TextStyle(
//                                          fontSize: 14,
//                                          color: Colors.grey.withOpacity(0.8)),
//                                    ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              La.map,
                                              size: 12,
                                              color: AppTheme.getTheme()
                                                  .primaryColor,
                                            ),
                                            Text(
                                              " ${tourPackage.id.toStringAsFixed(1)} km to city",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey
                                                      .withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: SmoothStarRating(
                                            allowHalfRating: true,
                                            starCount: 5,
                                            rating: tourPackage.id.toDouble(),
                                            size: 20,
                                            color: AppTheme.getTheme()
                                                .primaryColor,
                                            borderColor: AppTheme.getTheme()
                                                .primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "\$${tourPackage.price}",
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
                                            color:
                                                Colors.grey.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor:
                        AppTheme.getTheme().primaryColor.withOpacity(0.1),
                    onTap: () {
                      try {
                        callback();
                      } catch (e) {}
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
