import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilProfesor1Widget extends StatefulWidget {
  const PerfilProfesor1Widget({Key? key}) : super(key: key);

  @override
  _PerfilProfesor1WidgetState createState() => _PerfilProfesor1WidgetState();
}

class _PerfilProfesor1WidgetState extends State<PerfilProfesor1Widget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(-0.3, -0.95),
            child: Container(
              width: 360,
              height: 80,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1, -1),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 5,
                      borderWidth: 1,
                      buttonSize: 40,
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30,
                      ),
                      onPressed: () async {
                        context.pop();
                      },
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1, 0.25),
                    child: Container(
                      width: 66,
                      height: 66,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/IMG-20211124-WA0037[1].jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    'Ivan Sequeira',
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
