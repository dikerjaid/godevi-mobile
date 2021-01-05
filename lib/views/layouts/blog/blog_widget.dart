part of '../../pages.dart';

class PostContainer extends StatelessWidget {
  final onTap;
  final String title, author, image, id;

  const PostContainer(
      {Key key, this.onTap, this.title, this.author, this.image, this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var countLike = "";
    // ForumService.getLikeFeed(feedID: id, username: "adiyoga27new@gmail.com")
    //     .then((value) => countLike = value);

    print(countLike);
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          image == null
              ? SizedBox.shrink()
              : GestureDetector(
                  onTap: onTap,
                  child: Container(
                    child: FadeInImage.assetNetwork(
                      image: image,
                      placeholder: 'assets/images/no-image-l.png',
                    ),
                  ),
                ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8F8F9),
              ),
              padding: EdgeInsets.all(15),
              child: Text(title,
                  style: gfont.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon(Icons.linked_camera, size: 20, color: Colors.black),
                    Text(countLike.toString(),
                        style:
                            gfont.copyWith(color: Colors.black.withOpacity(1))),
                    Text('100 Share',
                        style:
                            gfont.copyWith(color: Colors.black.withOpacity(1)))
                  ],
                ),
                Divider(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      La.thumbs_up,
                      size: 22.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Like"),
                  ],
                ),
                SizedBox(
                  width: 25.0,
                ),
                Row(
                  children: [
                    Icon(
                      La.comment,
                      size: 22.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Comment"),
                  ],
                ),
                SizedBox(
                  width: 25.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.share,
                      size: 22.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text("Share"),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}

class OverlayedContainer extends StatelessWidget {
  final String title, image, author, authorAvatar;
  final onTap;

  const OverlayedContainer(
      {Key key,
      this.title,
      this.image,
      this.author,
      this.onTap,
      this.authorAvatar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 9.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          image: DecorationImage(
            image: NetworkImage(image),
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$title",
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.white),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.network(
                      "$authorAvatar",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  flex: 9,
                  child: Text(
                    "$author",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
