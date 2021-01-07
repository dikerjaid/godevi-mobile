part of '../../pages.dart';

class FavoritesListView extends StatefulWidget {
  const FavoritesListView({Key key}) : super(key: key);
  @override
  _FavoritesListViewState createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView> {
  PackageModels popularModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: popularModel.data.length,
        padding: EdgeInsets.only(top: 8, bottom: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return TourPackageListView(
            callback: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RoomBookingScreen(
              //       hotelName: popularModel.data[index].name,
              //     ),
              //   ),
              // );
            },
//            tourFavorite: popularModel.data[index],
          );
        },
      ),
    );
  }
}

class TourPackageListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;

  const TourPackageListView({Key key, this.callback, this.isShowDate: false})
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
              children: <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}
