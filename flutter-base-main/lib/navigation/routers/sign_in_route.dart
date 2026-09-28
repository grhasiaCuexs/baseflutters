import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myeshop/coreapp/helpers/base_state.dart';
import 'package:myeshop/modules/auth/main/data/models/response/data_signin.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/session/session_bloc_state.dart';
import 'package:go_router/go_router.dart';
import 'package:myeshop/coreapp/di/features_injection.dart';
import 'package:myeshop/modules/auth/main/presentation/bloc/signin/signin_bloc.dart';
import 'package:myeshop/modules/auth/main/presentation/helpers/session_inherited_widget.dart';
import 'package:myeshop/modules/auth/main/presentation/ui/signin_screen.dart';
import 'package:myeshop/navigation/auth_navigation.dart';
import 'package:myeshop/navigation/main_navigation.dart';
import 'package:myeshop/navigation/root_navigation.dart';

class SignInRoute extends GoRoute {
  SignInRoute({super.routes})
      : super(
          path: AuthNavigation.location,
          name: 'sign-in',
          builder: (context, state) => BlocProvider<SignInBloc>(
            create: (context) => FeaturesInjection.get<SignInBloc>(),
            child: BlocListener<SessionBloc, BaseUiState<DataSignIn, SessionUIState>>(
              listenWhen: (previous, current) =>
                  !previous.uiData.hasLogged && current.uiData.hasLogged,
              listener: (context, sessionState) {
                final helper = RootNavigationHelper.instance;
                final redirectPath = helper.getRedirectPath();
                helper.clearRedirectPath();

                if (redirectPath != null) {
                  context.go(redirectPath);
                } else {
                  context.go(MainNavigation.location);
                }
              },
              child: SignInScreen(
                onSuccessLogin: () {
                  SessionInheritedWidget.of(context).listener.onCheckSession();
                },
              ),
            ),
          ),
        );
}
