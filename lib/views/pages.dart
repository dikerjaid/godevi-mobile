import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:godevi/controllers/controllers.dart';
import 'package:godevi/models/models.dart';
import 'package:godevi/services/services.dart';
import 'package:godevi/shareds/shared.dart';
import 'package:godevi/views/widgets/widgets.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:webview_flutter/webview_flutter.dart';

//intro
part 'layouts/intro/initial_page.dart';
part 'layouts/intro/intro_page.dart';
// Auth
part 'layouts/auth/login_page.dart';

//home

part 'layouts/home/home_page.dart';

part './dashboard.dart';

part 'layouts/home/slider_widget.dart';
part './layouts/home/explore_village_widget.dart';
part './layouts/home/tour_package_widget.dart';

//Blog

part './layouts/blog/blog_page.dart';
part './layouts/blog/blog_widget.dart';
part './layouts/blog/post_page.dart';
// part './layouts/blog/comment.dart';
part './layouts/blog/comment_skeleton.dart';

part './layouts/profile/profile_page.dart';
//Folder Cart
part './layouts/cart/cart_page.dart';
part './layouts/cart/unpaid_list_view.dart';
part './layouts/cart/finish_list_view.dart';
part './layouts/cart/favorite_list_view.dart';

//Explorer

part './layouts/explorer/explorer_page.dart';
part './layouts/explorer/detail_package.dart';
part './layouts/explorer/review_page.dart';
