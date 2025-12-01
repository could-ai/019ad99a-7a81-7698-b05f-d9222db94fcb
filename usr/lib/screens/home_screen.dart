import 'package:flutter/material.dart';
import '../models/gift.dart';
import 'add_gift_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy data for initial display
  final List<Gift> _gifts = [
    Gift(
      id: '1',
      name: 'Wireless Headphones',
      price: 199.99,
      recipient: 'Alice',
      occasion: 'Birthday',
      isPurchased: false,
    ),
    Gift(
      id: '2',
      name: 'Coffee Maker',
      price: 89.50,
      recipient: 'Bob',
      occasion: 'Housewarming',
      isPurchased: true,
    ),
    Gift(
      id: '3',
      name: 'Vintage Watch',
      price: 250.00,
      recipient: 'Charlie',
      occasion: 'Anniversary',
      isPurchased: false,
    ),
  ];

  void _addGift(Gift gift) {
    setState(() {
      _gifts.add(gift);
    });
  }

  void _togglePurchased(int index) {
    setState(() {
      final gift = _gifts[index];
      _gifts[index] = gift.copyWith(isPurchased: !gift.isPurchased);
    });
  }

  void _deleteGift(int index) {
    setState(() {
      _gifts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gift Tracker'),
        centerTitle: true,
      ),
      body: _gifts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.card_giftcard, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No gifts added yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap the + button to add a gift idea'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _gifts.length,
              itemBuilder: (context, index) {
                final gift = _gifts[index];
                return Dismissible(
                  key: Key(gift.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => _deleteGift(index),
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: gift.isPurchased
                            ? Colors.green.withOpacity(0.2)
                            : Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Icon(
                          gift.isPurchased
                              ? Icons.check
                              : Icons.card_giftcard,
                          color: gift.isPurchased
                              ? Colors.green
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      title: Text(
                        gift.name,
                        style: TextStyle(
                          decoration: gift.isPurchased
                              ? TextDecoration.lineThrough
                              : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.person, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(gift.recipient),
                              const SizedBox(width: 12),
                              Icon(Icons.event, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(gift.occasion),
                            ],
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${gift.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () => _togglePurchased(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGiftScreen()),
          );

          if (result != null && result is Gift) {
            _addGift(result);
          }
        },
        label: const Text('Add Gift'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
