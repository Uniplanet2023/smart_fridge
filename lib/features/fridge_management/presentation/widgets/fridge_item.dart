import 'package:flutter/material.dart';
import 'package:smart_fridge/core/util/date_expiry_format.dart';

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
              Transform.scale(
                scale: 0.75,
                child: Checkbox(
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
              ),
              Expanded(
                child: Text(
                  widget.itemName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
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
                  const SizedBox(width: 2),
                  Text(
                    ' ${DateExpiryFormatter(widget.expiryDate).format()}',
                    style: Theme.of(context).textTheme.labelLarge,
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
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${widget.quantity}',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: widget.onChangeItemDetails,
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: widget.onDeleteItem,
                    child: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
