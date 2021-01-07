part of '../../pages.dart';

class ExploreVillageWidget extends StatefulWidget {
  final Function(int) callBack;
  const ExploreVillageWidget({Key key, this.callBack})
      : super(key: key);
  @override
  _ExploreVillageWidgetState createState() => _ExploreVillageWidgetState();
}

class _ExploreVillageWidgetState extends State<ExploreVillageWidget>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {

        return Container(
          height: 180,
          width: double.infinity,
          child: GetBuilder<VillageController>(builder: (state) {
            return state.isLoading
                ? Component.spiner()
                : ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 24, left: 8),
                    itemCount: state.village.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryView(
                        imgUrl: state.village.data[index].avatar,
                        popularList:
                            state.village.data[index].villageDetail,
                        callback: () {
                          widget.callBack(index);
                        },
                      );
                    },
                  );
          }),
        );
      }
    
}

class CategoryView extends StatelessWidget {
  final VoidCallback callback;
  final VillageDetail popularList;
  final String imgUrl;

  const CategoryView(
      {Key key,
      this.popularList,
      this.callback,
      this.imgUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
        return InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            callback();
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16, bottom: 24, top: 16, right: 8),
            child: Container(
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
                    AspectRatio(
                      aspectRatio: 2,
                      child: Image.network(
                        urlImage + "users/" + imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppTheme.getTheme()
                                        .dividerColor
                                        .withOpacity(0.4),
                                    AppTheme.getTheme()
                                        .dividerColor
                                        .withOpacity(0.0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 32, top: 8),
                                child: Text(
                                  popularList.villageName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                    color:
                                        AppTheme.getTheme().backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
