import 'package:demo_shop/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../utility/widgets/sized_box_widgets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final String? labelText;
  final String hintText;
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.onSubmitted,
      this.onChanged,
      this.onEditingComplete,
      required this.hintText,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Text(
            labelText!,
            style: const TextStyle(fontSize: 12),
          ),
        if (labelText != null) size6H,
        TextFormField(
          controller: controller,
          validator: (val) {
            if (labelText != null && val != null && val == '') {
              return 'Field not empty';
            }
            return null;
          },
          autofocus: false,
          autovalidateMode:
              labelText != null ? AutovalidateMode.onUserInteraction : null,
          onFieldSubmitted: onSubmitted,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              isDense: labelText != null ? false : true,
              fillColor: Colors.white,
              filled: true,
              enabledBorder: borderOutline(),
              focusedBorder: borderOutline(),
              errorBorder: borderOutline(),
              suffixIcon: labelText != null
                  ? null
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(
                        Icons.search_rounded,
                        color: primaryColor,
                        size: 22,
                      ),
                    ),
              suffixIconConstraints: const BoxConstraints(maxHeight: 20),
              focusedErrorBorder: borderOutline(),
              hintText: hintText,
              contentPadding: labelText != null
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.fromLTRB(10, 10, 10, 0)),
        ),
      ],
    );
  }

  OutlineInputBorder borderOutline({bool error = false}) {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(6)));
  }
}
