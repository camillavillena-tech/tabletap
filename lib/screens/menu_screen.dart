import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/menu_category_bar.dart';
import '../widgets/menu_item_card.dart';
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String selectedCategory = 'All';

  final Map<String, int> cart = {};

  List<Map<String, dynamic>> get filteredItems {
    final search =
        _searchController.text.trim().toLowerCase();

    return menuItems.where((item) {
      final categoryMatches =
          selectedCategory == 'All' ||
          item['category'] == selectedCategory;

      final searchMatches = item['name']
          .toString()
          .toLowerCase()
          .contains(search);

      return categoryMatches && searchMatches;
    }).toList();
  }

  int get totalCartItems {
    return cart.values.fold(
      0,
      (total, quantity) => total + quantity,
    );
  }

  double get cartTotal {
    double total = 0;

    for (final item in menuItems) {
      final String name = item['name'];
      final int quantity = cart[name] ?? 0;

      total += item['price'] * quantity;
    }

    return total;
  }

  void addToCart(String name) {
    setState(() {
      cart[name] = (cart[name] ?? 0) + 1;
    });
  }

  void removeFromCart(String name) {
    setState(() {
      final quantity = cart[name] ?? 0;

      if (quantity <= 1) {
        cart.remove(name);
      } else {
        cart[name] = quantity - 1;
      }
    });
  }

  Future<void> openCart() async {
    if (cart.isEmpty) {
      return;
    }

    final updatedCart =
        await Navigator.push<Map<String, int>>(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          menuItems: menuItems,
          cart: cart,
        ),
      ),
    );

    if (updatedCart != null) {
      setState(() {
        cart
          ..clear()
          ..addAll(updatedCart);
      });
    }
  }

  void handleBottomNavigation(int index) {
    if (index == 0) {
      return;
    }

    if (index == 1) {
      openCart();
      return;
    }

    if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Order Status screen will be added later.',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF8EF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),

            MenuCategoryBar(
              categories: menuCategories,
              selectedCategory: selectedCategory,
              onSelected: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _buildMenuList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomSection(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        16,
        20,
        12,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Center(
            child: Text(
              'TableTap',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFED5A00),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 20,
                color: Color(0xFF290E07),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: _searchController,
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: 'Search menu...',
            hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
            ),
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            suffixIcon: const Icon(
              Icons.search_rounded,
              color: Color(0xFFED5A00),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFE8B99F),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFAE3C00),
                width: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuList() {
    if (filteredItems.isEmpty) {
      return const Center(
        child: Text(
          'No menu items found.',
          style: TextStyle(
            color: Color(0xFF666666),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        24,
        4,
        24,
        110,
      ),
      itemCount: filteredItems.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        final String name = item['name'];

        return MenuItemCard(
          item: item,
          quantity: cart[name] ?? 0,
          onAdd: () {
            addToCart(name);
          },
          onRemove: () {
            removeFromCart(name);
          },
        );
      },
    );
  }

  Widget _buildBottomSection() {
    return Container(
      color: const Color(0xFFFDF8EF),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (totalCartItems > 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  8,
                ),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFED5A00),
                    borderRadius:
                        BorderRadius.circular(11),
                  ),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(11),
                    onTap: openCart,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 21,
                          ),

                          const SizedBox(width: 7),

                          Text(
                            'View Cart ($totalCartItems '
                            '${totalCartItems == 1 ? 'item' : 'items'})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),

                          const Spacer(),

                          Text(
                            '₱${cartTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            AppBottomNav(
              currentIndex: 0,
              onTap: handleBottomNavigation,
            ),
          ],
        ),
      ),
    );
  }
}