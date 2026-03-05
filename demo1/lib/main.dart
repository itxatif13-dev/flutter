import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie Express',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
    );
  }
}

class FoodItem {
  final String name;
  final double price;
  final String category;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<FoodItem> _menu = [
    FoodItem(
      name: 'Classic Burger',
      price: 8.99,
      category: 'Burgers',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80',
    ),
    FoodItem(
      name: 'Hot Chips',
      price: 3.99,
      category: 'Sides',
      imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=500&q=80',
    ),
    FoodItem(
      name: 'Spicy Noodles',
      price: 11.00,
      category: 'Noodles',
      imageUrl: 'https://images.unsplash.com/photo-1552611052-33e04de081de?w=500&q=80',
    ),
    FoodItem(
      name: 'Pepperoni Pizza',
      price: 14.50,
      category: 'Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500&q=80',
    ),
    FoodItem(
      name: 'Garden Salad',
      price: 7.50,
      category: 'Healthy',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=500&q=80',
    ),
    FoodItem(
      name: 'Iced Cola',
      price: 2.50,
      category: 'Drinks',
      imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500&q=80',
    ),
  ];

  final Map<FoodItem, int> _cart = {};

  void _addToCart(FoodItem item) {
    setState(() {
      _cart[item] = (_cart[item] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} added to cart!'),
        duration: const Duration(milliseconds: 500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removeFromCart(FoodItem item) {
    setState(() {
      if (_cart.containsKey(item)) {
        if (_cart[item]! > 1) {
          _cart[item] = _cart[item]! - 1;
        } else {
          _cart.remove(item);
        }
      }
    });
  }

  double get _totalPrice {
    return _cart.entries
        .fold(0, (sum, entry) => sum + (entry.key.price * entry.value));
  }

  int get _cartCount => _cart.values.fold(0, (sum, count) => sum + count);

  void _showBill() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Order',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: _cart.length,
                  itemBuilder: (context, index) {
                    final item = _cart.keys.elementAt(index);
                    final qty = _cart[item]!;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('\$${item.price.toStringAsFixed(2)} x $qty'),
                              ],
                            ),
                          ),
                          Text(
                            '\$${(item.price * qty).toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  Text(
                    '\$${_totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() => _cart.clear());
                  _showSuccessDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: const Text('CHECKOUT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.stars, color: Colors.amber, size: 80),
            const SizedBox(height: 16),
            const Text('Order Placed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Your food is being prepared with love.', textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Menu'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Foodie', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28)),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 30),
                onPressed: _cart.isEmpty ? null : _showBill,
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text('$_cartCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Fresh & Fast Food\nWaiting for you!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300)),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _menu.length,
              itemBuilder: (context, index) {
                final item = _menu[index];
                final qty = _cart[item] ?? 0;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50, color: Colors.grey),
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$${item.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepOrange)),
                                Container(
                                  decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                                  child: IconButton(
                                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                                    onPressed: () => _addToCart(item),
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(6),
                                  ),
                                ),
                              ],
                            ),
                            if (qty > 0)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _removeFromCart(item),
                                      child: const Icon(Icons.remove_circle_outline, size: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                    GestureDetector(
                                      onTap: () => _addToCart(item),
                                      child: const Icon(Icons.add_circle_outline, size: 20),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
