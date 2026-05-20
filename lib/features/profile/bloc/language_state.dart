import 'package:equatable/equatable.dart';

enum AppLanguage { english, indonesia }

class LanguageState extends Equatable {
  final AppLanguage language;

  const LanguageState({this.language = AppLanguage.english});

  LanguageState copyWith({AppLanguage? language}) =>
      LanguageState(language: language ?? this.language);

  String get displayName =>
      language == AppLanguage.english ? 'English' : 'Indonesia';

  String get flagEmoji =>
      language == AppLanguage.english ? '🇬🇧' : '🇮🇩';

  @override
  List<Object> get props => [language];
}
