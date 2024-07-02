import 'package:flutter/material.dart';

import '../../../../../../shared/categories/application/use_cases/category_use_case.dart';
import '../../../../../../shared/categories/domain/aggregates/category_aggregate.dart';
import '../../../../../../shared/providers/application/use_cases/provider_use_case.dart';
import '../../../../../../shared/providers/domain/aggregates/provider_aggregate.dart';
import '../../../../../application/use_cases/egress_use_case.dart';
import '../../../../../domain/aggregates/egress_aggregate.dart';
import '../../../../../domain/entities/egress_entry_entity.dart';


class EgressEntryForm extends StatefulWidget {
  final CreateEgressEntryUseCase createEntryUseCase;
  final UpdateEgressEntryUseCase updateEntryUseCase;
  final EgressEntryAggregate aggregate;
  final CategoryAggregate categoryAggregate;
  final ProviderAggregate providerAggregate;
  final CreateCategoryUseCase createCategoryUseCase;
  final CreateProviderUseCase createProviderUseCase;
  final EgressEntry? entry;
  final VoidCallback onSave;
  final String defaultCurrencySymbol;

  EgressEntryForm({
    required this.createEntryUseCase,
    required this.updateEntryUseCase,
    required this.aggregate,
    required this.categoryAggregate,
    required this.providerAggregate,
    required this.createCategoryUseCase,
    required this.createProviderUseCase,
    this.entry,
    required this.onSave,
    required this.defaultCurrencySymbol,
  });

    @override
    _EgressEntryFormState createState() => _EgressEntryFormState();
  }
