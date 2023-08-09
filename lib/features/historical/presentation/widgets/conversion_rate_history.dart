import 'package:flutter/material.dart';

import '../../domain/entities/conversion_rate_history_item_entity.dart';

class ConversionRateHistory extends StatelessWidget {
  const ConversionRateHistory({
    super.key,
    required this.details,
  });
  final List<ConversionRateHistoryItemEntity> details;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          details.length,
          (index) => ListTile(
            title: Text(
              details[index].date,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Text(
              '\$${details[index].val}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        )
      ],
    );
  }
}
