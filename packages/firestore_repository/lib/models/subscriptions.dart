import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Subscription model
class Subscription extends Equatable {
  /// Subscription constructor
  const Subscription({
    this.name,
    this.title,
    this.benefits,
    this.enabled,
    this.icon,
    this.unitPrice,
    this.quantity,
    this.currencyId,
  });

  /// Subscription from map
  factory Subscription.fromMap(Map<String, dynamic> map) {
    IconData? icon;
    switch (map['icon'] as String?) {
      case 'check':
        icon = Icons.check;
        break;
      case 'star_border_rounded':
        icon = Icons.star_border_rounded;
        break;
    }
    return Subscription(
      name: map['name'] as String?,
      title: map['title'] as String?,
      benefits: (map['benefits'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      enabled: map['enabled'] as bool?,
      icon: icon,
      unitPrice: map['unit_price'] as int?,
      quantity: map['quantity'] as int?,
      currencyId: map['currencyId'] as String?,
    );
  }

  /// Subscription type name
  final String? name;

  /// Subscription title
  final String? title;

  /// Subscription benefits
  final List<String>? benefits;

  /// Subscription enabled
  final bool? enabled;

  /// Subscription icon
  final IconData? icon;

  /// Subscription unit price
  final int? unitPrice;

  /// Subscription quantity
  final int? quantity;

  /// Subscription currency id
  final String? currencyId;

  @override
  List<Object?> get props => [
        name,
        title,
        benefits,
        enabled,
        icon,
        unitPrice,
        quantity,
        currencyId,
      ];
}
