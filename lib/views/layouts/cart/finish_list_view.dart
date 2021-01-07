part of '../../pages.dart';

class FinishTripView extends StatefulWidget {
  const FinishTripView({Key key}) : super(key: key);

  @override
  _FinishTripViewState createState() => _FinishTripViewState();
}

class _FinishTripViewState extends State<FinishTripView> {
  var hotelList = HotelListData.hotelList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: hotelList.length,
        padding: EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
      
          return HotelListView(
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
            hotelData: hotelList[index],
            isShowDate: (index % 2) != 0,
          );
        },
      ),
    );
  }
}

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;

  const HotelListView(
      {Key key,
      this.hotelData,
      this.callback,
      this.isShowDate: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            onTap: () {
              try {
                callback();
              } catch (e) {}
            },
            child: Row(
              children: <Widget>[
                isShowDate ? getUI(context) : SizedBox(),
                Container(
                  height: 150,
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
                      aspectRatio: 1.0,
                      child: Image.asset(
                        hotelData.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                !isShowDate ? getUI(context) : SizedBox(),
              ],
            ),
          ),
        );
      
  }

  Widget getUI(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        padding: EdgeInsets.only(
            left: !isShowDate ? 16 : 8,
            top: 8,
            bottom: 8,
            right: isShowDate ? 16 : 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isShowDate ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              hotelData.titleTxt,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData.subTxt,
              style:
                  TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
            ),
            Text(
              hotelData.dateTxt,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData.roomSizeTxt,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment:
                  isShowDate ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  La.map_marker,
                  size: 12,
                  color: AppTheme.getTheme().primaryColor,
                ),
                Text(
                  " ${hotelData.dist.toStringAsFixed(1)} km to city",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: hotelData.rating,
                size: 20,
                color: AppTheme.getTheme().primaryColor,
                borderColor: AppTheme.getTheme().primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment:
                  isShowDate ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "\$${hotelData.perNight}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    "/per night",
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
