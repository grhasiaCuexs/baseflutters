import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myeshop/config/main_environment.dart';
import 'package:myeshop/coreapp/di/core_injection.dart';
import 'package:myeshop/coreapp/di/features_injection.dart';
import 'package:myeshop/coreapp/helpers/constants.dart';
import 'package:myeshop/l10n/common_locale.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_event.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_state.dart';
import 'package:myeshop/modules/auth/main/presentation/helpers/session_action_listener_impl.dart';
import 'package:myeshop/modules/auth/main/presentation/helpers/session_inherited_widget.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/root/domain/location/localization_setting_entity.dart';
import 'package:myeshop/navigation/root_navigation.dart';
import 'package:myeshop/style/custom_styles.dart';
import 'package:myeshop/style/theme.dart';

Future<void> main() async {
  mainCommon();
}

Future<void> mainCommon([
  EnvironmentType environmentType = EnvironmentType.dev,
]) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set ENV
  await MainEnvironment.loadEnv(environmentType);
  // Init Dependencies
  await CoreInjection.initDependencies(MainEnvironment.apiUrl);
  CoreViewInjection.init();
  RootNavigationHelper.instance;

  runApp(
    MyApp(localization: LocalizationSettingEntity(Constants.defaultLocale)),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.localization});

  final LocalizationSettingEntity? localization;

  // Todo nanti kalau udah ada setting language dibuka
  // static Widget create() {
  //   return BlocProvider<LocalizationSettingBloc>(
  //     create: (context) =>
  //         SettingLanguageInjection.get<LocalizationSettingBloc>()
  //           ..add(GetLocalizationChoosed()),
  //     child: BlocBuilder<LocalizationSettingBloc, LocalizationSettingUIState>(
  //       buildWhen: (previous, current) =>
  //           previous.requestState.data != current.requestState.data,
  //       builder: (context, state) {
  //         return MyApp(
  //           localization: state.requestState.data,
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? get _locale => widget.localization != null
      ? Locale(widget.localization!.languageCode)
      : null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionBloc>(
      create: (context) =>
          FeaturesInjection.get<SessionBloc>()..add(OnCheckSession()),
      child: BlocConsumer<SessionBloc, BaseUiState<DataSignIn, SessionUIState>>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          final isLogged = state.uiData.hasLogged;
          debugPrint("isLogged: $isLogged");
          RootNavigationHelper.router.refresh();
        },
        builder: (context, state) => SessionInheritedWidget(
          listener: SessionActionListenerImpl(context.read<SessionBloc>()),
          child: RootNavigationApp(locale: _locale),
        ),
      ),
    );
  }
}

class RootNavigationApp extends StatelessWidget {
  const RootNavigationApp({super.key, this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: MainEnvironment.appName,
      debugShowCheckedModeBanner: false,
      color: MyColors.primaryColor,
      theme: ThemeFactory.mainTheme(context),
      locale: locale,
      supportedLocales: CommonLocale.supportedLocales,
      localizationsDelegates: CommonLocale.localizationsDelegates,
      // routerConfig: router,
      routerConfig: RootNavigationHelper.router,
    );
  }
}
