part of 'widgets.dart';

// digunakan dalam Component.modal
class CustomModal extends StatelessWidget {
  final Widget child;
  CustomModal({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5,
          width: 100,
          margin: EdgeInsets.symmetric(vertical: 7),
          decoration:
              BoxDecoration(color: Colors.black12, borderRadius: radius15),
        ),
        child
      ],
    );
  }
}

class CustomAppbar extends StatelessWidget {
  final Widget child;
  CustomAppbar({@required this.child});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff4753c4), Color(0xff4943ad)],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.5, 0.0),
          stops: [0.0, 1.0],
          // tileMode: TileMode.clamp
        ),
      ),
      child: child);
}

class InputControl extends StatelessWidget {
  final Widget child;
  final double marginBottom;
  final Color color;
  InputControl({@required this.child, this.marginBottom: 15, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: marginBottom),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: radius5,
            color: color ?? Colors.transparent),
        child: child);
  }
}

class ButtonPrimary extends StatelessWidget {
  final Function onTap;
  final double radius;
  final String title;
  ButtonPrimary({this.onTap, this.radius: 5, this.title: "Simpan"});

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      onTap: onTap,
      radius: BorderRadius.circular(radius),
      color: Color(0xffDC4F4F),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        width: Screen.width(context),
        child: Text(
          title,
          style: gfont.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  final double size;
  final String message;

  NoData({this.size: 130, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(assetImage + 'nodata.png'),
          )),
        ),
        message == null
            ? SizedBox.shrink()
            : Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(message ?? '-',
                    style: gfont.copyWith(fontSize: 15, color: Colors.black54),
                    textAlign: TextAlign.center),
              )
      ],
    ));
  }
}

class SelectOption extends StatelessWidget {
  final List options, values;
  final String initialValue;
  final double height;

  SelectOption(
      {@required this.options,
      this.values,
      this.initialValue,
      this.height: 150});

  @override
  Widget build(BuildContext context) {
    var selected = initialValue == null
        ? options.length > 0
            ? options[0]
            : null
        : initialValue;

    return CustomModal(
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: height < 100
                ? 100
                : height > 350
                    ? 350
                    : height,
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              child: PreventScrollGlow(
                child: CupertinoPicker(
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                          color: Color(0xfff1f1f1).withOpacity(.5)),
                    ),
                    scrollController: FixedExtentScrollController(
                      initialItem: options.indexOf(initialValue),
                    ),
                    itemExtent: 50.0,
                    backgroundColor: Colors.white,
                    useMagnifier: true,
                    onSelectedItemChanged: (int i) {
                      if (values == null) {
                        selected = options.length > 0 ? options[i] : null;
                      } else {
                        selected = values.length > 0 ? values[i] : null;
                      }
                    },
                    children:
                        new List<Widget>.generate(options.length, (int index) {
                      return Center(
                        child: Text(
                          '${options[index]}',
                          style: gfont.copyWith(fontSize: 17, letterSpacing: 1),
                        ),
                      );
                    })),
              ),
            ),
          ),
          SplashButton(
            onTap: () => Navigator.pop(context, selected),
            color: Colors.blue[50],
            child: Container(
                width: Get.width,
                padding: EdgeInsets.all(13),
                child: Text('OK',
                    style: gfont.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)),
          )
        ],
      ),
    );
  }
}

class SelectDate extends StatelessWidget {
  final String initialValue;
  final double height;
  final int maxYear, minYear;

  SelectDate(
      {this.initialValue,
      this.height: 150,
      this.maxYear: 2022,
      this.minYear: 2019});

  @override
  Widget build(BuildContext context) {
    DateTime selected = DateTime.now();

    String d = initialValue.trim().isEmpty || initialValue == null
        ? '-'
        : initialValue;
    List d0 = d == '-' ? [] : d.split('-');
    String tgl = d0.length > 0 ? '${d0[2]}-${d0[1]}-${d0[0]}' : '';

    return CustomModal(
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: height < 100
                ? 100
                : height > 350
                    ? 350
                    : height,
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              height: 200,
              width: Get.width,
              child: PreventScrollGlow(
                  child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle:
                                gfont.copyWith(fontSize: 17)),
                      ),
                      child: CupertinoDatePicker(
                        initialDateTime:
                            initialValue.trim().isEmpty || initialValue == null
                                ? DateTime.now()
                                : DateTime.parse(tgl),
                        onDateTimeChanged: (DateTime newdate) {
                          selected = newdate;
                        },
                        use24hFormat: true,
                        maximumDate: new DateTime(maxYear, 12, 30),
                        minimumYear: minYear,
                        maximumYear: maxYear,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.date,
                      ))),
            ),
          ),
          SplashButton(
            onTap: () => Navigator.pop(context, selected),
            color: Colors.blue[50],
            child: Container(
                width: Get.width,
                padding: EdgeInsets.all(13),
                child: Text('OK',
                    style: gfont.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)),
          )
        ],
      ),
    );
  }
}

class CenterDialog extends StatelessWidget {
  final Widget child;
  final double margin;

  CenterDialog({@required this.child, this.margin: 15});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Material(
          color: Colors.transparent,
          child: Container(margin: EdgeInsets.all(margin), child: child))
    ]));
  }
}

class NoAvatar extends StatelessWidget {
  final double size;
  NoAvatar({this.size: 50});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('$assetImage/profile.png'),
                fit: BoxFit.cover)));
  }
}

class T4CardList extends StatelessWidget {
  final String title;
  final List<Widget> labels;
  final List values;
  T4CardList({this.title, this.labels: const [], this.values: const []});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(child: Row(children: [Text('$title', style: gfont)])),
          Column(
            children: List.generate(labels.length, (i) {
              return Container(
                child: Row(children: labels),
              );
            }),
          )
        ],
      ),
    );
  }
}
