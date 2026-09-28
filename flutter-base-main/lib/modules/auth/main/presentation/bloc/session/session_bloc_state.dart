import 'package:equatable/equatable.dart';

/// DTO untuk state UI khusus pada SessionBloc.
/// Ini bukan lagi subclass dari BaseUiState, melainkan data payload
/// yang akan disisipkan ke dalam sealed class BaseUiState<T, SessionUIState>.
class SessionUIState extends Equatable {
  const SessionUIState({
    this.hasSplashScreenStart = false,
    this.statusLoggedInit = false,
  });

  final bool hasSplashScreenStart;
  final bool statusLoggedInit;

  bool get hasLogged => statusLoggedInit;

  SessionUIState copyWith({
    bool? statusLoggedInit,
    bool? hasSplashScreenStart,
  }) {
    return SessionUIState(
      statusLoggedInit: statusLoggedInit ?? this.statusLoggedInit,
      hasSplashScreenStart: hasSplashScreenStart ?? this.hasSplashScreenStart,
    );
  }

  @override
  List<Object?> get props => [statusLoggedInit, hasSplashScreenStart];
}
