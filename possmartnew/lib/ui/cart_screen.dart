import 'package:flutter/material.dart';
import 'package:possmartnew/ui/chechoutscreen.dart';
import 'home_screen.dart';

class CartItem {
  final String name;
  final double price;
  final image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    this.quantity = 1,
    required this.image,
  });
}

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartItemCard(cartItem: cartItems[index]);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total: \$${calculateTotal(cartItems).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(),
                      ));
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal(List<CartItem> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${cartItem.quantity}'),
        ),
        title: Text(cartItem.name),
        subtitle: Text('\$${cartItem.price.toStringAsFixed(2)} each'),
        trailing: Text(
            '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
      ),
    );
  }
}
