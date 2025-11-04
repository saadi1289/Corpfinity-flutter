import 'package:hive/hive.dart';

part 'enums.g.dart';

/// Energy level options for activity recommendations
@HiveType(typeId: 7)
enum EnergyLevel {
  @HiveField(0)
  low,
  
  @HiveField(1)
  medium,
  
  @HiveField(2)
  high;

  String get displayName {
    switch (this) {
      case EnergyLevel.low:
        return 'Low';
      case EnergyLevel.medium:
        return 'Medium';
      case EnergyLevel.high:
        return 'High';
    }
  }
}

/// Activity difficulty levels
@HiveType(typeId: 8)
enum Difficulty {
  @HiveField(0)
  low,
  
  @HiveField(1)
  medium,
  
  @HiveField(2)
  high;

  String get displayName {
    switch (this) {
      case Difficulty.low:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.high:
        return 'Hard';
    }
  }
}

/// Single Sign-On provider options
@HiveType(typeId: 9)
enum SSOProvider {
  @HiveField(0)
  google,
  
  @HiveField(1)
  microsoft;

  String get displayName {
    switch (this) {
      case SSOProvider.google:
        return 'Google';
      case SSOProvider.microsoft:
        return 'Microsoft';
    }
  }
}
