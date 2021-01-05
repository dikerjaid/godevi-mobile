part of '../../pages.dart';

class BlogPage extends StatefulWidget {
  BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final _blogController = Get.put(BlogController());
  @override
  void initState() {
    super.initState();
    getBlog();
  }

  getBlog() async {
    _blogController.setLoading(true);
    final response = await BlogServices.getBlogs(refresh: true);
    _blogController.setLoading(false);
    _blogController.initData(BlogModels.fromJson(response));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 50.0),
          child: CustomAppbar(
              child: Component.appBar(
            context,
            title: 'Blogs',
            color: Colors.white,
            leading: Icon(La.arrow_left, color: Colors.black),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: FlutterLogo(),
                ),
              )
            ],
          ))),
      body: GetBuilder<BlogController>(builder: (state) {
        return state.isLoading
            ? Component.spiner()
            : Container(
                color: Colors.grey[200],
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.blog.data.data.length,
                            itemBuilder: (context, i) => Column(
                              children: [
                                PostContainer(
                                    id: state.blog.data.data[i].id.toString(),
                                    author: state.blog.data.data[i].postAuthor
                                        .toString(),
                                    image: urlImage +
                                        "/blogs/" +
                                        state.blog.data.data[i].postThumbnail,
                                    title: state.blog.data.data[i].postTitle,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostScreen(
                                              postData:
                                                  state.blog.data.data[i]),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 10.0,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
