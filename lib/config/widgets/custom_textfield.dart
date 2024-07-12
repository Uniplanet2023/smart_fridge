import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool enabled;
  final TextInputType keyboardType;
  final dynamic inputFormatters;
  final String prefixText;
  final bool obscureText;
  final bool validatorEnabled;
  final bool? isPassword;
  final int? maxLength;
  final Color? borderColor;
  final Icon? prefixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.maxLines = 1,
    this.inputFormatters,
    this.prefixText = "",
    this.obscureText = false,
    this.validatorEnabled = true,
    this.maxLength,
    this.borderColor,
    this.isPassword,
    this.prefixIcon,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget
        .obscureText; // Initialize with widget's original obscureText value
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: _obscureText, // Use the state variable here
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        prefixText: widget.prefixText,
        hintText: widget.hintText,
        suffixIcon: widget.isPassword != null && widget.isPassword!
            ? IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: _togglePasswordVisibility,
              )
            : const SizedBox(),
      ),
      validator: (val) {
        if (!widget.validatorEnabled) {
          return null;
        }
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
    );
  }
}
