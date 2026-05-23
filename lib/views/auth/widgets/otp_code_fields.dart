import 'package:bizreh_paints_store/utils/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpCodeFields extends StatefulWidget {
  const OtpCodeFields({super.key, this.onCompleted});

  final ValueChanged<String>? onCompleted;

  @override
  State<OtpCodeFields> createState() => _OtpCodeFieldsState();
}

class _OtpCodeFieldsState extends State<OtpCodeFields> {
  final int _length = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_length, (_) => TextEditingController());
    _nodes = List.generate(_length, (_) => FocusNode());
    _nodes[0].requestFocus();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < _length - 1) {
      _nodes[index + 1].requestFocus();
    }

    final code = _controllers.map((e) => e.text).join();
    widget.onCompleted?.call(code);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 8.0;
          final totalSpacing = spacing * (_length - 1);
          final fieldWidth = ((constraints.maxWidth - totalSpacing) / _length)
              .clamp(30.0, 60.0);

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_length, (i) {
              return Padding(
                padding: EdgeInsetsDirectional.only(
                  end: i == _length - 1 ? 0 : spacing,
                ),
                child: SizedBox(
                  width: fieldWidth,
                  height: 60,
                  child: Focus(
                    onKeyEvent: (node, event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.backspace) {
                        if (_controllers[i].text.isNotEmpty) {
                          _controllers[i].clear();
                          final code = _controllers.map((e) => e.text).join();
                          widget.onCompleted?.call(code);
                          setState(() {});
                          return KeyEventResult.handled;
                        }

                        if (i > 0) {
                          _controllers[i - 1].clear();
                          _nodes[i - 1].requestFocus();
                          final code = _controllers.map((e) => e.text).join();
                          widget.onCompleted?.call(code);
                          setState(() {});
                          return KeyEventResult.handled;
                        }
                      }
                      return KeyEventResult.ignored;
                    },
                    child: TextField(
                      controller: _controllers[i],
                      focusNode: _nodes[i],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (v) => _onChanged(i, v),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
