import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState());

  void selectLanguage(AppLanguage language) =>
      emit(state.copyWith(language: language));
}
