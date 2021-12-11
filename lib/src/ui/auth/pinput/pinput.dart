import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zet_gram/src/ui/auth/pinput/pinput_state.dart';

class PinPut extends StatefulWidget {
  const PinPut(
      {Key? key,
        required this.fieldsCount,
        this.onSubmit,
        this.onSaved,
        this.onChanged,
        this.onTap,
        this.onClipboardFound,
        this.controller,
        this.focusNode,
        this.preFilledWidget,
        this.separatorPositions = const [],
        this.separator = const SizedBox(width: 15.0),
        this.textStyle,
        this.submittedFieldDecoration,
        this.selectedFieldDecoration,
        this.followingFieldDecoration,
        this.disabledDecoration,
        this.eachFieldWidth,
        this.eachFieldHeight,
        this.fieldsAlignment = MainAxisAlignment.spaceBetween,
        this.eachFieldAlignment = Alignment.center,
        this.eachFieldMargin,
        this.eachFieldPadding,
        this.eachFieldConstraints =
        const BoxConstraints(minHeight: 61.0, minWidth: 50.0),
        this.inputDecoration = const InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          counterText: '',
        ),
        this.animationCurve = Curves.linear,
        this.animationDuration = const Duration(milliseconds: 160),
        this.pinAnimationType = PinAnimationType.slide,
        this.slideTransitionBeginOffset,
        this.enabled = true,
        this.checkClipboard = false,
        this.useNativeKeyboard = true,
        this.autofocus = false,
        this.autovalidateMode = AutovalidateMode.disabled,
        this.withCursor = false,
        this.cursor,
        this.keyboardAppearance,
        this.inputFormatters,
        this.validator,
        this.keyboardType = TextInputType.number,
        this.obscureText,
        this.textCapitalization = TextCapitalization.none,
        this.textInputAction,
        this.toolbarOptions,
        this.mainAxisSize = MainAxisSize.max,
        this.autofillHints})
      : assert(fieldsCount > 0),
        super(key: key);


  final int fieldsCount;

  final ValueChanged<String>? onSubmit;

  final FormFieldSetter<String>? onSaved;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onTap;

  final ValueChanged<String?>? onClipboardFound;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final Widget? preFilledWidget;

  final List<int> separatorPositions;

  final Widget separator;

  final TextStyle? textStyle;

  ///  Box decoration of following properties of [PinPut]
  ///  [submittedFieldDecoration] [selectedFieldDecoration] [followingFieldDecoration] [disabledDecoration]
  ///  You can customize every pixel with it
  ///  properties are being animated implicitly when value changes
  ///  ```dart
  ///  this.color,
  ///  this.image,
  ///  this.border,
  ///  this.borderRadius,
  ///  this.boxShadow,
  ///  this.gradient,
  ///  this.backgroundBlendMode,
  ///  this.shape = BoxShape.rectangle,
  ///  ```
  /// The decoration of each [PinPut] submitted field
  final BoxDecoration? submittedFieldDecoration;

  final BoxDecoration? selectedFieldDecoration;

  final BoxDecoration? followingFieldDecoration;

  final BoxDecoration? disabledDecoration;

  /// width of each [PinPut] field
  final double? eachFieldWidth;

  /// height of each [PinPut] field
  final double? eachFieldHeight;

  /// Defines how [PinPut] fields are being placed inside [Row]
  final MainAxisAlignment fieldsAlignment;

  /// Defines how each [PinPut] field are being placed within the container
  final AlignmentGeometry eachFieldAlignment;

  /// Empty space to surround the [PinPut] field container.
  final EdgeInsetsGeometry? eachFieldMargin;

  /// Empty space to inscribe the [PinPut] field container.
  /// For example space between border and text
  final EdgeInsetsGeometry? eachFieldPadding;

  /// Additional constraints to apply to the each field container.
  /// properties
  /// ```dart
  ///  this.minWidth = 0.0,
  ///  this.maxWidth = double.infinity,
  ///  this.minHeight = 0.0,
  ///  this.maxHeight = double.infinity,
  ///  ```
  final BoxConstraints eachFieldConstraints;

  /// The decoration to show around the text [PinPut].
  ///
  /// can be configured to show an icon, border,counter, label, hint text, and error text.
  /// set counterText to '' to remove bottom padding entirely
  final InputDecoration inputDecoration;

  /// curve of every [PinPut] Animation
  final Curve animationCurve;

  /// Duration of every [PinPut] Animation
  final Duration animationDuration;

  /// Animation Type of each [PinPut] field
  /// options:
  /// none, scale, fade, slide, rotation
  final PinAnimationType pinAnimationType;

  /// Begin Offset of ever [PinPut] field when [pinAnimationType] is slide
  final Offset? slideTransitionBeginOffset;

  /// Defines [PinPut] state
  final bool enabled;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// Whether we should check [Clipboard] data
  final bool checkClipboard;

  /// Whether we use Native keyboard or custom `Numpad`
  /// when flag is set to false [PinPut] wont be focusable anymore
  /// so you should set value of [PinPut]'s [TextEditingController] programmatically
  final bool useNativeKeyboard;

  final AutovalidateMode autovalidateMode;

  final bool withCursor;

  final Widget? cursor;

  final Brightness? keyboardAppearance;

  final List<TextInputFormatter>? inputFormatters;

  final FormFieldValidator<String>? validator;

  final TextInputType keyboardType;

  final String? obscureText;

  final TextCapitalization textCapitalization;

  final TextInputAction? textInputAction;

  final ToolbarOptions? toolbarOptions;

  final MainAxisSize mainAxisSize;

  final Iterable<String>? autofillHints;

  @override
  PinPutState createState() => PinPutState();
}

enum PinAnimationType {
  none,
  scale,
  fade,
  slide,
  rotation,
}