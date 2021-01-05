part of '../../pages.dart';

class PostScreen extends StatefulWidget {
  final DatumBlogs postData;
  PostScreen({Key key, @required this.postData}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Blog"),
        backgroundColor: AppTheme.primaryColors,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Get.to(ForumComment(widget.postData.id.toString()));
                },
                child: Icon(La.comment),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(La.share),
              )),
        ],
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: uri + "/blog-mobile/" + widget.postData.id.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (started) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      height: 123,
                      width: 123,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        '$assetImage/intro.gif',
                      ))),
                    ),
                  ),
                )
              : Stack()
        ],
      ),
    );
  }
}
