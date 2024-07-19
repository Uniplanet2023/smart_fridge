import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? ontap;
  final Color? color;
  final Switch? transition;

  const MenuSection(
      {super.key,
      required this.title,
      required this.icon,
      this.ontap,
      this.color,
      this.transition});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      tileColor: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      title: Text(
        title,
        style:
            Theme.of(context).textTheme.headlineMedium?.copyWith(color: color),
      ),
      leading: Icon(
        icon,
        color: color,
      ),
      trailing:
          (transition != null) ? transition : const Icon(Icons.arrow_forward),
      onTap: ontap,
    );
  }
}
