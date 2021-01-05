part of '../../pages.dart';

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final double heightValue;
  ContestTabHeader(this.heightValue);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var minValue = (shrinkOffset < heightValue - heightValue / 3
        ? shrinkOffset
        : heightValue / 3);
    return SizedBox(
      height: heightValue - minValue,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: SliderHeaderWidget(
                opValue: getOpValue(minValue, heightValue / 3),
                click: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => HotelHomeScreen()),
                  // );
                },
              ),
              height: heightValue,
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
  double get minExtent => heightValue / 3;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class SliderHeaderWidget extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const SliderHeaderWidget({Key key, this.opValue = 0.0, this.click})
      : super(key: key);
  @override
  _SliderHeaderWidgetState createState() => _SliderHeaderWidgetState();
}

class _SliderHeaderWidgetState extends State<SliderHeaderWidget> {
  final _sliderController = Get.put(SliderController());
  bool isLoading = true;
  Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    super.initState();
    initTransisiSlider();
  }

  @override
  void dispose() {
    sliderTimer?.cancel();
    super.dispose();
  }

  initTransisiSlider() {
    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        _sliderController.pageController.animateTo(
            MediaQuery.of(context).size.width,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        _sliderController.pageController.animateTo(
            MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        _sliderController.pageController.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderController>(
        builder: (state) => state.isLoading
            ? Container(
                child: Center(child: RefreshProgressIndicator()),
              )
            : Stack(
                children: <Widget>[
                  PageView.builder(
                    controller: state.pageController,
                    pageSnapping: true,
                    onPageChanged: (index) {
                      currentShowIndex = index;
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: state.slider.data.length,
                    itemBuilder: (context, i) {
                      return PageSliderData(
                        imageData: state.slider.data[i],
                        opValue: widget.opValue,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 32,
                    right: 32,
                    child: PageIndicator(
                      layout: PageIndicatorLayout.WARM,
                      size: 10.0,
                      controller: state.pageController,
                      space: 5.0,
                      count: state.slider.data.length,
                      color: Colors.white,
                      activeColor: AppTheme.getTheme().primaryColor,
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    left: 24,
                    child: Opacity(
                      opacity: widget.opValue,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if (widget.opValue != 0) {
                                widget.click();
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 8),
                                child: Text(
                                  "View Hotels",
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
                    ),
                  )
                ],
              ));
  }
}

class PageSliderData extends StatelessWidget {
  final SliderData imageData;
  final double opValue;

  const PageSliderData({Key key, this.imageData, this.opValue: 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            urlImage + "sliders/" + imageData.img,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    imageData.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    imageData.desc,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
