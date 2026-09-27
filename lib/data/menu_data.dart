import 'package:flutter/material.dart';

final List<String> menuCategories = [
  'All',
  'Ramen',
  'Maki',
  'Drinks',
  'Add-ons',
];

final List<Map<String, dynamic>> menuItems = [
  {
    'name': 'Original Tonkotsu\nRamen',
    'category': 'Ramen',
    'price': 245.00,
    'icon': Icons.ramen_dining,
  },
  {
    'name': 'Midori Ramen',
    'category': 'Ramen',
    'price': 245.00,
    'icon': Icons.ramen_dining,
  },
  {
    'name': 'Aka Ramen',
    'category': 'Ramen',
    'price': 245.00,
    'icon': Icons.ramen_dining,
  },
  {
    'name': 'Tamago Maki',
    'category': 'Maki',
    'price': 195.00,
    'icon': Icons.set_meal,
  },
  {
    'name': 'California Maki',
    'category': 'Maki',
    'price': 195.00,
    'icon': Icons.set_meal,
  },
  {
    'name': 'Iced Tea',
    'category': 'Drinks',
    'price': 65.00,
    'icon': Icons.local_drink,
  },
  {
    'name': 'Extra Egg',
    'category': 'Add-ons',
    'price': 35.00,
    'icon': Icons.egg_alt,
  },
];