import 'package:hydrated_bloc/hydrated_bloc.dart';

//-------------------------------------------------------------
// Theme Bloc
//-------------------------------------------------------------

const String _hydratedBlocName = 'confessionTheme'; //'${Constants.projectName}Theme';

/// Base class for theme-related events
abstract class ThemeEvent {}

/// Event to change the theme (dark/light mode)
class ChangeTheme extends ThemeEvent {
  ChangeTheme({required this.themeNumber});

  final int themeNumber;
}

/// Bloc for managing the theme setting
/// reutruns integer
class ThemeBloc extends HydratedBloc<ThemeEvent, int> {
  ThemeBloc() : super(8) { // sepiaLight
    on<ChangeTheme>((event, emit) => emit(event.themeNumber));
  }

  @override
  int? fromJson(Map<String, dynamic> json) {
    try {
      return json[_hydratedBlocName] as int?;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(int state) => {_hydratedBlocName: state};

  @override
  String get id => _hydratedBlocName;
}
