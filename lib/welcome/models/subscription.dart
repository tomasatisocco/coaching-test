import 'package:coaching/l10n/l10n.dart';
import 'package:flutter/material.dart';

enum Subscription {
  none,
  basic,
  premium,
  mensual,
  anual;

  String title(AppLocalizations l10n) {
    switch (this) {
      case Subscription.none:
        return 'Ninguno';
      case Subscription.basic:
        return 'Básico';
      case Subscription.premium:
        return 'Premium';
      case Subscription.mensual:
        return 'Mensual';
      case Subscription.anual:
        return 'Anual';
    }
  }

  IconData get icon {
    switch (this) {
      case Subscription.none:
        return Icons.cancel;
      case Subscription.basic:
        return Icons.check;
      case Subscription.premium:
        return Icons.star_border_rounded;
      case Subscription.mensual:
        return Icons.sports_handball_rounded;
      case Subscription.anual:
        return Icons.rocket_launch_outlined;
    }
  }

  double get price {
    switch (this) {
      case Subscription.none:
        return 0;
      case Subscription.basic:
        return 9.99;
      case Subscription.premium:
        return 19.99;
      case Subscription.mensual:
        return 9.99;
      case Subscription.anual:
        return 99.99;
    }
  }

  List<String> benefits(AppLocalizations l10n) {
    // TODO: localize
    switch (this) {
      case Subscription.none:
        return [];
      case Subscription.basic:
        return [
          'Realizar GPS VCC',
          'Recibir Informe personalizado por email.',
        ];
      case Subscription.premium:
        return [
          'Realizar GPS VCC',
          'Recibir Informe personalizado por email.',
          'Agendar sesiones de coaching.',
        ];
      case Subscription.mensual:
        return [
          'Realizar GPS VCC mensualmente',
          'Recibir Informe personalizado por email.',
          'Agendar sesiones de coaching mensuales',
        ];
      case Subscription.anual:
        return [
          'Realizar GPS VCC mensualmente',
          'Recibir Informe personalizado por email.',
          'Agendar sesiones de coaching mensuales',
          'Ahorro de 20%'
        ];
    }
  }
}
