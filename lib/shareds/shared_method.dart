part of 'shared.dart';

class Fn {
  static navigate(BuildContext context, Widget widget,
      {Function(dynamic value) then}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget))
        .then((value) {
      if (then != null) then(value);
    });
  }

  static double doubleInRange(num start, num end) =>
      Random().nextDouble() * (end - start) + start;

  static focus(context, FocusNode node) =>
      FocusScope.of(context).requestFocus(node);
  static statusBar({@required Color color, bool darkText: true}) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(!darkText);
  }

  static String timeAgo(int timestamp, {bool fullText: false}) {
    Duration compare(DateTime x, DateTime y) {
      return Duration(
          microseconds:
              (x.microsecondsSinceEpoch - y.microsecondsSinceEpoch).abs());
    }

    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    DateTime x = DateTime.now();
    DateTime y = DateTime(
        date.year, date.month, date.day, date.hour, date.minute, date.second);

    var diff = compare(x, y);

    if (y.millisecondsSinceEpoch > x.millisecondsSinceEpoch) {
      return '-';
    } else {
      if (diff.inSeconds >= 60) {
        if (diff.inMinutes >= 60) {
          if (diff.inHours >= 24) {
            return '${date.day}/${date.month}/${date.year}';
          } else {
            return diff.inHours.toString() +
                (fullText ? ' jam yang lalu' : 'j');
          }
        } else {
          // return '${date.day}/${date.month}/${date.year}';
          return diff.inMinutes.toString() +
              (fullText ? ' menit yang lalu' : 'm');
        }
      } else {
        return 'baru saja';
      }
    }
  }

  static idr(int number, {String symbol: 'Rp ', int decimal: 0}) {
    return NumberFormat.currency(
            locale: 'id_ID', decimalDigits: decimal, symbol: symbol)
        .format(number);
  }

  static ansi(String text) {
    print('\x1B[93m' + "$text" + '\x1B[0m');
  }

  static bool checkRequired(List input) {
    List status = [];

    input.forEach((e) {
      if (e == null || e.toString().trim().isEmpty) {
        status.add(0);
      }
    });

    if (status.length > 0 && status.indexOf(0) > -1) {
      return false;
    }

    return true;
  }

  static bool validation(Map<String, dynamic> input,
      {List<String> except: const []}) {
    List status = [];

    input.forEach((k, v) {
      if (v == null || v.toString().trim().isEmpty) {
        if (except.indexOf(k) < 0) status.add(k);
      }
    });

    print(status);

    if (status.length > 0 && status.indexOf(0) > -1) {
      return false;
    }

    return true;
  }

  static Map<String, dynamic> toFormData(List controller,
      {List except: const []}) {
    Map<String, dynamic> formData = {};

    print(json.encode(controller));

    return formData;
  }

  static range(int a, [int stop, int step]) {
    int start;

    if (stop == null) {
      start = 0;
      stop = a;
    } else {
      start = a;
    }

    if (step == 0) throw Exception("Step cannot be 0");

    if (step == null)
      start < stop
          ? step = 1 // walk forwards
          : step = -1; // walk backwards

    // return [] if step is in wrong direction
    return start < stop == step > 0
        ? List<int>.generate(
            ((start - stop) / step).abs().ceil(), (int i) => start + (i * step))
        : [];
  }
}

class Screen {
  static width(context) => MediaQuery.of(context).size.width;
  static height(context) => MediaQuery.of(context).size.height;
  static statusBar(context) => MediaQuery.of(context).padding.top;
}

class Bot {
  static Future sendMessage(String activity, String message) async {
    var chatMessages = "Activity : " + activity + "\n\nError : " + message;
    var bot =
        TelegramBot.init('1445154682:AAGmshm8pnHQugicNvdpIr8ckMjlDvvn-CM');
    bot.sendMessage(chatId: '-406861430', text: chatMessages);
  }
}

class Storage {
  // jika data yang disimpan adalah list / map, maka akan diconvert dalam bentuk string
  static Future write(String key, data) async {
    var prefs = await SharedPreferences.getInstance();

    if (data is List || data is Map) {
      prefs.setString(key, json.encode(data));
    } else if (data is bool) {
      prefs.setBool(key, data);
    } else if (data is int) {
      prefs.setInt(key, data);
    } else if (data is String) {
      prefs.setString(key, data);
    } else {
      prefs.setDouble(key, data);
    }
  }

  static Future read(String key) async {
    var prefs = await SharedPreferences.getInstance();

    switch (prefs.get(key).runtimeType) {
      case List:
        return prefs.getString(key);
        break;
      case Map:
        return prefs.getString(key);
        break;
      case bool:
        return prefs.getBool(key);
        break;
      case int:
        return prefs.getInt(key);
        break;
      case String:
        return prefs.getString(key);
        break;
      case double:
        return prefs.getDouble(key);
        break;
    }
  }

  // except adalah prioritas, jika except & only = null maka semua key akan dihapus
  static Future remove({List except, List only}) async {
    var prefs = await SharedPreferences.getInstance(), keys = prefs.getKeys();
    for (var i = 0; i < keys.toList().length; i++) {
      if (except == null) {
        if (only != null) {
          if (only.indexOf(keys.toList()[i]) > -1) {
            prefs.remove(keys.toList()[i]);
          }
        } else {
          prefs.remove(keys.toList()[i]);
        }
      } else {
        if (except.indexOf(keys.toList()[i]) < 0) {
          prefs.remove(keys.toList()[i]);
        }
      }
    }
  }
}

class Flutoast {
  static toast(String text, {ToastGravity gravity}) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity ??= ToastGravity.BOTTOM,
        backgroundColor: Color.fromRGBO(0, 0, 0, .7),
        textColor: Colors.white,
        fontSize: 14.0);
  }
}

// FOCUS NODE
class NFocus {
  static on(context, node) {
    FocusScope.of(context).requestFocus(node);
  }
}
