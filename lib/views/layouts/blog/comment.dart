// part of '../../pages.dart';

// class ForumComment extends StatefulWidget {
//   final String id;
//   ForumComment(this.id);

//   @override
//   _ForumCommentState createState() => _ForumCommentState();
// }

// class _ForumCommentState extends State<ForumComment> {
//   String username, commendId, userSelected = '';
//   SlidableController _slidableController = SlidableController();
//   initialize() async {
//     AuthModel user =
//         AuthModel.fromJson(json.decode(await Storage.read('auth')));

//     username = user.email;
//   }

//   TextEditingController comment = TextEditingController();
//   FocusNode node = FocusNode();

//   Map<String, dynamic> replyToUser = {'reply': false, 'to': null};

//   bool isUpdate = false;

//   @override
//   void initState() {
//     super.initState();
//     initialize();
//   }

//   Future _comment(CreateCommentModel model) async {
//     if (comment.text.trim().isEmpty) {
//       NFocus.on(context, node);
//     } else {
//       model.setEdittingComment(isUpdate);

//       Component.spiner();
//       await model.addComment(widget.id,
//           comment: Comments(
//               comment: '$userSelected' + comment.text.trim(),
//               feedId: widget.id,
//               documentId: commendId ?? null),
//           replyToUser: replyToUser);
//       comment.clear();
//       commendId = null;
//       Navigator.pop(context);
//       NFocus.on(context, FocusNode());

//       setState(() => replyToUser['reply'] = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FocusOff(
//         child: CommentViewModel<CommentViewModel>.reactive(
//             viewModelBuilder: () => CommentViewModel(),
//             onModelReady: (model) => model.listenToComments(widget.id),
//             builder: (context, model, child) => Scaffold(
//                 appBar: Component.appBar(context,
//                     title: model.comments == null || model.comments.length == 0
//                         ? Text('Komentar',
//                             style: gfont.copyWith(fontSize: 20, height: .5))
//                         : Column(
//                             children: [
//                               Text('Komentar',
//                                   style: gfont.copyWith(
//                                       fontSize: 20, height: .5)),
//                               Text('${model.comments.length} komentar',
//                                   style: gfont.copyWith(
//                                       fontSize: 12, color: Colors.black54)),
//                             ],
//                           ),
//                     center: true,
//                     actions: [
//                       isUpdate
//                           ? IconButton(
//                               onPressed: () {
//                                 comment.clear();
//                                 NFocus.on(context, FocusNode());
//                                 setState(() => isUpdate = false);
//                               },
//                               icon: Icon(La.times,
//                                   size: 20, color: Colors.black54),
//                             )
//                           : SizedBox.shrink()
//                     ]),
//                 body: Stack(
//                   children: [
//                     !model.busy
//                         ? model.comments != null && model.comments.length > 0
//                             ? NotificationListener<ScrollNotification>(
//                                 child: ListView.builder(
//                                     padding: EdgeInsets.only(bottom: 80),
//                                     itemCount: model.comments.length + 1,
//                                     itemBuilder: (context, index) => Container(
//                                           child: index == model.comments.length
//                                               ? PaginateLoader(
//                                                   isLoading: model.busy)
//                                               : CommentsUi(
//                                                   slidableController:
//                                                       _slidableController,
//                                                   comment:
//                                                       model.comments[index],
//                                                   index: index,
//                                                   username: username,
//                                                   onEdit: (_) {
//                                                     comment.text = _.comment;
//                                                     comment.selection =
//                                                         TextSelection.fromPosition(
//                                                             TextPosition(
//                                                                 offset: comment
//                                                                     .text
//                                                                     .length));
//                                                     NFocus.on(context, node);
//                                                     SystemChannels.textInput
//                                                         .invokeMethod(
//                                                             'TextInput.show');
//                                                     commendId = _.documentId;
//                                                     setState(
//                                                         () => isUpdate = true);
//                                                   },
//                                                   onDelete: (_) {
//                                                     Popup.open(context,
//                                                         title: 'Hapus Komentar',
//                                                         subtitle:
//                                                             'Yakin ingin menghapus komentar ini?',
//                                                         type: PopType.danger,
//                                                         ok: (i) async {
//                                                       Component.showIndicator(
//                                                           context,
//                                                           then: (value) {
//                                                         if (value != null) {
//                                                           Flutoast.toast(
//                                                               'Berhasil dihapus');
//                                                         }
//                                                       });

//                                                       await ForumService
//                                                           .deleteComment(
//                                                               _.documentId,
//                                                               widget.id);
//                                                       Navigator.pop(
//                                                           context, true);
//                                                     });
//                                                   },
//                                                   onDoubleTap: model
//                                                               .comments[index]
//                                                               .username ==
//                                                           username
//                                                       ? null
//                                                       : (data) {
//                                                           replyToUser = {
//                                                             'reply': true,
//                                                             'to': data.username
//                                                                 .toString()
//                                                           };

//                                                           setState(() =>
//                                                               isUpdate = false);
//                                                           // comment.text = '@'+data.name+' ';
//                                                           userSelected = '@' +
//                                                               data.name
//                                                                   .toString() +
//                                                               ' ';
//                                                           comment.selection =
//                                                               TextSelection.fromPosition(
//                                                                   TextPosition(
//                                                                       offset: comment
//                                                                           .text
//                                                                           .length));
//                                                           NFocus.on(
//                                                               context, node);
//                                                           SystemChannels
//                                                               .textInput
//                                                               .invokeMethod(
//                                                                   'TextInput.show');
//                                                         },
//                                                 ),
//                                         )),
//                                 onNotification:
//                                     (ScrollNotification scrollInfo) {
//                                   if (scrollInfo.metrics.pixels >=
//                                           scrollInfo.metrics.maxScrollExtent &&
//                                       !scrollInfo.metrics.outOfRange) {
//                                     model.requestMoreComment(widget.id);
//                                   }

//                                   return true;
//                                 })
//                             : NoComments()
//                         : ForumSkeleton.feed(),
//                     Positioned.fill(
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             !replyToUser['reply']
//                                 ? SizedBox.shrink()
//                                 : SlideRight(
//                                     child: Container(
//                                       margin:
//                                           EdgeInsets.only(right: 10, left: 15),
//                                       decoration: BoxDecoration(
//                                         borderRadius: radius50,
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius: radius50,
//                                         child: Container(
//                                           padding: EdgeInsets.only(left: 10),
//                                           decoration: BoxDecoration(
//                                             color: Colors.blue,
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Flexible(
//                                                   child: Text('yrt',
//                                                       style: gfont.copyWith(
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                           color: Colors.white),
//                                                       overflow: TextOverflow
//                                                           .ellipsis)),
//                                               SizedBox(width: 7),
//                                               SplashButton(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 6, horizontal: 5),
//                                                 color: Colors.white
//                                                     .withOpacity(.1),
//                                                 onTap: () => setState(() =>
//                                                     replyToUser['reply'] =
//                                                         false),
//                                                 child: Icon(La.times,
//                                                     size: 15,
//                                                     color: Colors.white),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                             Container(
//                                 padding: EdgeInsets.all(15),
//                                 child: Container(
//                                     padding: EdgeInsets.only(left: 15),
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(50),
//                                         border: Border.all(
//                                             color: Color(0xffdddddd))),
//                                     child: ViewModelBuilder<
//                                         CreateCommentModel>.reactive(
//                                       viewModelBuilder: () =>
//                                           CreateCommentModel(),
//                                       // onModelReady: (model) {
//                                       //   model.setEdittingComment(isUpdate);
//                                       // },
//                                       builder: (context, commentModel, child) =>
//                                           Row(
//                                         children: [
//                                           Expanded(
//                                             child: TextInputTransparent(
//                                               hint: 'Ketik komentar',
//                                               controller: comment,
//                                               inputAction: TextInputAction.send,
//                                               node: node,
//                                               onSubmit: (String text) =>
//                                                   _comment(commentModel),
//                                             ),
//                                           ),
//                                           SplashButton(
//                                             onTap: () => _comment(commentModel),
//                                             padding: EdgeInsets.all(15),
//                                             radius: BorderRadius.circular(50),
//                                             child: Text(
//                                                 isUpdate ? 'Perbarui' : 'Kirim',
//                                                 style: gfont.copyWith(
//                                                     color: Colors.blue,
//                                                     letterSpacing: 1,
//                                                     fontWeight:
//                                                         FontWeight.bold)),
//                                           )
//                                         ],
//                                       ),
//                                     ))),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ))));
//   }
// }

// class NoComments extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 55),
//       child: Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Icon(La.comments, color: Colors.black38, size: 55),
//         SizedBox(height: 7),
//         Text('Tidak ada komentar apapun\nBerikan tanggapan untuk feed ini',
//             style: gfont.copyWith(color: Colors.black54),
//             textAlign: TextAlign.center),
//       ])),
//     );
//   }
// }

// class CommentsUi extends StatelessWidget {
//   final SlidableController slidableController;
//   final String username;
//   final Comment comment;
//   final int index;
//   final Function(Comment) onDoubleTap, onEdit, onDelete;
//   CommentsUi(
//       {@required this.slidableController,
//       this.username,
//       this.index,
//       this.comment,
//       this.onEdit,
//       this.onDelete,
//       this.onDoubleTap});

//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//         controller: slidableController,
//         actionPane: SlidableDrawerActionPane(),
//         actionExtentRatio: 0.18,
//         enabled: comment.username == username,
//         secondaryActions: <Widget>[
//           IconSlideAction(
//               color: Colors.transparent,
//               iconWidget: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration:
//                       BoxDecoration(color: Colors.blue, borderRadius: radius50),
//                   child: Icon(La.pen, color: Colors.white)),
//               onTap: () async {
//                 if (onEdit != null) onEdit(comment);
//               }),
//           IconSlideAction(
//               color: Colors.transparent,
//               iconWidget: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration:
//                       BoxDecoration(color: Colors.red, borderRadius: radius50),
//                   child: Icon(La.alternate_trash, color: Colors.white)),
//               onTap: () async {
//                 if (onDelete != null) onDelete(comment);
//               }),
//         ],
//         child: Container(
//             padding: EdgeInsets.only(left: 15, top: 15),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 33,
//                             width: 33,
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 7, horizontal: 11),
//                             decoration: BoxDecoration(
//                                 color: Color(0xffdddddd),
//                                 shape: BoxShape.circle),
//                             child: Text(
//                                 comment.name
//                                     .split('')[0]
//                                     .toString()
//                                     .toUpperCase(),
//                                 style: gfont.copyWith(
//                                     fontWeight: FontWeight.bold)),
//                           ),
//                           SizedBox(width: 10),
//                           Flexible(
//                             child: GestureDetector(
//                               onDoubleTap: () {
//                                 if (onDoubleTap != null) onDoubleTap(comment);
//                               },
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color:
//                                             Color(0xffdddddd).withOpacity(.5),
//                                         borderRadius:
//                                             BorderRadius.circular(15)),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Flexible(
//                                                 child: Text(comment.name,
//                                                     style: gfont.copyWith(
//                                                         fontWeight:
//                                                             FontWeight.bold))),
//                                             // Container(
//                                             //   margin: EdgeInsets.symmetric(horizontal: 5),
//                                             //   child: Text('•')
//                                             // ),

//                                             // Flexible(child: Text(Methods.timeAgo(comment.createdAt, fullText: true), style: gfont.copyWith(color: Colors.black45, fontSize: 13)))
//                                           ],
//                                         ),
//                                         Text(comment.comment ?? '',
//                                             style: gfont)
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                           Methods.timeAgo(comment.createdAt,
//                                               fullText: true),
//                                           style: gfont.copyWith(
//                                               color: Colors.black45,
//                                               fontSize: 12)),
//                                       SizedBox(width: 7),
//                                       comment.username == username
//                                           ? SizedBox.shrink()
//                                           : Text('•',
//                                               style: gfont.copyWith(
//                                                   color: Colors.black26)),
//                                       SizedBox(width: 7),
//                                       comment.username == username
//                                           ? SizedBox.shrink()
//                                           : GestureDetector(
//                                               onTap: () {
//                                                 if (onDoubleTap != null)
//                                                   onDoubleTap(comment);
//                                               },
//                                               child: Text('Balas',
//                                                   style: gfont.copyWith(
//                                                       fontSize: 12)),
//                                             )
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )));
//   }
// }

// class PaginateLoader extends StatelessWidget {
//   final bool isLoading;
//   PaginateLoader({this.isLoading: false});

//   @override
//   Widget build(BuildContext context) {
//     return !isLoading
//         ? SizedBox.shrink()
//         : Container(
//             height: 65,
//             width: 150,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(imageAsset + 'dot-loader.gif'))),
//           );
//   }
// }
