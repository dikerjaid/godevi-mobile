part of 'widgets.dart';

enum PopType { normal, primary, danger }

class Popup {
  static open(context,
      {Widget child,
      bool dismiss: true,
      String title,
      String subtitle,
      List<String> textButton,
      PopType type: PopType.normal,
      Function ok}) {
    showDialog(
      context: context,
      barrierDismissible: dismiss,
      builder: (_) =>
          child ??
          PopupUI(
              title: title,
              subtitle: subtitle,
              textButton: textButton,
              type: type),
    ).then((value) {
      if (value == 1 && ok != null) ok(value);
    });
  }
}

class PopupUI extends StatelessWidget {
  final String title, subtitle;
  final PopType type;
  final List<String> textButton;

  PopupUI(
      {this.title, this.subtitle, this.textButton, this.type: PopType.normal});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Material(
                color: Colors.transparent,
                child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title ?? '',
                                  style: gfont.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              Text(subtitle ?? '', style: gfont),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: List.generate(2, (i) {
                              List<String> labels =
                                  textButton ?? ['Tidak', 'Iya'];

                              Color _color = type == PopType.normal
                                  ? Colors.white
                                  : type == PopType.primary
                                      ? Colors.blue[300]
                                      : Colors.red[400];
                              List<Color> colors = [Color(0xfff5f5f5), _color];

                              return SplashButton(
                                onTap: () {
                                  Navigator.pop(context, i);
                                },
                                color: colors[i],
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: i == 0
                                                  ? Color(0xfff1f1f1)
                                                  : Colors.transparent))),
                                  width: Get.width / 2 - 15,
                                  child: Text(labels[i],
                                      style: gfont.copyWith(
                                          color: i == 0
                                              ? Colors.black87
                                              : type == PopType.normal
                                                  ? Colors.black87
                                                  : Colors.white),
                                      textAlign: TextAlign.center),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
