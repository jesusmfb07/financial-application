import 'package:exercises_flutter2/%20settings/application/ports/settings_port.dart';
import 'package:flutter/material.dart';


abstract class NavigateToRemindersPageUseCase {
  Future<void> execute();
}

abstract class NavigateToCategoriesPageUseCase {
  Future<void> execute();
}

abstract class NavigateToProvidersPageUseCase {
  Future<void> execute();
}

abstract class NavigateToCurrencyPageUseCase {
  Future<void> execute();
}