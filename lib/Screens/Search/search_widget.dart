import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = const TextStyle(color: Colors.black);
    final styleHint = const TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Padding(
      padding:
          const EdgeInsets.only(top: 35.0, left: 20, right: 20, bottom: 40),
      child: TextField(
        enabled: true,
        controller: controller,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Dropdown',
              color: Color.fromARGB(255, 162, 58, 0)),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 15, right: 5),
            child: Icon(Icons.search, color: Color.fromARGB(255, 162, 58, 0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 162, 58, 0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 162, 58, 0)),
          ),
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
