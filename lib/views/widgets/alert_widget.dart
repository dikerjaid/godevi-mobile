part of 'widgets.dart';

enum AlertType { success, warning, error, confirmation }

class Alert {
  static show(BuildContext context,
      {String title,
      String subtitle,
      AlertType type: AlertType.success,
      List<Widget> actions: const [],
      Function(int i) onTapConfirm,
      bool dismiss: true,
      bool autoFillAction: true,
      Function onTap}) {
    showDialog(
        context: context,
        barrierDismissible: dismiss,
        builder: (_) => AlertWidget(
              title: title,
              subtitle: subtitle,
              type: type,
              actions: actions,
              onTapConfirm: onTapConfirm,
              onTap: onTap,
              autoFillAction: autoFillAction,
            ));
  }
}

class AlertWidget extends StatelessWidget {
  final String title, subtitle, buttonText;
  final AlertType type;
  final Function onTap;
  final Function(int i) onTapConfirm;
  final List<Widget> actions;
  final bool autoFillAction;

  AlertWidget(
      {this.title,
      this.subtitle,
      this.buttonText,
      this.actions,
      this.onTap,
      this.onTapConfirm,
      this.type: AlertType.success,
      this.autoFillAction: true});

  @override
  Widget build(BuildContext context) {
    Widget icons({IconData icon, Color color}) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            decoration: BoxDecoration(
                border: Border.all(color: color.withOpacity(.5), width: 2),
                shape: BoxShape.circle),
            padding: EdgeInsets.all(10),
            child: Icon(icon, size: 45, color: color)),
      );
    }

    return ZoomIn(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: radius5,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      icons(
                          icon: type == AlertType.success
                              ? La.check
                              : type == AlertType.warning
                                  ? La.exclamation
                                  : type == AlertType.error
                                      ? La.times
                                      : La.question,
                          color: type == AlertType.success
                              ? Colors.green
                              : type == AlertType.warning
                                  ? Colors.orange
                                  : type == AlertType.error
                                      ? Colors.red
                                      : Colors.blue),
                      Text('$title',
                          style: gfont.copyWith(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('$subtitle',
                            style: gfont.copyWith(fontSize: 16),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      autoFillAction
                          ? Row(
                              children: List.generate(2, (i) {
                              List<String> labels = ['Batal', 'Ya'];
                              List<Color> colors = [
                                Color(0xfff1f1f1),
                                Colors.blue[400]
                              ];

                              return SplashButton(
                                onTap: () {
                                  Navigator.pop(context);
                                  if (onTapConfirm != null) onTapConfirm(i);
                                },
                                color: colors[i],
                                child: Container(
                                  width: (Get.width / 2) - 15,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 25),
                                  child: Text(labels[i],
                                      style: gfont.copyWith(
                                          color: i == 0
                                              ? Colors.black87
                                              : Colors.white),
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }))
                          : actions.length == 0
                              ? Container(
                                  padding: EdgeInsets.all(15),
                                  child: SplashButton(
                                    // onTap: () =>
                                    //     onTap() ?? Navigator.pop(context),
                                    onTap: () {
                                      onTap != null
                                          ? onTap()
                                          : Navigator.pop(context);
                                      //
                                    },
                                    color: Colors.green[300],
                                    child: Container(
                                      width: Get.width,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 13, horizontal: 25),
                                      child: Text(buttonText ?? 'OK',
                                          style: gfont.copyWith(
                                              color: Colors.white),
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                )
                              : actions
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
