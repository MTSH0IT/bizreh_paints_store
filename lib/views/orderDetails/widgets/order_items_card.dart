import 'package:bizreh_paints_store/models/cart_item_model.dart';
import 'package:bizreh_paints_store/models/product_model.dart';
import 'package:flutter/material.dart';

class OrderItemsCard extends StatelessWidget {
  OrderItemsCard({super.key});
  final List<CartItemModel> cartItems = [
    CartItemModel(
      product: ProductModel(
        title: "Paint 1",
        subTitle: "Paint",
        description: "Paint",
        price: 10.0,
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s",
      ),
      quantity: 1,
    ),
    CartItemModel(
      product: ProductModel(
        title: "Paint 2",
        subTitle: "Paint",
        description: "Paint",
        price: 10.0,
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXh0jbwHf8ilhZiuSgraDthUCCn6kke6Lwgw&s",
      ),
      quantity: 2,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Items Ordered",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return ItemOredr(cartItems: cartItems[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.black26, thickness: 1);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemOredr extends StatelessWidget {
  const ItemOredr({super.key, required this.cartItems});

  final CartItemModel cartItems;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(cartItems.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItems.product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "\$${(cartItems.product.price * cartItems.quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${cartItems.quantity}',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
