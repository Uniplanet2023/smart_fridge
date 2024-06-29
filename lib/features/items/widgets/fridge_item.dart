import 'package:flutter/material.dart';
import 'package:smart_fridge/constants/date_expiry_format.dart';

class FridgeItem extends StatefulWidget {
  final String itemName;
  final double quantity;
  final DateTime expiryDate;
  final bool isChecked;
  final Function(bool?)? checkboxOnChange;
  final Function()? onChangeItemDetails;
  final Function()? onDeleteItem;

  const FridgeItem({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.expiryDate,
    required this.isChecked,
    this.checkboxOnChange,
    required this.onChangeItemDetails,
    required this.onDeleteItem,
  });

  @override
  State<FridgeItem> createState() => _FridgeItemsState();
}

class _FridgeItemsState extends State<FridgeItem> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                  if (widget.checkboxOnChange != null) {
                    widget.checkboxOnChange!(value);
                  }
                },
              ),
              Expanded(
                child: Text(
                  widget.itemName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle_sharp,
                    size: 15,
                    color:
                        (widget.expiryDate.difference(DateTime.now()).inDays <
                                3)
                            ? Colors.red
                            : (widget.expiryDate
                                            .difference(DateTime.now())
                                            .inDays >=
                                        3 &&
                                    widget.expiryDate
                                            .difference(DateTime.now())
                                            .inDays <=
                                        7)
                                ? Colors.amber.shade600
                                : Colors.green,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ' ${DateExpiryFormatter(widget.expiryDate).format()}',
                    style: const TextStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 47, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Quantity: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: widget.onChangeItemDetails,
                    child: const Icon(Icons.edit),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: widget.onDeleteItem,
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 10,
          thickness: 1,
        ),
      ],
    );
  }
}
