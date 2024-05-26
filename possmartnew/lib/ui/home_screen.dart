import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:possmartnew/ui/auth/login_screen.dart';
import 'package:possmartnew/ui/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  List<CartItem> cartItems = [];
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void _showSnackbar(String productName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$productName added to cart!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addToCart(Product product) {
    // Check if the product is already in the cart
    bool isInCart = cartItems.any((item) => item.name == product.name);

    if (isInCart) {
      // If the product is already in the cart, increase the quantity
      setState(() {
        cartItems.firstWhere((item) => item.name == product.name).quantity++;
      });
    } else {
      // If the product is not in the cart, add it as a new cart item
      setState(() {
        cartItems.add(CartItem(
          name: product.name,
          price: product.price,
          quantity: 1,
          image: const AssetImage('assets/'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product(
        name: 'T-Shirt',
        description: 'Comfortable and stylish t-shirt',
        imageUrl: 'assets/tshirt.jpg',
        price: 20.99,
      ),
      Product(
        name: 'Pants',
        description: 'Casual and trendy pants',
        imageUrl: 'assets/pant.jpg',
        price: 34.99,
      ),
      // Add more products as needed
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('HomeScreen'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems)),
                );
              },
              icon: const Icon(Icons.shopping_cart)),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Perform the logout action and navigate to the login page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 8.0, // Spacing between rows
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            addToCart: _addToCart,
            showSnackbar: _showSnackbar,
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) addToCart;
  final Function(String) showSnackbar;

  ProductCard({
    super.key,
    required this.product,
    required this.addToCart,
    required this.showSnackbar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  product.description,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    addToCart(product);
                    showSnackbar(product.name);
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
