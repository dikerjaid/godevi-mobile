part of './widgets.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final VoidCallback click;
  final bool isLeftButton;

  const TitleView(
      {Key key,
      this.titleTxt: "",
      this.subTxt: "",
      this.click,
      this.isLeftButton: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  titleTxt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              isLeftButton
                  ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {
                          return click();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                subTxt,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppTheme.getTheme().primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 38,
                                width: 26,
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                  color: AppTheme.getTheme().primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        );
      }
}
