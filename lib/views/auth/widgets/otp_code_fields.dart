import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bizreh_paints_store/utils/consts/colors.dart';

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
    // لصق مجموعة أرقام: توزيعها على الخانات
    if (value.length > 1) {
      // final chars = value.split('');
      // for (var j = 0; j < chars.length && index + j < _length; j++) {
      //   _controllers[index + j].text = chars[j];
      // }
      // // نقل التركيز للحقل التالي بعد آخر رقم تم لصقه
      // final next = (index + chars.length).clamp(0, _length - 1);
      // _nodes[next].requestFocus();
    } else {
      // الكتابة العادية: نقل التركيز للحقل التالي
      if (value.isNotEmpty && index < _length - 1) {
        _nodes[index + 1].requestFocus();
      }
      // الحذف: نقل التركيز للحقل السابق
      // if (value.isEmpty && index > 0) {
      //   _nodes[index - 1].requestFocus();
      // }
    }
    // تحديث الكود الحالي وإرسال الحالة
    final code = _controllers.map((e) => e.text).join();
    widget.onCompleted?.call(code);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_length, (i) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 45,
            height: 60,
            child: Focus(
              onKeyEvent: (node, event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (_controllers[i].text.isNotEmpty) {
                    // إذا كان الحقل الحالي غير فارغ، احذفه وابق التركيز فيه
                    _controllers[i].clear();
                    final code = _controllers.map((e) => e.text).join();
                    widget.onCompleted?.call(code);
                    setState(() {});
                    return KeyEventResult.handled;
                  } else if (i > 0) {
                    // إذا كان الحقل الحالي فارغ، انتقل للحقل السابق وامسحه
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
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
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
          );
        }),
      ),
    );
  }
}
