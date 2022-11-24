import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumWidget extends StatefulWidget {
  const PremiumWidget({Key? key}) : super(key: key);

  @override
  _PremiumWidgetState createState() => _PremiumWidgetState();
}

class _PremiumWidgetState extends State<PremiumWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0013FC),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Image.asset(
                  'assets/images/Premium.png',
                  width: 924,
                  height: 2000,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.05, 0.35),
                child: FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Hazte Premium',
                  options: FFButtonOptions(
                    width: 200,
                    height: 40,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-1.03, -1.02),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 54,
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: FlutterFlowTheme.of(context).primaryBtnText,
                    size: 30,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
