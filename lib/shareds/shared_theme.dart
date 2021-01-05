part of 'shared.dart';

String assetImage = 'assets/images', assetIcon = 'assets/icons';

// radius
BorderRadius radius5 = BorderRadius.circular(5),
    radius10 = BorderRadius.circular(10),
    radius15 = BorderRadius.circular(15),
    radius25 = BorderRadius.circular(25),
    radius50 = BorderRadius.circular(50);

// padding
EdgeInsetsGeometry padding5 = EdgeInsets.all(5),
    padding10 = EdgeInsets.all(10),
    padding15 = EdgeInsets.all(15),
    padding20 = EdgeInsets.all(20),
    padding25 = EdgeInsets.all(25);

// text style
TextStyle gfont = GoogleFonts.aBeeZee();

// color filter
ColorFilter invert = ColorFilter.matrix([
  -1,
  0,
  0,
  0,
  255,
  0,
  -1,
  0,
  0,
  255,
  0,
  0,
  -1,
  0,
  255,
  0,
  0,
  0,
  1,
  0,
]); // https://www.burkharts.net/apps/blog/over-the-rainbow-colour-filters/

dynamic lgradient = ({@required List colors}) => LinearGradient(
      colors: colors,
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(0.8, 0.0),
      stops: [0.0, 1.0],
    );

// colors

Color primaryColor = Color(0xff33287A);
Color redColor = Color(0xffDC4F4F);

class AppTheme {
  static bool isLightTheme = true;
  static Color primaryColors = Color(0xff4FBE9F);

  static TextTheme _buildTextTheme(TextTheme base) {
    var fontName = "WorkSans";
    var copyWith = base.copyWith(
      subtitle1: base.subtitle1.copyWith(fontFamily: fontName),
      bodyText2: base.subtitle1.copyWith(fontFamily: fontName),
      button: base.subtitle1.copyWith(fontFamily: fontName),
      caption: base.subtitle1.copyWith(fontFamily: fontName),
      headline5: base.subtitle1.copyWith(fontFamily: fontName),
      headline4: base.subtitle1.copyWith(fontFamily: fontName),
      headline3: base.subtitle1.copyWith(fontFamily: fontName),
      headline2: base.subtitle1.copyWith(fontFamily: fontName),
      headline1: base.subtitle1.copyWith(fontFamily: fontName),
      overline: base.subtitle1.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle1.copyWith(fontFamily: fontName),
      bodyText1: base.subtitle1.copyWith(fontFamily: fontName),
    );
    return copyWith;
  }

  static ThemeData getTheme() {
    if (isLightTheme) {
      return newLightTheme();
    } else {
      return newDarkTheme();
    }
  }

  static ThemeData newLightTheme() {
    Color primaryColor = primaryColors;
    Color secondaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }

  static ThemeData newDarkTheme() {
    Color primaryColor = primaryColors;
    Color secondaryColor = primaryColors;
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}
