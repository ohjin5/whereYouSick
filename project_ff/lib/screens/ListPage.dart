import 'package:flutter/material.dart';

class Product {
  final String name;

  const Product({required this.name});
}

typedef void CartChangedCallback(Product product, bool inCart);

class ListItem extends StatelessWidget {
  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  ListItem(
      {required Product product,
      required this.inCart,
      required this.onCartChanged})
      : product = product,
        super(key: ObjectKey(product));

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart); // 버튼 누를시 반응 설정.
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text('✔'),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class NoticetList extends StatefulWidget {
  final List<Product> products;

  const NoticetList({Key? key, required this.products}) : super(key: key);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<NoticetList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (!inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
