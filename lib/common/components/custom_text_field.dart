import 'package:flutter/material.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';
import 'package:technical_assesment/core/theme/styles.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Widget? suffix;
  final Widget? preffix;
  final FocusNode? focusNode;
  final int? maxLine;
  final int? minLine;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? obscured;
  final bool? outline;
  final bool? autofocus;
  final bool? hasElevation;
  final InputBorder? errorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final String? Function(String?)? onSaved;
  final GlobalKey<FormFieldState<dynamic>>? formKey;
  final OutlineInputBorder? border;

  const CustomTextField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.controller,
      this.onChanged,
      this.enabled,
      this.contentPadding,
      this.textInputAction,
      this.obscured = false,
      this.fillColor,
      this.focusNode,
      this.outline = false,
      this.autofocus = false,
      this.hasElevation = true,
      this.formKey,
      this.minLine,
      this.onFieldSubmitted,
      this.onSaved,
      this.errorBorder, this.border})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: widget.validator,
        key: widget.formKey,
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,
        keyboardType: widget.inputType,
        cursorColor: Theme.of(context).colorScheme.onBackground,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        onSaved: widget.onSaved,
        obscureText: widget.obscured!,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus!,
        minLines: widget.minLine,
        textInputAction: widget.textInputAction,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground, fontSize: 13),
        decoration: outlinedTextFieldDecoration.copyWith(
            fillColor: widget.fillColor ?? black2,
            hintText: widget.hint,
            suffix: widget.suffix,
            border: widget.border ??
                OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: const BorderSide(
                      color: grey1,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(10))
              ,
            focusedBorder: widget.outline!
                ? OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10))
                : null,
            errorBorder: widget.border ?? errorBorder,
            prefixIcon: widget.preffix,
            prefixIconColor: Colors.grey,
            suffixIconColor: Theme.of(context).colorScheme.primary,
            enabled: widget.enabled,
            contentPadding: widget.contentPadding ?? const EdgeInsets.all(18),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
      ),
    );
  }
}
