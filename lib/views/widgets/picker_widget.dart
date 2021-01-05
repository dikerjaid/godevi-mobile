part of 'widgets.dart';

enum PickerType { date, month, year }

class PickerWidget {
  static Widget date({List<int> years, String initValue}) {
    return DatePickerWidget(years: years, initValue: initValue);
  }
}

class DatePickerWidget extends StatelessWidget {
  final List<int> years;
  final String initValue;
  final _picker = Get.put(PickerController());

  DatePickerWidget({this.years = const [], this.initValue});

  @override
  Widget build(BuildContext context) {
    int day = 0, month = 0, year = 0;
    DateTime now = DateTime.now();

    // jika initValue tidak terisi, set dengan tanggal hari ini
    if (initValue == null || initValue.trim().isEmpty) {
      day = now.day;
      month = now.month;
      year = now.year;

      int lastday = DateTime(now.year, now.month + 1, 0).day;
      _picker.setLastDate(lastday, day);
    } else {
      // dd-mm-yyyy
      List iv = initValue.split('-');
      day = int.parse(iv[0]);
      month = int.parse(iv[1]);
      year = int.parse(iv[2]);

      int lastday = DateTime(year, month + 1, 0).day;
      _picker.setLastDate(lastday, day);
    }

    List<int> listYear = years != null && years.length > 1 && years[1] > years[0]
        ? List.generate(Fn.range(years[0], years[1]).length, (i) => years[0] + i)
        : List.generate(5, (i) => i + now.year);

    Widget cupertino(int length, {int initial, PickerType type: PickerType.date}) {
      List<String> listMonth = [
        'Januari',
        'Februari',
        'Maret',
        'April',
        'Mei',
        'Juni',
        'Juli',
        'Agustus',
        'September',
        'Oktober',
        'November',
        'Desember'
      ];

      Widget dateText(int i) {
        return Text(
          '${i + 1}',
          style: gfont.copyWith(fontSize: 17, letterSpacing: 1),
        );
      }

      Widget dateMonth(int i) {
        return Text(
          '${listMonth[i]}',
          style: gfont.copyWith(fontSize: 17, letterSpacing: 1),
        );
      }

      Widget dateYear(int i) {
        return Text(
          '${i + ((years != null && years.length > 1) ? years[0] : now.year)}',
          style: gfont.copyWith(fontSize: 17, letterSpacing: 1),
        );
      }

      return PreventScrollGlow(
          child: CupertinoPicker(
        selectionOverlay: Container(
          decoration: BoxDecoration(color: Color(0xfff1f1f1).withOpacity(.5)),
        ),
        scrollController: FixedExtentScrollController(
          initialItem: type == PickerType.year ? listYear.indexOf(year) : initial ?? 0,
        ),
        itemExtent: 50.0,
        backgroundColor: Colors.white,
        useMagnifier: true,
        onSelectedItemChanged: (int i) {
          switch (type) {
            case PickerType.date:
              day = (i + 1);
              break;

            case PickerType.month:
              month = (i + 1);
              break;
            default:
              year = (i + ((years != null && years.length > 1) ? years[0] : now.year));
              break;
          }

          if (type != PickerType.date) {
            int lastday = DateTime(year, month + 1, 0).day;
            _picker.setLastDate(lastday, day);
          }
        },
        children: new List<Widget>.generate(length, (int index) {
          return Center(
            child: type == PickerType.date
                ? dateText(index)
                : type == PickerType.month
                    ? dateMonth(index)
                    : dateYear(index),
          );
        }),
      ));
    }

    return CustomModal(
      child: Stack(
        children: [
          Column(children: [
            Container(
              height: 250,
              child: Row(
                children: [
                  Expanded(
                    child: GetBuilder<PickerController>(
                        builder: (picker) => picker.isChange ? Container() : cupertino(picker.lastDate, initial: picker.initial)),
                  ),
                  Expanded(
                    child: cupertino(12, initial: month - 1, type: PickerType.month),
                  ),
                  Expanded(
                    child: cupertino(listYear.length, initial: year, type: PickerType.year),
                  ),
                ],
              ),
            ),
          ]),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: SplashButton(
                onTap: () {
                  String result = ('$day'.length == 1 ? '0$day' : '$day') + '-' + ('$month'.length == 1 ? '0$month' : '$month') + '-$year';
                  Navigator.pop(context, result);
                },
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                radius: radius50,
                color: Colors.blue[100],
                child: Text('OK', style: gfont.copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class PickerController extends GetxController {
  // lastDate diisi dengan tanggal terakhir saat bulan dan tahun diperbarui
  int lastDate = 0,

      // initial merupakan index/value dari tanggal yang dipilih, jadi ketika bulan atau tahun diubah tanggal akan ke-set dengan index/value yang dipilih
      initial = 0;
  bool isChange = true;

  setLastDate(int ld, int dateSelected) {
    isChange = true;
    initial = 0;
    update();

    // berikan timer agar widget dapat diperbarui
    Timer(Duration(milliseconds: 40), () {
      lastDate = ld;
      initial = dateSelected < ld ? (dateSelected - 1) : lastDate;
      isChange = false;
      update();
    });
  }
}
