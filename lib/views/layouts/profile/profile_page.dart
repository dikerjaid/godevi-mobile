part of '../../pages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<SettingsListData> userSettingsList = SettingsListData.userSettingsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(child: appBar()),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0.0),
              itemCount: userSettingsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 2) {
                      Popup.open(context,
                          title: 'Logout!',
                          subtitle: 'Yakin ingin keluar dari akun ini?',
                          type: PopType.danger, ok: (i) {
                        // AuthServices.signOutGoogle();
                        Storage.remove();
                        Get.to(InitialPage());
                      });
                    }
                    if (index == 1) {}

                    if (index == 0) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChangepasswordScreen(),
                      //     fullscreenDialog: true,
                      //   ),
                      // );
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  userSettingsList[index].titleTxt,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Divider(
                          height: 1,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return GetBuilder<AuthController>(builder: (state) {
      return InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${state.auth.name}",
                      style: gfont.copyWith(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "View and edit profile",
                      style:
                          gfont.copyWith(fontSize: 16, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 24, top: 16, bottom: 16),
            //   child: Container(
            //     width: 70,
            //     height: 70,
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.all(Radius.circular(40.0)),
            //       child: FadeInImage.assetNetwork(
            //           placeholder: "assets/images/userImage.png",
            //           image: urlImage + "/users/" + state.auth.avatar

            //           ),
            //     ),
            //   ),
            // )
          ],
        ),
      );
    });
  }
}
