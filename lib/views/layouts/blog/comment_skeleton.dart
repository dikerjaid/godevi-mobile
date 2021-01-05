part of '../../pages.dart';

class ForumSkeleton {
  static Widget feed() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 15,
        itemBuilder: (BuildContext context, i) => Container(
              margin: EdgeInsets.only(bottom: 7),
              decoration: BoxDecoration(color: Colors.white),
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
                                height: 33,
                                width: 33,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle),
                              ),
                            ),
                            SizedBox(width: 10),
                            Shimmer.fromColors(
                                baseColor: Colors.black26,
                                highlightColor: Colors.black12,
                                child: Container(
                                  width: Fn.doubleInRange(
                                      130, Get.width - 300),
                                  height: 12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black26,
                                  ),
                                )),
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(La.ellipsis_h,
                                color: Colors.black26)),
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
                            children: List.generate(
                                2,
                                (index) => Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    width:
                                        Fn.doubleInRange(200, Get.width),
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black26,
                                    ))))),
                  ),
                ],
              ),
            ));
  }
}
