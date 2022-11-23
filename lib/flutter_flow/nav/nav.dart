import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) => LoginCopyWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => LoginCopyWidget(),
          routes: [
            FFRoute(
              name: 'loginCopy',
              path: 'loginCopy',
              builder: (context, params) => LoginCopyWidget(),
            ),
            FFRoute(
              name: 'login',
              path: 'login',
              builder: (context, params) => LoginWidget(),
            ),
            FFRoute(
              name: 'Inicio',
              path: 'inicio',
              builder: (context, params) => InicioWidget(),
            ),
            FFRoute(
              name: 'escuelas',
              path: 'escuelas',
              builder: (context, params) => EscuelasWidget(),
            ),
            FFRoute(
              name: 'cursos',
              path: 'cursos',
              builder: (context, params) => CursosWidget(),
            ),
            FFRoute(
              name: 'cursosociales',
              path: 'cursosociales',
              builder: (context, params) => CursosocialesWidget(),
            ),
            FFRoute(
              name: 'cursoquimica',
              path: 'cursoquimica',
              builder: (context, params) => CursoquimicaWidget(),
            ),
            FFRoute(
              name: 'Cursodelengua',
              path: 'cursodelengua',
              builder: (context, params) => CursodelenguaWidget(),
            ),
            FFRoute(
              name: 'CursosAEP',
              path: 'cursosAEP',
              builder: (context, params) => CursosAEPWidget(),
            ),
            FFRoute(
              name: 'CursoMatematica',
              path: 'cursoMatematica',
              builder: (context, params) => CursoMatematicaWidget(),
            ),
            FFRoute(
              name: 'CursosTAC',
              path: 'cursosTAC',
              builder: (context, params) => CursosTACWidget(),
            ),
            FFRoute(
              name: 'cursosGeografia',
              path: 'cursosGeografia',
              builder: (context, params) => CursosGeografiaWidget(),
            ),
            FFRoute(
              name: 'clase1ingles',
              path: 'clase1ingles',
              builder: (context, params) => Clase1inglesWidget(),
            ),
            FFRoute(
              name: 'clase2ingles',
              path: 'clase2ingles',
              builder: (context, params) => Clase2inglesWidget(),
            ),
            FFRoute(
              name: 'clase3ingles',
              path: 'clase3ingles',
              builder: (context, params) => Clase3inglesWidget(),
            ),
            FFRoute(
              name: 'clase4ingles',
              path: 'clase4ingles',
              builder: (context, params) => Clase4inglesWidget(),
            ),
            FFRoute(
              name: 'clase5ingles',
              path: 'clase5ingles',
              builder: (context, params) => Clase5inglesWidget(),
            ),
            FFRoute(
              name: 'clase6ingles',
              path: 'clase6ingles',
              builder: (context, params) => Clase6inglesWidget(),
            ),
            FFRoute(
              name: 'clase1Historia',
              path: 'clase1Historia',
              builder: (context, params) => Clase1HistoriaWidget(),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ).toRoute(appStateNotifier),
      ],
      urlPathStrategy: UrlPathStrategy.path,
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(params)
    ..addAll(queryParams)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}
