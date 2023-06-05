import '../../../src_exports.dart';

class DisableTextField extends StatelessWidget {
  final String labelName;
  final TextEditingController? controller;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> filteringTextInputFormatter;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final String? initialValue;

  const DisableTextField(
      {super.key,
      required this.labelName,
      this.controller,
      required this.enabled,
      required this.validator,
      required this.filteringTextInputFormatter,
      this.onTap,
      this.readOnly,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        enabled: enabled,
        onTap: onTap,
        initialValue: initialValue,
        readOnly: readOnly ?? false,
        controller: controller,
        style: const TextStyle(color: AppColors.black),
        inputFormatters: filteringTextInputFormatter,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: FocusNode(),
        decoration: InputDecoration(
          labelText: labelName,
          labelStyle: const TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold),
          hintStyle: const TextStyle(color: AppColors.greyColor),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.defaultPurple, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.defaultPurple, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.purple, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.redColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.redColor)),
        ));
  }
}
