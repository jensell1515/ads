import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import '../flutter_flow_theme.dart';
import '../../backend/backend.dart';
import '../../auth/firebase_user_provider.dart';

import '../../index.dart';
import '../../main.dart';
import '../lat_lng.dart';
import '../place.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AcademiaDelSaberFirebaseUser? initialUser;
  AcademiaDelSaberFirebaseUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(AcademiaDelSaberFirebaseUser newUser) {
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    if (notifyOnAuthChange) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, _) =>
          appStateNotifier.loggedIn ? InicioWidget() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? InicioWidget() : LoginWidget(),
          routes: [
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
              name: 'cursoingles',
              path: 'cursoingles',
              builder: (context, params) => CursoinglesWidget(),
            ),
            FFRoute(
              name: 'cursohistoria',
              path: 'cursohistoria',
              builder: (context, params) => CursohistoriaWidget(),
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
            ),
            FFRoute(
              name: 'clase2historia',
              path: 'clase2historia',
              builder: (context, params) => Clase2historiaWidget(),
            ),
            FFRoute(
              name: 'clase2quimica',
              path: 'clase2quimica',
              builder: (context, params) => Clase2quimicaWidget(),
            ),
            FFRoute(
              name: 'clase3historia',
              path: 'clase3historia',
              builder: (context, params) => Clase3historiaWidget(),
            ),
            FFRoute(
              name: 'clase4historia',
              path: 'clase4historia',
              builder: (context, params) => Clase4historiaWidget(),
            ),
            FFRoute(
              name: 'clase5historia',
              path: 'clase5historia',
              builder: (context, params) => Clase5historiaWidget(),
            ),
            FFRoute(
              name: 'clase6historia',
              path: 'clase6historia',
              builder: (context, params) => Clase6historiaWidget(),
            ),
            FFRoute(
              name: 'clase1quimica',
              path: 'clase1quimica',
              builder: (context, params) => Clase1quimicaWidget(),
            ),
            FFRoute(
              name: 'clase3quimica',
              path: 'clase3quimica',
              builder: (context, params) => Clase3quimicaWidget(),
            ),
            FFRoute(
              name: 'clase4quimica',
              path: 'clase4quimica',
              builder: (context, params) => Clase4quimicaWidget(),
            ),
            FFRoute(
              name: 'clase5quimica',
              path: 'clase5quimica',
              builder: (context, params) => Clase5quimicaWidget(),
            ),
            FFRoute(
              name: 'clase6quimica',
              path: 'clase6quimica',
              builder: (context, params) => Clase6quimicaWidget(),
            ),
            FFRoute(
              name: 'clase1lengua',
              path: 'clase1lengua',
              builder: (context, params) => Clase1lenguaWidget(),
            ),
            FFRoute(
              name: 'clase2lengua',
              path: 'clase2lengua',
              builder: (context, params) => Clase2lenguaWidget(),
            ),
            FFRoute(
              name: 'clase4lengua',
              path: 'clase4lengua',
              builder: (context, params) => Clase4lenguaWidget(),
            ),
            FFRoute(
              name: 'clase3lengua',
              path: 'clase3lengua',
              builder: (context, params) => Clase3lenguaWidget(),
            ),
            FFRoute(
              name: 'clase1AEP',
              path: 'clase1AEP',
              builder: (context, params) => Clase1AEPWidget(),
            ),
            FFRoute(
              name: 'clase2AEP',
              path: 'clase2AEP',
              builder: (context, params) => Clase2AEPWidget(),
            ),
            FFRoute(
              name: 'clase3AEP',
              path: 'clase3AEP',
              builder: (context, params) => Clase3AEPWidget(),
            ),
            FFRoute(
              name: 'clase1matematica',
              path: 'clase1matematica',
              builder: (context, params) => Clase1matematicaWidget(),
            ),
            FFRoute(
              name: 'clase2matematicas',
              path: 'clase2matematicas',
              builder: (context, params) => Clase2matematicasWidget(),
            ),
            FFRoute(
              name: 'clase3matematicas',
              path: 'clase3matematicas',
              builder: (context, params) => Clase3matematicasWidget(),
            ),
            FFRoute(
              name: 'clase4matematicas',
              path: 'clase4matematicas',
              builder: (context, params) => Clase4matematicasWidget(),
            ),
            FFRoute(
              name: 'clase1geografia',
              path: 'clase1geografia',
              builder: (context, params) => Clase1geografiaWidget(),
            ),
            FFRoute(
              name: 'clase2geografia',
              path: 'clase2geografia',
              builder: (context, params) => Clase2geografiaWidget(),
            ),
            FFRoute(
              name: 'clase3geografia',
              path: 'clase3geografia',
              builder: (context, params) => Clase3geografiaWidget(),
            ),
            FFRoute(
              name: 'clase4geografia',
              path: 'clase4geografia',
              builder: (context, params) => Clase4geografiaWidget(),
            ),
            FFRoute(
              name: 'clase5geografia',
              path: 'clase5geografia',
              builder: (context, params) => Clase5geografiaWidget(),
            ),
            FFRoute(
              name: 'clase6geografia',
              path: 'clase6geografia',
              builder: (context, params) => Clase6geografiaWidget(),
            ),
            FFRoute(
              name: 'paginaprofesor1',
              path: 'paginaprofesor1',
              builder: (context, params) => Paginaprofesor1Widget(),
            ),
            FFRoute(
              name: 'paginaProfesor2',
              path: 'paginaProfesor2',
              builder: (context, params) => PaginaProfesor2Widget(),
            ),
            FFRoute(
              name: 'paginaProfesor3',
              path: 'paginaProfesor3',
              builder: (context, params) => PaginaProfesor3Widget(),
            ),
            FFRoute(
              name: 'paginaProfesor4',
              path: 'paginaProfesor4',
              builder: (context, params) => PaginaProfesor4Widget(),
            ),
            FFRoute(
              name: 'paginaProfesor5',
              path: 'paginaProfesor5',
              builder: (context, params) => PaginaProfesor5Widget(),
            ),
            FFRoute(
              name: 'paginaProfesor6',
              path: 'paginaProfesor6',
              builder: (context, params) => PaginaProfesor6Widget(),
            ),
            FFRoute(
              name: 'premium',
              path: 'premium',
              builder: (context, params) => PremiumWidget(),
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

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> params = const <String, String>{},
    Map<String, String> queryParams = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              params: params,
              queryParams: queryParams,
              extra: extra,
            );
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState =>
      (routerDelegate.refreshListenable as AppStateNotifier);
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void setRedirectLocationIfUnset(String location) =>
      (routerDelegate.refreshListenable as AppStateNotifier)
          .updateNotifyOnAuthChange(false);
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
    String? collectionName,
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
    return deserializeParam<T>(param, type, isList, collectionName);
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
        redirect: (state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                  ),
                )
              : page;

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
