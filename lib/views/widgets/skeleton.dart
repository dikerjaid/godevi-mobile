part of 'widgets.dart';

class Skeleton extends StatelessWidget {
  final int length;

  Skeleton({this.length: 15});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 15,
      itemBuilder: (BuildContext context, i) => Container(
        margin: EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xfff1f1f1)))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [

                      Shimmer.fromColors(
                        baseColor: Colors.black26,
                        highlightColor: Colors.black12,
                        child: Container(
                          height: 33, width: 33,
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black26, 
                            shape: BoxShape.circle
                          ),
                        ),
                      ), SizedBox(width: 10),
                  
                      Shimmer.fromColors(
                        baseColor: Colors.black26,
                        highlightColor: Colors.black12,
                        child: Container(
                          width: Fn.doubleInRange(50, Get.width - 200), height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black26,
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(15),
              child: Shimmer.fromColors(
                baseColor: Colors.black26,
                highlightColor: Colors.black12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(2, (index) => Container(
                  margin: EdgeInsets.only(bottom: 5),
                  width: Fn.doubleInRange(50, Get.width - 50), height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black26,
                  )))
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}

class BarSkeleton extends StatelessWidget {
  final double width, height;
  final Color baseColor, hightLight;
  BarSkeleton({this.width: 50, this.height: 11, this.baseColor, this.hightLight});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.black26,
      highlightColor: hightLight ?? Colors.white,
      child: Container(
        height: height, width: width,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: radius50
        ),
      ),
    );
  }
}