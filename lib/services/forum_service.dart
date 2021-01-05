// part of 'services.dart';

// class ForumService {
//   final CollectionReference _feedCollection =
//       FirebaseFirestore.instance.collection('feeds');
//   final CollectionReference _commentCollection =
//       FirebaseFirestore.instance.collection('feed_comments');
//   final CollectionReference _notifReference =
//       FirebaseFirestore.instance.collection('notifications');

//   final StreamController<List<Feeds>> _feedsController =
//       StreamController<List<Feeds>>.broadcast();
//   final StreamController<List<Comments>> _commentsController =
//       StreamController<List<Comments>>.broadcast();

//   // #6: Create a list that will keep the paged results
//   List<List<Feeds>> _allFeedPagedResults = List<List<Feeds>>();
//   List<List<Comments>> _allCommentPagedResults = List<List<Comments>>();

//   static const int FeedsLimit = 15;
//   DocumentSnapshot _lastFeedDocument, _lastCommentDocument;
//   bool _hasMoreFeeds = true, _hasMoreComments = true;

//   Stream listenToFeedsRealTime({bool listenUserLogged: false}) {
//     _requestFeeds(listenUserLogged: listenUserLogged);
//     return _feedsController.stream;
//   }

//   // fungsi untuk request data ke firestore,
//   // pada fungsi ini terdapat parameter listenUserLogged dengan nilai default = false
//   // dibuat demikian karena fungsi ini digunakan di dua tempat yang berbeda dan dengan tujuan yang berbeda
//   // listenUserLogged = false untuk get semua postingan, sedangkan listenUserLogged = true untuk get postingan user yang login saja

//   void _requestFeeds({bool listenUserLogged: false}) async {
//     // get data user yang login
//     var auth = await Methods.getPref('auth');
//     UserModel user = userModelFromJson(auth);

//     // siapkan query firestore
//     Query pageFeedsQuery = listenUserLogged
//         ? _feedCollection
//             .where('username', isEqualTo: user.data.email)
//             .orderBy('created_at', descending: true)
//             .limit(FeedsLimit)
//         : _feedCollection
//             .orderBy('created_at', descending: true)
//             .limit(FeedsLimit);

//     // jika _lastFeedDocument berisi data (terakhir), tambahkan query startAfterDocument dengan nilai dokumen terakhir yang terisi
//     if (_lastFeedDocument != null) {
//       pageFeedsQuery = pageFeedsQuery.startAfterDocument(_lastFeedDocument);
//     }

//     if (!_hasMoreFeeds) return;

//     // get dan simpan page index (_allFeedPagedResults.length = jumlah data saat ini yang sudah ke-load)
//     var currentRequestIndex = _allFeedPagedResults.length;

//     // listen query agar mendapat perubahan secara realtime
//     pageFeedsQuery.snapshots().listen((feedsSnapshot) {
//       if (feedsSnapshot.docs.isNotEmpty) {
//         List<Feeds> feeds = feedsSnapshot.docs
//             .map((snapshot) => Feeds.fromMap(snapshot.data(), snapshot.id))
//             .toList();

//         // set pageExists true / false
//         bool pageExists = currentRequestIndex < _allFeedPagedResults.length;

//         // jika pageExists = true, replace data _allFeedPagedResults by index = feeds (dengan kata lain ini adalah realtime untuk update)
//         if (pageExists) {
//           _allFeedPagedResults[currentRequestIndex] = feeds;
//         }

//         // jika pageExists = false, tambahkan feeds, (dan ini adalah realtime untuk add)
//         else {
//           _allFeedPagedResults.add(feeds);
//         }

//         // concatenate the full list to be shown
//         List<Feeds> allPosts = _allFeedPagedResults.fold<List<Feeds>>(
//             List<Feeds>(),
//             (initialValue, pageItems) => initialValue..addAll(pageItems));

//         // broadcase all feeds
//         _feedsController.add(allPosts);

//         // save the last document from the results only if it's the current last page
//         if (currentRequestIndex == _allFeedPagedResults.length - 1) {
//           _lastFeedDocument = feedsSnapshot.docs.last;
//         }

//         // determine if there's more feeds to request
//         _hasMoreFeeds = (feeds.length == FeedsLimit);
//       } else {
//         // jika data kosong maka set nilai _feedsController = [],
//         // disini terdapat masalah yaitu, saat more request (paginate) dan data sudah ke-load semua sehingga tidak ada lagi data yang didapat maka _feedsController ke-set = []
//         // sehingga list data yang tadinya terisi menjadi kosong, solusinya adalah set _feedsController = [] saat tidak ada dokumen apapun yang ke-load
//         // dengan kata lain, jika sudah ada data yang ke-load (tampil di list), kemudian dilakukan more request (paginate) dan hasilnya kosong, jangan set _feedsController = []

//         if (_lastFeedDocument == null) _feedsController.add([]);
//       }
//     });
//   }

//   void requestMoreData({bool listenUserLogged: false}) =>
//       _requestFeeds(listenUserLogged: listenUserLogged);

//   Future addFeed(Feeds feed) async {
//     try {
//       await _feedCollection.add(feed.toMap());
//     } catch (e) {
//       return e is PlatformException ? e.message : e.toString();
//     }
//   }

//   Future updateFeed(Feeds feed) async {
//     try {
//       await _feedCollection.doc(feed.documentId).update(feed.toMapOnly());
//     } catch (e) {
//       return e is PlatformException ? e.message : e.toString();
//     }
//   }

//   // COMMENTS ===

//   Stream listenToCommentsRealTime(String id) {
//     _requestComments(id);
//     return _commentsController.stream;
//   }

//   void _requestComments(String id) {
//     var pageCommentsQuery = _commentCollection
//         .where('feed_id', isEqualTo: id)
//         .orderBy('created_at', descending: true)
//         .limit(FeedsLimit);

//     if (_lastCommentDocument != null) {
//       pageCommentsQuery =
//           pageCommentsQuery.startAfterDocument(_lastCommentDocument);
//     }

//     if (!_hasMoreComments) return;

//     var currentRequestIndex = _allCommentPagedResults.length;

//     pageCommentsQuery.snapshots().listen((snapshot) {
//       if (snapshot.docs.isNotEmpty) {
//         var comments = snapshot.docs
//             .map((snapshot) => Comments.fromMap(snapshot.data(), snapshot.id))
//             .toList();

//         var pageExists = currentRequestIndex < _allCommentPagedResults.length;

//         pageExists
//             ? _allCommentPagedResults[currentRequestIndex] = comments
//             : _allCommentPagedResults.add(comments);

//         var allPosts = _allCommentPagedResults.fold<List<Comments>>(
//             List<Comments>(),
//             (initialValue, pageItems) => initialValue..addAll(pageItems));

//         _commentsController.add(allPosts);

//         if (currentRequestIndex == _allCommentPagedResults.length - 1) {
//           _lastCommentDocument = snapshot.docs.last;
//         }

//         _hasMoreComments = comments.length == FeedsLimit;
//       } else {
//         if (_lastCommentDocument == null) _commentsController.add([]);
//       }
//     });
//   }

//   void requestMoreComment(String id) => _requestComments(id);

//   Future addComment(Comments comment, String feedId,
//       {Map<String, dynamic> replyToUser}) async {
//     try {
//       DocumentReference doc = await _commentCollection.add(comment.toMap());

//       final feed = _feedCollection.doc(feedId);
//       final data = await feed.get();

//       int comments = data.data()['comments'];
//       await feed.update({'comments': (comments + 1)});

//       // send notification
//       var auth = await Methods.getPref('auth');
//       UserModel user = userModelFromJson(auth);
//       print("reply:" + replyToUser.toString());

//       if (replyToUser['reply']) {
//         await _notifReference.add({
//           'subscription': replyToUser['to'],
//           'message': '<b>${user.data.name}</b> menanggapi komentar Anda.',
//           'created_at': DateTime.now().millisecondsSinceEpoch,
//           'feed_id':
//               feedId, // untuk melihat feed yang dikomentari saat notif ditap
//           'comment_id': doc
//               .id, // untuk menghapus data notifikasi jika komentar yang dikirim dihapus
//           'seen': false,
//           'topic': 'comment'
//         });

//         PushNotificationService.sendToAll(
//             title: '${user.data.name} menanggapi komentar Anda.',
//             body: comment.comment);
//       } else {
//         if (data.data()['username'] != user.data.email) {
//           // jika feed yang dikomentari bukan feednya, kirimkan notif
//           await _notifReference.add({
//             'subscription': data.data()[
//                 'username'], // username pemilik feed -> untuk memberitahu pemilik feed bahwa ada yang berkomentar di feednya
//             'message': '<b>${user.data.name}</b> mengomentari kiriman Anda.',
//             'created_at': DateTime.now().millisecondsSinceEpoch,
//             'feed_id':
//                 feedId, // untuk melihat feed yang dikomentari saat notif ditap
//             'comment_id': doc
//                 .id, // untuk menghapus data notifikasi jika komentar yang dikirim dihapus
//             'seen': false,
//             'topic': 'comment'
//           });

//           PushNotificationService.sendToAll(
//               title: '${user.data.name} mengomentari kiriman Anda.',
//               body: comment.comment);
//         }
//       }
//     } catch (e) {
//       return e is PlatformException ? e.message : e.toString();
//     }
//   }

//   Future updateComment(Comments comment) async {
//     try {
//       await _commentCollection
//           .doc(comment.documentId)
//           .update(comment.toMapOnly());
//     } catch (e) {
//       return e is PlatformException ? e.message : e.toString();
//     }
//   }

//   static Future<String> getLikeFeed({String feedID, String username}) async {
//     final fs = FirebaseFirestore.instance;

//     return feedID;
//     // var doc_ref = await fs
//     //     .collection('feeds')
//     //     .where('feed_id', isEqualTo: feedID)
//     //     .orderBy('created_at', descending: true)
//     //     .get();
//     // doc_ref.docs.forEach((result) {
//     //   print(result.toString());
//     //   return result.data().length == 0
//     //       ? "asddsa"
//     //       : result.data().length.toString();
//     // });
//   }
//   // static Future<List<QueryDocumentSnapshot>> getFeed({int limit: 5}) async{
//   //   final fs = FirebaseFirestore.instance;

//   //   final data = await fs.collection('feeds').orderBy('created_at', descending: true).limit(limit).get();
//   //   return data.docs;
//   // }

//   // static Future<List<QueryDocumentSnapshot>> nextFetch({DocumentSnapshot start, int limit: 5}) async{
//   //   final fs = FirebaseFirestore.instance;

//   //   final data = await fs.collection('feeds')
//   //     .orderBy('created_at', descending: true)
//   //     .limit(limit).startAfterDocument(start).get();

//   //   return data.docs;
//   // }

//   // static Future sendFeed({String feed, File file}) async{
//   //   Map auth = json.decode(await Methods.getPref('auth'));
//   //   User user = User.fromJson(auth);

//   //   final fs = FirebaseFirestore.instance;

//   //   Map<String, dynamic> formData = {
//   //     'username': user.username,
//   //     'name': user.name,
//   //     'created_at': DateTime.now().millisecondsSinceEpoch,
//   //     'liked_by': [],
//   //     'comments': 0
//   //   };

//   //   if(file != null){
//   //     ForumService.sendImage(file, imageUrl: (url) async{
//   //       formData['image'] = url;
//   //       formData['feed'] = feed;

//   //       await fs.collection('feeds').add(formData); return;
//   //     });
//   //   }else{
//   //     formData['feed'] = feed;
//   //     await fs.collection('feeds').add(formData);
//   //   }

//   //   return true;
//   // }

//   // static Future sendImage(File image, {Function fsTask(StorageUploadTask uploadTask), Future<Function> imageUrl(String url)}) async{
//   //   String fileName = basename(image.path);
//   //   StorageReference ref = FirebaseStorage.instance.ref().child('forum/'+fileName);

//   //   final StorageUploadTask task = ref.putFile(image);

//   //   if(fsTask != null){ fsTask(task); }

//   //   StorageTaskSnapshot snapshot = await task.onComplete;
//   //   final downloadUrl = await snapshot.ref.getDownloadURL();
//   //   if(imageUrl != null) imageUrl(downloadUrl);

//   //   // task.events.listen((e){
//   //   //   print('${e.snapshot.bytesTransferred} - ${e.snapshot.totalByteCount}');
//   //   //   onProgress((e.snapshot.bytesTransferred.toDouble() / e.snapshot.totalByteCount.toDouble()) * 100);
//   //   // });
//   // }

//   static Future deleteFeed(String id, {String imageUrl}) async {
//     final fs = FirebaseFirestore.instance;
//     await fs.collection('feeds').doc(id).delete();

//     fs
//         .collection('feed_comments')
//         .where('feed_id', isEqualTo: id)
//         .get()
//         .then((value) async {
//       value.docs.forEach((doc) {
//         fs.collection('feed_comments').doc(doc.id).delete();
//       });
//     });

//     if (imageUrl != null) {
//       String pattern = '/o/forum%2F';
//       int start = imageUrl.indexOf(pattern),
//           last = imageUrl.indexOf('?', start + pattern.length);

//       String filePath = imageUrl.substring(start + pattern.length, last);
//       StorageReference ref =
//           FirebaseStorage.instance.ref().child('forum/' + filePath);
//       await ref.delete();
//     }
//   }

//   // static Future updateFeed(String id, {String feed}) async{
//   //   final fs = FirebaseFirestore.instance;

//   //   Map<String, dynamic> formData = {
//   //     'updated_at': DateTime.now().millisecondsSinceEpoch,
//   //     'feed': feed
//   //   };

//   //   await fs.collection('feeds').doc(id).update(formData);

//   //   return true;
//   // }

//   static Future likeFeed(String id) async {
//     // get data user yang login
//     var auth = await Methods.getPref('auth');
//     UserModel user = userModelFromJson(auth);

//     final fs = FirebaseFirestore.instance;

//     final feed = fs.collection('feeds').doc(id);
//     final data = await feed.get();

//     List likedBy = data.data()['liked_by'];

//     int io = likedBy.indexWhere((e) => e['username'] == user.data.email);

//     final CollectionReference _notifReference =
//         FirebaseFirestore.instance.collection('notifications');

//     if (io < 0) {
//       likedBy.insert(
//           0, {'username': user.data.email, 'name': user.data.name ?? '-'});

//       // kirim notifikasi bahwa pengguna lain menyukai kiriman (bukan kiriman dia)
//       if (data.data()['username'] != user.data.email) {
//         // grouping like

//         // cek apakah kiriman tersebut terdapat like atau belum
//         if (likedBy.length > 1) {
//           // terdapat like

//           // hapus user logged (username), user logged tidak menjadi bagian dari pemberitahuan kirimannya disukai oleh dirinya
//           List names = likedBy
//               .where((e) => e['username'] != data.data()['username'])
//               .toList();
//           int take = names.length >= 2 ? 2 : names.length;

//           // join pesan notifikasi
//           String listName = '<b>' +
//               names
//                   .map((e) => e['name'])
//                   .toList()
//                   .take(take)
//                   .join('</b>, <b>') +
//               '</b>';
//           String notifMessage = names.length < 3
//               ? "<b>${listName.replaceAll(', ', ' dan ')}</b> menyukai kiriman Anda."
//               : "$listName dan ${names.length - take} lainnya menyukai kiriman Anda.";

//           await fs
//               .collection('notifications')
//               .where('feed_id', isEqualTo: id)
//               .where('topic', isEqualTo: 'liked')
//               .get()
//               .then((value) {
//             if (value.docs.isNotEmpty) {
//               value.docs.forEach((e) {
//                 _notifReference.doc(e.id).update({
//                   'message': notifMessage,
//                   'seen': false,
//                   'created_at': DateTime.now().millisecondsSinceEpoch,
//                 });
//               });
//             }
//           });

//           PushNotificationService.sendToAll(
//               title: "Pemberitahuan",
//               body: "${Methods.removeHtmlTag(notifMessage)}");
//         } else {
//           // tidak terdapat like
//           await _notifReference.add({
//             'subscription': data.data()[
//                 'username'], // username pemilik feed -> untuk memberitahu pemilik feed bahwa ada yang menyukai feednya
//             'message': '${user.data.name} menyukai kiriman Anda.',
//             'created_at': DateTime.now().millisecondsSinceEpoch,
//             'feed_id': id, // untuk melihat feed yang disukai saat notif ditap
//             'seen': false,
//             'topic': 'liked'
//           });

//           PushNotificationService.sendToAll(
//               title: "Pemberitahuan",
//               body: "${user.data.name} menyukai kiriman Anda.");
//         }

//         // await _notifReference.add({
//         //   'subscription': data.data()['username'], // username pemilik feed -> untuk memberitahu pemilik feed bahwa ada yang menyukai feednya
//         //   'message': '${user.name} menyukai kiriman Anda.',
//         //   'created_at': DateTime.now().millisecondsSinceEpoch,
//         //   'feed_id': id, // untuk melihat feed yang disukai saat notif ditap
//         //   'liked_by': user.username, // untuk menghapus data notifikasi jika dislike
//         //   'seen': false,
//         //   'topic': 'liked'
//         // });

//         // PushNotificationService.sendToAll(
//         //   title: '${user.name} menyukai kiriman Anda.',
//         //   body: ''
//         // );
//       }
//     } else {
//       likedBy.removeAt(io);

//       if (likedBy.length == 0) {
//         await fs
//             .collection('notifications')
//             .where('feed_id', isEqualTo: id)
//             .where('topic', isEqualTo: 'liked')
//             .get()
//             .then((value) {
//           if (value.docs.isNotEmpty) {
//             value.docs.forEach((e) {
//               _notifReference.doc(e.id).delete();
//             });
//           }
//         });
//       } else {
//         // get 2 daftar nama yang menyukai, hapus like
//         List names = likedBy
//             .where((e) => e['username'] != data.data()['username'])
//             .toList();
//         int take = names.length >= 2 ? 2 : names.length;

//         String listName = '<b>' +
//             names.map((e) => e['name']).toList().take(take).join('</b>, <b>') +
//             '</b>';
//         String notifMessage = names.length < 3
//             ? "<b>${listName.replaceAll(', ', ' dan ')}</b> menyukai kiriman Anda."
//             : "$listName dan ${names.length - take} lainnya menyukai kiriman Anda.";

//         await fs
//             .collection('notifications')
//             .where('feed_id', isEqualTo: id)
//             .where('topic', isEqualTo: 'liked')
//             .get()
//             .then((value) {
//           if (value.docs.isNotEmpty) {
//             value.docs.forEach((e) {
//               _notifReference.doc(e.id).update({'message': notifMessage});
//             });
//           }
//         });
//       }
//     }

//     await feed.update({'liked_by': likedBy});

//     // final like = await fs.collection('feed_likes').where('username', isEqualTo: user.username).where('feed_id', isEqualTo: id).get().then((value) => value);

//     // if(like.docs.length > 0){
//     //   for (DocumentSnapshot doc in like.docs) {
//     //     doc.reference.delete();
//     //   }
//     // }else{
//     //   fs.collection('feed_likes').add({
//     //     'feed_id': id,
//     //     'username': user.username,
//     //     'liked_at': DateTime.now().millisecondsSinceEpoch,
//     //     'liked_by': [

//     //     ]
//     //   });
//     // }
//   }

//   // static Future commentFeed(String feedId, String text) async{
//   //   Map auth = json.decode(await Methods.getPref('auth'));
//   //   User user = User.fromJson(auth);

//   //   final fs = FirebaseFirestore.instance;

//   //   Map<String, dynamic> formData = {
//   //     'feed_id': feedId,
//   //     'name': user.name,
//   //     'username': user.username,
//   //     'created_at': DateTime.now().millisecondsSinceEpoch,
//   //     'comment': text,
//   //     'liked_by': []
//   //   };

//   //   final feed = fs.collection('feeds').doc(feedId);
//   //   final data = await feed.get();

//   //   int comments = data.data()['comments'];

//   //   await fs.collection('feed_comments').add(formData);
//   //   await fs.collection('feeds').doc(feedId).update({'comments': (comments  + 1)});
//   // }

//   static Future likeComment(String id) async {
//     var auth = await Methods.getPref('auth');
//     UserModel user = userModelFromJson(auth);

//     final fs = FirebaseFirestore.instance;

//     final feed = fs.collection('feed_comments').doc(id);
//     final data = await feed.get();

//     List likedBy = data.data()['liked_by'];

//     int io = likedBy.indexWhere((e) => e['username'] == user.data.email);

//     if (io < 0) {
//       likedBy.add({'username': user.data.email, 'name': user.data.name ?? '-'});
//     } else {
//       likedBy.removeAt(io);
//     }

//     await feed.update({'liked_by': likedBy});
//   }

//   // static Future updateComment(String id, String text) async{
//   //   final fs = FirebaseFirestore.instance;
//   //   await fs.collection('feed_comments').doc(id).update({'comment': text});
//   // }

//   static Future deleteComment(String id, String feedId) async {
//     // print(id + "/" + feedId);
//     final fs = FirebaseFirestore.instance;

//     // final feed = fs.collection('feeds').doc(feedId);
//     // final data = await feed.get();

//     // int comments = data.data()['comments'];

//     // QuerySnapshot query = await fs
//     //     .collection('notifications')
//     //     .where('comment_id', isEqualTo: id)
//     //     .get();
//     // query.docs.forEach(
//     //     (e) async => await fs.collection('notifications').doc(e.id).delete());

//     // await fs
//     //     .collection('feeds')
//     //     .doc(feedId)
//     //     .update({'comments': (comments - 1)});
//     await fs.collection('feed_comments').doc(id).delete();
//   }

//   static Future<Feeds> getMyFeed(String id) async {
//     final fs = FirebaseFirestore.instance;

//     final data = fs.collection('feeds').doc(id).get();

//     var feeds = data.asStream().map((e) => Feeds.fromMap(e.data(), e.id)).first;
//     return feeds;
//   }

//   static Stream<Feeds> listenMyFeed(String id) async* {
//     final CollectionReference fs =
//         FirebaseFirestore.instance.collection('feeds');

//     Stream<DocumentSnapshot> stream = fs.doc(id).snapshots();
//     await for (DocumentSnapshot q in stream) {
//       yield Feeds.fromMap(q.data(), q.id);
//     }
//   }
// }
