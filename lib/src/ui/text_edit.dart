import 'package:x_stream/ext_dependencies.dart';

class TextEditPage extends StatefulWidget {
  final bool showLogo;
  final ValueChanged<String> onSubmit;
  final String label;
  final String actionName;
  final bool isPhone;
  final bool isCode;

  const TextEditPage(
      {Key key,
      this.showLogo = false,
      this.onSubmit,
      this.label = "Phone",
      this.actionName = "LOG IN",
      this.isCode=false,
      this.isPhone = true})
      : assert(onSubmit != null),
        super(key: key);

  @override
  _TextEditPageState createState() => _TextEditPageState();
}

class _TextEditPageState extends State<TextEditPage> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Scaffold(
        backgroundColor: Color(0xff261325),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                _buildLogo(_buildForm()),
                SizedBox(height: ScreenUtil.getInstance().setHeight(90)),
                _buildSubmit(),
              ],
            ),
          ),
        ));
  }

  Widget _buildForm() {
    final textField = TextField(
      onSubmitted: widget.onSubmit,
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      keyboardType: widget.isCode || widget.isPhone? TextInputType.numberWithOptions():TextInputType.text,
      decoration: InputDecoration(
          prefix: widget.isPhone? Text("+251-",style: TextStyle(color: Colors.white70),):null,
          border:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelText: widget.label,
          labelStyle: TextStyle(color: Colors.white)),
    );
    return textField;
  }

  _buildLogo(Widget child) {
    final logHolder = Image.asset("assets/logo_text.png",);
    return Column(
      children: <Widget>[
        widget.showLogo
            ? logHolder
            : Container(
                height: 200.0,
                width: 200.0,
              ),
        SizedBox(height: ScreenUtil.getInstance().setHeight(150)),
        child
      ],
    );
  }

  _buildSubmit() {
    return OutlineButton(
      borderSide: BorderSide(
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        widget.onSubmit(controller.text);
      },
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 46.0),
      child: Text(
        widget.actionName,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    );
  }
}
