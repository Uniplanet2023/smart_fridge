// import 'package:flutter/material.dart';
// import 'package:smart_fridge/core/entities/item.dart';
// import 'package:smart_fridge/features/receipt_scanning/presentation/pages/edit_page.dart';
// import 'package:smart_fridge/features/receipt_scanning/presentation/pages/new_items_page.dart';

// class ItemListScreen extends StatefulWidget {
//   final List<Item> items;
//   const ItemListScreen({super.key, required this.items});

//   @override
//   ItemListScreenState createState() => ItemListScreenState();
// }

// class ItemListScreenState extends State<ItemListScreen> {
//   void _editItem(Item item) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => EditItemPage(
//           item: item,
//           onSave: (updatedItem) {
//             setState(() {
//               // final index = items.indexWhere((i) => i.id == updatedItem.id);
//               // if (index != -1) {
//               //   items[index] = updatedItem;
//               // }
//             });
//           },
//         ),
//       ),
//     );
//   }

//   void _deleteItem(Item item) {
//     setState(() {
//       widget.items.remove(item);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ItemListPage(
//       items: widget.items,
//       // onEdit: _editItem,
//       // onDelete: _deleteItem,
//     );
//   }
// }
