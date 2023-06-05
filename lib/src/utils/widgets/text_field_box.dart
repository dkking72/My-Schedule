import '../../../src_exports.dart';

class TextFiledBox extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final int maxLength;
  final bool? expands;
  final TextEditingController controller;
  final TextInputType textInputType;
  final List<TextInputFormatter> filteringTextInputFormatter;
  final String? initialValue;
  final String? counterText;
  final FormFieldValidator<String> validator;
  final bool? enabled;
  final String? labelText;
  final bool? readOnly;

  const TextFiledBox(
      {super.key,
      required this.hintText,
      required this.maxLines,
      required this.maxLength,
      this.expands,
      required this.textInputType,
      required this.controller,
      required this.filteringTextInputFormatter,
      this.initialValue,
      required this.validator,
      this.counterText,
      this.enabled,
      this.labelText, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60,
          width: double.maxFinite,
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [
            BoxShadow(color: Color.fromRGBO(143, 148, 251, 0.3), blurRadius: 20.0, offset: Offset(0, 10))
          ]),
        ),
        TextFormField(
            inputFormatters: filteringTextInputFormatter,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            initialValue: initialValue,
            enabled: enabled,
            focusNode: FocusNode(),
            controller: controller,
            keyboardType: textInputType,
            maxLength: maxLength,
            maxLines: maxLines,
            expands: expands ?? false,
            readOnly: readOnly ?? false,
            autofocus: false,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              counterText: counterText == null ? "" : null,
              hintStyle: const TextStyle(color: AppColors.greyColor),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.purple, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.purple, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.redColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.redColor)),
            ))
      ],
    );
  }
}
