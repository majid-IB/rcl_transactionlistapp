
import 'package:flutter/material.dart';

import '../localization/app_localization.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(AppLocalizations.translate('loading', 'en')),
        ],
      ),
    );
  }
}